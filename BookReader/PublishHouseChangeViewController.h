//
//  PublishHouseChangeViewController.h
//  BookReader
//
//  Created by Dmitriy Remezov on 20.10.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterViewViewController.h"

@interface PublishHouseChangeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    FilterViewViewController *filterView;
}

@property (retain) NSIndexPath *lastIndexPath;
@property (retain) NSMutableArray *PHArray;

@end
