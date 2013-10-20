//
//  AddBookViewController.h
//  BookReader
//
//  Created by Dmitriy Remezov on 19.09.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "MasterViewController.h"
#import "AppDelegate.h"


#import "DataSource.h"
@class PopoverViewController;

@protocol addProtocol <NSObject>

- (void) unlockButton;

@end

@interface AddBookViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIActionSheetDelegate>
@property (nonatomic, unsafe_unretained) id<addProtocol> masterDelegate;
@property PopoverViewController *authorPopover;
@property (nonatomic, strong) UIPopoverController *imagePopoverController;
@property (nonatomic, strong) UIPopoverController *authorPopoverController;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UIButton *addAuthorButton;

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *yearTextField;
@property (weak, nonatomic) IBOutlet UITextField *publisherHouse;

@property (weak, nonatomic) IBOutlet UIButton *genreButton;
@property (weak, nonatomic) IBOutlet UIButton *addImageButton;
- (IBAction)addImageAction:(id)sender;
@property UIImagePickerController *pickerController;
@property UIImage *filmImage;
@property (weak, nonatomic) IBOutlet UIImageView *editImage;

@property NSData *imageData;

- (IBAction)closeView:(id)sender;
- (IBAction)saveBook;

- (IBAction)addAuthor:(id)sender;
- (IBAction)addYear:(id)sender;
- (IBAction)addGenre:(id)sender;

@end
