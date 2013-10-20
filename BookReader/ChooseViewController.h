//
//  ChooseViewController.h
//  BookReader
//
//  Created by Dmitriy Remezov on 18.10.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterViewViewController.h"

@interface ChooseViewController : UIViewController <UITextFieldDelegate>
{
    FilterViewViewController *filterView;
}
@property (weak, nonatomic) IBOutlet UITextField *fromTextField;
@property (weak, nonatomic) IBOutlet UITextField *toTextField;

- (void) doneButtonPressed;

@end
