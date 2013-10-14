//
//  AddPartViewController.m
//  BookReader
//
//  Created by Dmitriy Remezov on 08.10.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import "AddPartViewController.h"

@interface AddPartViewController ()

@end

@implementation AddPartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) setBook:(NSString *)book
{
    self.bookTO = book;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _data = [(AppDelegate *)[[UIApplication sharedApplication] delegate] data];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SavePart:(id)sender
{
    [_data addBPart:self.bookTO.name number:@"0" title:self.partTitleTextField.text desc:self.partDescription.text];
    MasterViewController *navigationControllerMaster = [[[self.splitViewController.viewControllers objectAtIndex:0] viewControllers] objectAtIndex:0];
    [navigationControllerMaster.tableView reloadData];
    
}
@end
