//
//  DetailViewController.m
//  BookReader
//
//  Created by Dmitriy Remezov on 16.09.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import "DetailViewController.h"
#import "BookCollectionViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize toolBar, navItem, button, albumMode;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {}
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    self.partTable.hidden = YES;
    self.addPartButton.enabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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


- (void) didSelectBook:(BookS *)book
{
    self.addPartButton.enabled = YES;
    self.books = book;
    self.bookTitle = book.name;
    if ([[self.books part] count] >0)
    {
        self.label.text = book.name;
        self.partTable.hidden = NO;
        [self.partTable reloadData];
    }else if ([[self.books part] count] == 0)
    {
        [self.partTable reloadData];
        self.partTable.hidden = YES;
        self.image.hidden = YES;
        self.label.text = @"Для добавления главы книги нажмите + в верхнем правом углу приложения";
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.books part] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cellPart";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [[[[[self.books part] allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]]] objectAtIndex:indexPath.row] title];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.partOfBook = [[[[self.books part] allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]]] objectAtIndex:[[self.partTable indexPathForSelectedRow] row]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    PartViewController *controller = (PartViewController *)[storyboard instantiateViewControllerWithIdentifier:@"partDescriptionView"];
    controller.parttt = self.partOfBook;
    NSLog(@"%@", [self.navigationController.viewControllers lastObject]);
    [self.navigationController pushViewController:controller animated:YES];
    
    MasterViewController *navigationControllerMaster = [[[self.splitViewController.viewControllers objectAtIndex:0] viewControllers] objectAtIndex:0];
    [navigationControllerMaster setChange:YES];
    [navigationControllerMaster setSelectBook:self.books];
    [navigationControllerMaster.tableView reloadData];
}

-(void) goToMain
{
    self.partTable.hidden = YES;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) addNewBook
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"blockButton" object:self];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    AddBookViewController *addBookViewController = (AddBookViewController *)[storyboard instantiateViewControllerWithIdentifier:@"first"];
    [self.navigationController presentModalViewController:addBookViewController animated:YES];
}

-(void) showPart:(Part *)part
{
    self.partOfBook = part;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    PartViewController *controller = (PartViewController *)[storyboard instantiateViewControllerWithIdentifier:@"partDescriptionView"];
    controller.parttt = self.partOfBook;
    if ([[self.navigationController.viewControllers lastObject] isMemberOfClass:[PartViewController class]])
    {
        [self.navigationController popViewControllerAnimated:NO];
        [self.navigationController pushViewController:controller animated:NO];
    }    
    
    MasterViewController *navigationControllerMaster = [[[self.splitViewController.viewControllers objectAtIndex:0] viewControllers] objectAtIndex:0];
    [navigationControllerMaster setChange:YES];
    [navigationControllerMaster setSelectBook:self.books];
    [navigationControllerMaster.tableView reloadData];

}

- (IBAction)addPart:(id)sender
{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    AddPartViewController *addPartViewController = (AddPartViewController *)[storyboard instantiateViewControllerWithIdentifier:@"addPartView"];
    
    addPartViewController.bookTO = self.books;
    [self.navigationController pushViewController:addPartViewController animated:YES];
    
}

- (void) changeDetail:(id)controller
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    BookCollectionViewController *detailController = (BookCollectionViewController *)[storyboard instantiateViewControllerWithIdentifier:@"BookCollectionController"];
    [controller setDetailDelegate:detailController];
    self.splitViewController.delegate = detailController;
    self.navigationController.viewControllers = [NSArray arrayWithObject:detailController];

}
@end
