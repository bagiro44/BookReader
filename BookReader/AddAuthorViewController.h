//
//  AddAuthorViewController.h
//  BookReader
//
//  Created by Dmitriy Remezov on 14.10.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddAuthorViewController : UIViewController
- (IBAction)cancelAction:(id)sender;
- (IBAction)saveAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *authorNameTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveAuthor;

@end
