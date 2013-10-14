//
//  PartViewController.h
//  BookReader
//
//  Created by Dmitriy Remezov on 08.10.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Part.h"
#import "BookS.h"

@interface PartViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *partDescription;
@property Part *parttt;
@property BookS *bookToPart;

@end
