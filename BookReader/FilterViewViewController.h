//
//  FilterViewViewController.h
//  BookReader
//
//  Created by Dmitriy Remezov on 18.10.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RangeSlider.h"

@protocol filterProtocol <NSObject>

- (void) FilterResultArrayInit:(NSMutableArray *)array;

@end

@interface FilterViewViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property RangeSlider *slider;
@property (nonatomic, unsafe_unretained) id<filterProtocol> masterDelegate;
@property (weak, nonatomic) IBOutlet UITextField *authorTextField;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITableView *publishingHouseTable;
@property (weak, nonatomic) IBOutlet UITableView *accuracyTableView;
@property (weak, nonatomic) IBOutlet UILabel *minimalRangeValue;
@property (weak, nonatomic) IBOutlet UILabel *maximumRangeValue;
@property NSString *PHName;

- (IBAction)clearValues:(id)sender;
- (IBAction)applyFilter:(id)sender;
- (void)report:(RangeSlider *)sender;

@end
