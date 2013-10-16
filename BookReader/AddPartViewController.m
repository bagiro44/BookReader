//
//  AddPartViewController.m
//  BookReader
//
//  Created by Dmitriy Remezov on 08.10.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import "AddPartViewController.h"
#import "DetailViewController.h"
#import "BookCollectionViewController.h"

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
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
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
    BOOL success = YES;
    for (Part *item in [self.bookTO part])
    {
        if ([item.title isEqualToString:self.partTitleTextField.text])
        {
            UIAlertView *deleteAlert = [[UIAlertView alloc]
                                        initWithTitle:@"Ошибка"
                                        message:@"Глава с таким названием уже существует в книге"
                                        delegate:nil cancelButtonTitle:@"ОК" otherButtonTitles:nil, nil];
            [deleteAlert show];
            success = NO;
            break;
        }
    }if (success)
    {
        [_data addBPart:self.bookTO.name number:@"0" title:self.partTitleTextField.text desc:self.partDescription.text];
        if(self.itIscollectionView)
        {
            MasterViewController *navigationControllerMaster = [[[self.splitViewController.viewControllers objectAtIndex:0] viewControllers] objectAtIndex:0];
            [navigationControllerMaster.tableView reloadData];
        }else
        {
            DetailViewController *navigationControllerMaster = [[[self.splitViewController.viewControllers lastObject] viewControllers] objectAtIndex:0];
            [navigationControllerMaster.partTable setHidden:NO];
            [navigationControllerMaster.partTable reloadData];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void) textViewDidBeginEditing:(UITextView *)textView {
    CGRect viewFrame = self.partDescription.frame;
    CGRect viewFrameButton = self.buttonFrame.frame;
    viewFrame.size.height += -352;  /*specify the points to move the view up*/
    viewFrameButton.size.height += -352;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:-10];
    
    [self.partDescription setFrame:viewFrame];
    [self.buttonFrame setFrame:viewFrameButton];
    
    [UIView commitAnimations];
}

- (void) textViewDidEndEditing:(UITextView *)textView
{
    CGRect viewFrame = self.partDescription.frame;
    CGRect viewFrameButton = self.buttonFrame.frame;
    viewFrame.size.height += 352; 
    viewFrameButton.size.height += 352;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:-10];
    
    [self.partDescription setFrame:viewFrame];
    [self.buttonFrame setFrame:viewFrameButton];
    
    [UIView commitAnimations];
    [textView resignFirstResponder];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if ([self.partDescription isFirstResponder] && [touch view] != self.partDescription)
    {[self.partDescription resignFirstResponder];}
    else if ([self.partTitleTextField isFirstResponder] && [touch view] != self.partTitleTextField)
    {[self.partTitleTextField resignFirstResponder];}
    [super touchesBegan:touches withEvent:event];
}
@end
