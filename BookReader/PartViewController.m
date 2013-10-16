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
}

- (void) viewWillDisappear:(BOOL)animated {
    
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"unBlockButton" object:self];
         DetailViewController *navigationControllerMaster1 = [[[self.splitViewController.viewControllers lastObject] viewControllers] objectAtIndex:0];
        [navigationControllerMaster1.partTable reloadData];
        MasterViewController *navigationControllerMaster = [[[self.splitViewController.viewControllers objectAtIndex:0] viewControllers] objectAtIndex:0];
        [navigationControllerMaster setChange:NO];
        [navigationControllerMaster setSelectBook:nil];
        [navigationControllerMaster.tableView reloadData];
        [navigationControllerMaster.detailDelegate goToMain];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
