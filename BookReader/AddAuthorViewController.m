//
//  AddAuthorViewController.m
//  BookReader
//
//  Created by Dmitriy Remezov on 14.10.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import "AddAuthorViewController.h"
#import "AppDelegate.h"

@interface AddAuthorViewController ()

@end

@implementation AddAuthorViewController

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
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveAction:(id)sender
{
    DataSource *data = [(AppDelegate *)[[UIApplication sharedApplication] delegate] data];
    [data addAuthor:self.authorNameTextField.text];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTable" object:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"unBlockButton" object:self];

    [self.navigationController popViewControllerAnimated:YES];
}



- (void) viewWillDisappear:(BOOL)animated
{
    
    
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"unBlockButton" object:self];
    }
}

@end
