//
//  PartViewController.m
//  BookReader
//
//  Created by Dmitriy Remezov on 08.10.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import "PartViewController.h"
#import "MasterViewController.h"
#import "DetailViewController.h"
#import "BookCollectionViewController.h"


@interface PartViewController ()

@end

@implementation PartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"blockButton" object:self];
    self.navigationItem.title = self.parttt.title;
    self.partDescription.text = self.parttt.descriptionpart;
    MasterViewController *navigationControllerMaster = [[[self.splitViewController.viewControllers objectAtIndex:0] viewControllers] objectAtIndex:0];
    [navigationControllerMaster.searchDisplayController setActive:NO animated:YES];
    navigationControllerMaster.tableView.contentOffset = CGPointMake(0,0);
    navigationControllerMaster.tableView.tableHeaderView = nil;
}

- (void) viewWillDisappear:(BOOL)animated {
    
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"unBlockButton" object:self];
        MasterViewController *navigationControllerMaster = [[[self.splitViewController.viewControllers objectAtIndex:0] viewControllers] objectAtIndex:0];
        [navigationControllerMaster setChange:NO];
        [navigationControllerMaster setSelectBook:nil];
        [navigationControllerMaster.navigationItem setTitle:@""];
        [navigationControllerMaster.tableView reloadData];
        
        DetailViewController *navigationControllerMaster1 = [[[self.splitViewController.viewControllers lastObject] viewControllers] objectAtIndex:0];
        if([navigationControllerMaster1 isMemberOfClass:[DetailViewController class]])
        {
            [navigationControllerMaster1.partTable reloadData];
            navigationControllerMaster.tableView.contentOffset = CGPointMake(0, navigationControllerMaster.searchDisplayController.searchBar.frame.size.height);
            navigationControllerMaster.tableView.tableHeaderView = navigationControllerMaster.searchBar;
            [navigationControllerMaster.searchDisplayController setActive:NO animated:YES];
        }
        else
        {
            BookCollectionViewController *navigationControllerMaster1 = [[[self.splitViewController.viewControllers lastObject] viewControllers] objectAtIndex:0];
            navigationControllerMaster1.canIAddPart = NO;
            navigationControllerMaster1.BookCollection.hidden = NO;
            //navigationControllerMaster.tableView.contentOffset = CGPointMake(0, 0);
            //navigationControllerMaster.tableView.tableHeaderView = nil;
            [navigationControllerMaster.searchDisplayController setActive:NO animated:YES];
        }

        //[navigationControllerMaster.detailDelegate goToMain];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
