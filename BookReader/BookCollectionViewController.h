//
//  BookCollectionViewController.h
//  BookReader
//
//  Created by Dmitriy Remezov on 11.10.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterViewController.h"
#import "Author.h"
#import "BookS.h"


@interface BookCollectionViewController : UIViewController <UISplitViewControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, Booking>
{
    UIPopoverController *masterPopoverController;
}

@property Author *author;
@property (weak, nonatomic) IBOutlet UICollectionView *BookCollection;
- (IBAction)addBook:(id)sender;

@end
