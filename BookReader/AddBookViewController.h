//
//  AddBookViewController.h
//  BookReader
//
//  Created by Dmitriy Remezov on 19.09.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterViewController.h"
#import "PopoverViewController.h"

@protocol addProtocol <NSObject>

- (void) unlockButton;

@end

@interface AddBookViewController : UIViewController

@property (nonatomic, unsafe_unretained) id<addProtocol> masterDelegate;


@property (weak, nonatomic) IBOutlet UIButton *addAuthorButton;

- (IBAction)saveBook;
- (IBAction)addAuthor:(id)sender;

@end
