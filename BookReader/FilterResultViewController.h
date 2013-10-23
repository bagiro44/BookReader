//
//  FilterResultViewController.h
//  BookReader
//
//  Created by Dmitriy Remezov on 21.10.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterViewController.h"
//#import "DetailViewController.h"

@interface FilterResultViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property NSMutableArray *resultArray;
@end
