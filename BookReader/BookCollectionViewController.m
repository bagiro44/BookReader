//
//  BookCollectionViewController.m
//  BookReader
//
//  Created by Dmitriy Remezov on 11.10.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import "BookCollectionViewController.h"
#import "BookCollectionCell.h"
#import "DetailViewController.h"
#import "PartViewController.h"

@interface BookCollectionViewController ()

@end

@implementation BookCollectionViewController
@synthesize author;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper50.jpeg"]];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didLogPressCellToDelete:)];
    longPress.delegate = self;
    [self.BookCollection addGestureRecognizer:longPress];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"reloadTable" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkRes:) name:@"reloadTable"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"reloadTableAfterDel" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkRes:) name:@"reloadTableAfterDel"
                                               object:nil];
}
-(void)checkRes:(NSNotification *)notification
{
    if ([[notification name] isEqualToString:@"reloadTable"])
    {
        [self.BookCollection reloadData];
    }
    if ([[notification name] isEqualToString:@"reloadTableAfterDel"])
    {
        [self.BookCollection reloadData];
    }
}

- (void) splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{
    NSLog(@"willHideViewController");
    
    barButtonItem.title = @"Book";
    [[self navigationItem] setLeftBarButtonItem:barButtonItem animated:YES];
    
    masterPopoverController = pc;
}

- (void) splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    NSLog(@"willHideViewController");
    [[self navigationItem] setLeftBarButtonItem:nil animated:YES];
    
    masterPopoverController = nil;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([[self.author book] count] == 0) {self.BookCollection.hidden = YES;}else{self.BookCollection.hidden = NO;}
    return [[self.author book] count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BookCollectionCell *cell = (BookCollectionCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"BookCellColelction" forIndexPath:indexPath];
    BookS *tempBook = [[[[self.author book] allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]] objectAtIndex:indexPath.row];
    cell.imageBook.image = [UIImage imageWithData:tempBook.image];
    cell.titleBook.text = tempBook.name;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MasterViewController *navigationControllerMaster = [[[self.splitViewController.viewControllers objectAtIndex:0] viewControllers] objectAtIndex:0];
    [navigationControllerMaster setChange:YES];
    navigationControllerMaster.tableView.tableHeaderView = nil;
    [navigationControllerMaster.navigationItem setTitle:[NSString stringWithFormat:@"%@",[[[[[self.author book] allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]]objectAtIndex:indexPath.row] name]]];
    self.bookToAddPArt = [[[[self.author book] allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]]objectAtIndex:indexPath.row];
    [navigationControllerMaster setSelectBook:self.bookToAddPArt];
    [navigationControllerMaster.tableView reloadData];
    self.BookCollection.hidden = YES;
    self.canIAddPart = YES;
}

- (void)didLogPressCellToDelete:(UILongPressGestureRecognizer*)gesture {
    CGPoint tapLocation = [gesture locationInView:self.BookCollection];
    NSIndexPath *indexPath = [self.BookCollection indexPathForItemAtPoint:tapLocation];
    if (indexPath && gesture.state == UIGestureRecognizerStateBegan) {
        self.deletedIndexpath = indexPath;
                UIAlertView *deleteAlert = [[UIAlertView alloc]
                                    initWithTitle:@"Удалить?"
                                    message:@"Вы уверены что хотите удалить эту книгу?"
                                    delegate:self cancelButtonTitle:@"Отменить" otherButtonTitles:@"Да", nil];
        [deleteAlert show];
        
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[(AppDelegate *)[[UIApplication sharedApplication] delegate] data] deleteBook:[[[[self.author book] allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]] objectAtIndex:self.deletedIndexpath.row]];
        [self.BookCollection reloadData];
    }
}


-(void) showPart:(Part *)part
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    PartViewController *controller = (PartViewController *)[storyboard instantiateViewControllerWithIdentifier:@"partDescriptionView"];
    controller.parttt = part;
    if ([[self.navigationController.viewControllers lastObject] isMemberOfClass:[PartViewController class]])
    {
        [self.navigationController popViewControllerAnimated:NO];
        [self.navigationController pushViewController:controller animated:NO];
    }else{
        [self.navigationController pushViewController:controller animated:NO];
    }
    
    MasterViewController *navigationControllerMaster = [[[self.splitViewController.viewControllers objectAtIndex:0] viewControllers] objectAtIndex:0];
    [navigationControllerMaster setChange:YES];
    [navigationControllerMaster.tableView reloadData];
    
}
- (void) didSelectAuthor:(Author *)auth
{
    self.BookCollection.hidden = NO;
    self.author = auth;
    [self.BookCollection reloadData];
}

- (void) changeDetail:(id)controller
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    DetailViewController *detailController = (DetailViewController *)[storyboard instantiateViewControllerWithIdentifier:@"detailView"];
    [controller setDetailDelegate:detailController];
    self.splitViewController.delegate = detailController;
    self.navigationController.viewControllers = [NSArray arrayWithObject:detailController];
}



- (void) addAuthor
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"blockButton" object:self];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        AddBookViewController *addBookViewController = (AddBookViewController *)[storyboard instantiateViewControllerWithIdentifier:@"addAuthor"];
        //[self.navigationController presentModalViewController:addBookViewController animated:YES];
        [self.navigationController pushViewController:addBookViewController animated:YES];
}
- (IBAction)addBook:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"blockButton" object:self];
    if(self.canIAddPart)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        AddPartViewController *addBookViewController = (AddPartViewController *)[storyboard instantiateViewControllerWithIdentifier:@"addPartView"];
        addBookViewController.itIscollectionView = YES;
        addBookViewController.bookTO = self.bookToAddPArt;
        [self.navigationController pushViewController:addBookViewController animated:YES];
    }else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        AddBookViewController *addBookViewController = (AddBookViewController *)[storyboard instantiateViewControllerWithIdentifier:@"first"];
        [self.navigationController presentModalViewController:addBookViewController animated:YES];
    }
}

-(void) goToMain
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"unBlockButton" object:self];
    MasterViewController *navigationControllerMaster = [[[self.splitViewController.viewControllers objectAtIndex:0] viewControllers] objectAtIndex:0];
    [navigationControllerMaster.navigationItem setTitle:@""];
    self.canIAddPart = NO;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
