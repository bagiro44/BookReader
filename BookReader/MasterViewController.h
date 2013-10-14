//
//  MasterViewController.h
//  BookReader
//
//  Created by Dmitriy Remezov on 16.09.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddBookViewController.h"
#import "BookS.h"
#import "Part.h"
#import "AddAuthorViewController.h"
@class AlbumAuthorViewController;

@protocol Booking <NSObject>
@optional
-(void) addNewBook;
-(void) addAuthor;
-(void) didSelectBook:(BookS *)book;
-(void) didSelectAuthor:(Author *)auth;
-(void) showPart:(Part *)part;
-(void) showBookAlbum:(Author *)author;
-(void) changeDetail:(id)controller;
-(void) goToMain;
@end


@interface MasterViewController : UITableViewController
{
    NSMutableArray *books;
}
- (IBAction)AddBook:(id)sender;
- (void) changeSource:(NSNumber *)numberOfChange;
- (IBAction)mainView:(id)sender;
@property BOOL *change;
@property BOOL *albumMode;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addBookButton;
@property (nonatomic, unsafe_unretained) id<Booking> detailDelegate;
@property (nonatomic, strong) NSArray *authorS;
@property (nonatomic, weak) NSMutableArray *books;
@property AddAuthorViewController *authorPopover;
@property (nonatomic, strong) UIPopoverController *authorPopoverController;

- (IBAction)testAction:(id)sender;
@property BookS *selectBook;

@end
