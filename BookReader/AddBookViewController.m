//
//  AddBookViewController.m
//  BookReader
//
//  Created by Dmitriy Remezov on 19.09.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import "AddBookViewController.h"
#import "PopoverViewController.h"

@interface AddBookViewController ()


@end

@implementation AddBookViewController
@synthesize addAuthorButton, fetchedResultsController, managedObjectContext, authorPopoverController, authorPopover;

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
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"save"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(saveBook)];
    self.navigationItem.rightBarButtonItem = saveButton;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)saveBook
{
    DataSource *data = [(AppDelegate *)[[UIApplication sharedApplication] delegate] data];
    //[data addBPart:self.yearTextField.text number:self.name.text title:nil desc:nil];
    [data addBook:self.addAuthorButton.titleLabel.text year:self.yearTextField.text genre:self.genreButton.titleLabel.text name:self.name.text];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"unBlockButton" object:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTable" object:self];
    
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)closeView:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"unBlockButton" object:self];
    [self dismissModalViewControllerAnimated:YES];
}

- (void) chooseAuthor:(NSString *)authorName numberOfChoise:(NSNumber*)numberOfChoise
{
    switch ([numberOfChoise integerValue])
    {
        case 0:
            self.addAuthorButton.titleLabel.text = authorName;
            break;
        case 1:
            self.genreButton.titleLabel.text = authorName;
            break;
        default:
            break;
    }
    
}

- (IBAction)addAuthor:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    authorPopover = (PopoverViewController *)[storyboard instantiateViewControllerWithIdentifier:@"authorPopover"];
    authorPopover.delegate = self;
    authorPopover.numberOfChoise = [NSNumber numberWithInteger:0];
    authorPopoverController = [[UIPopoverController alloc] initWithContentViewController:authorPopover];
    
    if ([authorPopoverController isPopoverVisible])
    {
        [authorPopoverController dismissPopoverAnimated:YES];
    } else
    {
        CGRect popRect = CGRectMake(self.addAuthorButton.frame.origin.x,
                                    self.addAuthorButton.frame.origin.y,
                                    self.addAuthorButton.frame.size.width,
                                    self.addAuthorButton.frame.size.height);
        [authorPopoverController presentPopoverFromRect:popRect
                                                 inView:self.view
                               permittedArrowDirections:UIPopoverArrowDirectionAny
                                               animated:YES];
    }
}

- (IBAction)addGenre:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    authorPopover = (PopoverViewController *)[storyboard instantiateViewControllerWithIdentifier:@"authorPopover"];
    authorPopover.delegate = self;
    authorPopover.numberOfChoise = [NSNumber numberWithInteger:1];
    authorPopoverController = [[UIPopoverController alloc] initWithContentViewController:authorPopover];
    
    if ([authorPopoverController isPopoverVisible])
    {
        [authorPopoverController dismissPopoverAnimated:YES];
    } else
    {
        CGRect popRect = CGRectMake(self.genreButton.frame.origin.x,
                                    self.genreButton.frame.origin.y,
                                    self.genreButton.frame.size.width,
                                    self.genreButton.frame.size.height);
        [authorPopoverController presentPopoverFromRect:popRect
                                                 inView:self.view
                               permittedArrowDirections:UIPopoverArrowDirectionAny
                                               animated:YES];
    }
}

- (void) viewWillDisappear:(BOOL)animated
{
    
    
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"unBlockButton" object:self];
    }
}


@end
