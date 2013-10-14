//
//  PopoverViewController.h
//  BookReader
//
//  Created by Dmitriy Remezov on 26.09.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataSource.h"
#import "AppDelegate.h"

@protocol author <NSObject>

@optional

- (void) chooseAuthor:(NSString *)authorName numberOfChoise:(NSNumber *)numberOfChoise;

@end

@interface PopoverViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, weak) id<author> delegate;
@property (nonatomic, weak) NSNumber *numberOfChoise;
- (IBAction)addGenre:(id)sender;
- (IBAction)showAddGenreView:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *showAddGenreButton;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;

@property DataSource *data;
@property (weak, nonatomic) IBOutlet UILabel *addGenreLabel;
@property (weak, nonatomic) IBOutlet UITextField *addGenreTextField;
@property (weak, nonatomic) IBOutlet UIButton *addGenreButton;
@property NSArray *authorArray;
@property NSString *authorName;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;

@end
