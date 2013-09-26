//
//  AddBookViewController.m
//  BookReader
//
//  Created by Dmitriy Remezov on 19.09.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import "AddBookViewController.h"

@interface AddBookViewController ()
{
    PopoverViewController *controller;
    UIPopoverController *popoverController;
}

@end

@implementation AddBookViewController
@synthesize addAuthorButton;

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
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"save"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(saveBook)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    AddBookViewController *controller = (AddBookViewController *)[storyboard instantiateViewControllerWithIdentifier:@"popover"];

    popoverController = [[UIPopoverController alloc] initWithContentViewController:controller];


}

- (void) viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"unBlockButton" object:self];
    NSLog(@"закрыл вкладку");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveBook
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"unBlockButton" object:self];
    NSLog(@"сохранил книгу");
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"blockButton" object:self];
}

- (IBAction)addAuthor:(id)sender
{
    if ([popoverController isPopoverVisible])
    {
        [popoverController dismissPopoverAnimated:YES];
    }
    else
    {
        CGRect popRect = CGRectMake(self.addAuthorButton.frame.origin.x,
                                    self.addAuthorButton.frame.origin.y,
                                    self.addAuthorButton.frame.size.width,
                                    self.addAuthorButton.frame.size.height);
        [popoverController presentPopoverFromRect:popRect
                                           inView:self.view
                         permittedArrowDirections:UIPopoverArrowDirectionAny
                                         animated:YES];
    }
}

@end
