//
//  AddPartViewController.h
//  BookReader
//
//  Created by Dmitriy Remezov on 08.10.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DataSource.h"
#import "BookS.h"

@protocol addPartProtocol <NSObject>
@optional
- (void) reloadDataInTable;

@end

@interface AddPartViewController : UIViewController

@property BookS *bookTO;
@property (weak, nonatomic) IBOutlet UITextField *partTitleTextField;
@property (weak, nonatomic) IBOutlet UITextView *partDescription;
@property DataSource *data;
- (IBAction)SavePart:(id)sender;

@end
