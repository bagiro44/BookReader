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
    NSLog(@"BookCollectionViewController %@", self.splitViewController.viewControllers);
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(void) goToMain
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[self.author book] count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BookCollectionCell *cell = (BookCollectionCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"BookCellColelction" forIndexPath:indexPath];
    cell.titleBook.text = [[[[[self.author book] allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]] objectAtIndex:indexPath.row] name];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    /*self.partOfBook = [[[self.books part] allObjects] objectAtIndex:[[self.partTable indexPathForSelectedRow] row]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    PartViewController *controller = (PartViewController *)[storyboard instantiateViewControllerWithIdentifier:@"partDescriptionView"];
    controller.parttt = self.partOfBook;
    NSLog(@"%@", [self.navigationController.viewControllers lastObject]);
    [self.navigationController pushViewController:controller animated:YES];*/
    
    MasterViewController *navigationControllerMaster = [[[self.splitViewController.viewControllers objectAtIndex:0] viewControllers] objectAtIndex:0];
    [navigationControllerMaster setChange:YES];
    [navigationControllerMaster setSelectBook:[[[[self.author book] allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]]objectAtIndex:indexPath.row]];
    [navigationControllerMaster.tableView reloadData];
}

-(void) showPart:(Part *)part
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    PartViewController *controller = (PartViewController *)[storyboard instantiateViewControllerWithIdentifier:@"partDescriptionView"];
    controller.parttt = part;
    if ([[self.navigationController.viewControllers lastObject] isMemberOfClass:[PartViewController class]])
    {
        [self.navigationController popViewControllerAnimated:NO];
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    MasterViewController *navigationControllerMaster = [[[self.splitViewController.viewControllers objectAtIndex:0] viewControllers] objectAtIndex:0];
    [navigationControllerMaster setChange:YES];
    //[navigationControllerMaster setSelectBook:self.books];
    [navigationControllerMaster.tableView reloadData];
    
}
- (void) didSelectAuthor:(Author *)auth
{
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
@end
