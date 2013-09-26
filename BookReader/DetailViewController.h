//
//  DetailViewController.h
//  BookReader
//
//  Created by Dmitriy Remezov on 16.09.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterViewController.h"

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate, Booking, UITableViewDataSource, UITableViewDelegate>
{
    UIPopoverController *masterPopoverController;
}

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *button;

@property (weak, nonatomic) IBOutlet UITableView *partTable;

@end
