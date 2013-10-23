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
#import "FilterViewViewController.h"
#import "FilterResultViewController.h"
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


@interface MasterViewController : UITableViewController<UISearchDisplayDelegate, UISearchBarDelegate, filterProtocol>
{
    NSMutableArray *books;
}

- (void) changeSearchMode:(NSString *)mode;
- (IBAction)AddBook:(id)sender;
- (void) changeSource:(NSNumber *)numberOfChange;
- (IBAction)mainView:(id)sender;
@property UIButton *showFilterButton;
@property UIPopoverController *FilterPopoverController;
@property FilterViewViewController *filterView;
@property BOOL *change;
@property BOOL *filterResult;
@property BOOL *albumMode;
@property UISearchBar *searchBar;
@property UISearchDisplayController *searchDisplayController;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addBookButton;
@property (nonatomic, unsafe_unretained) id<Booking> detailDelegate;
@property (nonatomic, strong) NSMutableArray *authorS;
@property (nonatomic, strong) NSMutableArray *books;
@property (nonatomic, retain) NSMutableArray *searchResults;
@property (nonatomic, retain) NSMutableArray *filterResultArray;
@property AddAuthorViewController *authorPopover;
@property (nonatomic, strong) UIPopoverController *authorPopoverController;

- (IBAction)showFilter:(id)sender;
@property BookS *selectBook;

@end
