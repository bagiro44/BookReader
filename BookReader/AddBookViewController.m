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

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if ([self.name isFirstResponder] && [touch view] != self.name)
    {[self.name resignFirstResponder];}
    else if ([self.yearTextField isFirstResponder] && [touch view] != self.yearTextField)
    {[self.yearTextField resignFirstResponder];}
    [super touchesBegan:touches withEvent:event];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.pickerController = [[UIImagePickerController alloc] init];
    self.pickerController.allowsImageEditing = NO;
    self.pickerController.delegate = self;
    self.pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
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
    
    UIAlertView *alertView2 = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Неверный формат ввода года (Пример верного ввода: 1985)" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    if (([self.yearTextField.text intValue] && self.yearTextField.text.length == 4) || self.yearTextField.text.length == 0)
    {
        if (![self.addAuthorButton.titleLabel.text isEqualToString:@"Выберите автора..."])
        {
            DataSource *data = [(AppDelegate *)[[UIApplication sharedApplication] delegate] data];
            if (![data addBook:self.addAuthorButton.titleLabel.text year:self.yearTextField.text genre:self.genreButton.titleLabel.text name:self.name.text image:self.imageData])
            {
                UIAlertView *deleteAlert = [[UIAlertView alloc]
                                            initWithTitle:@"Ошибка"
                                            message:@"Книга с таким названием уже существует у автора"
                                            delegate:nil cancelButtonTitle:@"ОК" otherButtonTitles:nil, nil];
                [deleteAlert show];
            }
            else
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"unBlockButton" object:self];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTable" object:self];
                [self dismissModalViewControllerAnimated:YES];
            }
        }else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Не указан автор книги..." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView show];
        }
    }
    else
    {
        [alertView2 show];
    }    
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


- (IBAction)addImageAction:(id)sender
{
    self.pickerController.delegate = self;
    self.imagePopoverController=[[UIPopoverController alloc] initWithContentViewController:self.pickerController];
    self.imagePopoverController.delegate=self;
    [self.imagePopoverController presentPopoverFromRect:((UIButton *)sender).bounds inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //[self dismissModalViewControllerAnimated:YES];
    self.filmImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    self.editImage.image = self.filmImage;
    self.imageData = UIImagePNGRepresentation(self.filmImage);
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
