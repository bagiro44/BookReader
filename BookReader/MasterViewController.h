//
//  MasterViewController.h
//  BookReader
//
//  Created by Dmitriy Remezov on 16.09.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddBookViewController.h"
#import "Book.h"

@protocol Booking <NSObject>
@optional
-(void) addNewBook;
-(void) didSelectBook:(Book *)book;
@end


@interface MasterViewController : UITableViewController
{
    NSMutableArray *books;
}
- (IBAction)AddBook:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addBookButton;
@property (nonatomic, unsafe_unretained) id<Booking> detailDelegate;

@end
