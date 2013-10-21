//
//  MasterViewController.m
//  BookReader
//
//  Created by Dmitriy Remezov on 16.09.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import "MasterViewController.h"
#import "BookS.h"
#import "DataSource.h"
#import "AppDelegate.h"
@interface MasterViewController ()

@end

@implementation MasterViewController

@synthesize detailDelegate, authorS, change, selectBook, albumMode, searchBar, searchDisplayController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    //self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bookBackground.png"]];
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper50.jpeg"]];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"blockButton" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkRes:) name:@"blockButton"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"unBlockButton" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkRes:) name:@"unBlockButton"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"reloadTable" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkRes:) name:@"reloadTable"
                                               object:nil];    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSUserDefaultsDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(defaultsChanged:)
                                                 name:NSUserDefaultsDidChangeNotification
                                               object:nil];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *mode = [defaults objectForKey:@"showController"];
    if ([mode isEqual:@"0"])
    {
        albumMode = NO;
        if (change == NO)
        {
            searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 40, 320, 44)];
            searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
            
            searchDisplayController.delegate = self;
            searchDisplayController.searchResultsDataSource = self;
            searchDisplayController.searchResultsDelegate = self;
            self.tableView.contentOffset = CGPointMake(0, self.searchDisplayController.searchBar.frame.size.height);
            UIView *headerViewToAdd = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 90)];
            
            UIButton *showFilterButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [showFilterButton addTarget:self
                       action:@selector(showFilter:)
             forControlEvents:UIControlEventTouchUpInside];
            
            [showFilterButton setTitle:@" Фильтр " forState:UIControlStateNormal];
            showFilterButton.frame = CGRectMake(0, 0, 320, 40.0);
            //UIButton *showFilter = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 200, 44)];
            //showFilter.titleLabel.text = @"Фильтр";
            [headerViewToAdd addSubview:showFilterButton];
            [headerViewToAdd addSubview:searchBar];
            self.tableView.tableHeaderView = headerViewToAdd;
        }

    }else
    {
        albumMode = YES;
        searchBar.hidden = YES;
        [self.tableView reloadData];
        [self.detailDelegate changeDetail:self];
    }
    
    DataSource *data = [(AppDelegate *)[[UIApplication sharedApplication] delegate] data];
    self.authorS = [data selectAuthor];
    if (!albumMode)
    {
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for (Author *author in self.authorS)
        {
           if ([[author book] count])
           {
               [tempArray addObject:author];
               //NSLog(@"%lu", [[author book] count]);
           }
        }
        self.authorS = tempArray;
    }
    self.books = [data selectBook];

    self.searchResults = [NSMutableArray arrayWithCapacity:[self.authorS count]];
    [self.tableView reloadData];
    
    
}

- (void) changeSource:(NSNumber *)numberOfChange
{}

- (IBAction)mainView:(id)sender
{
    [self.detailDelegate goToMain];
    self.change = NO;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (albumMode)
    {
        if(change)
        {
            return 1;
        }
        return 1;
    }else{
        if (tableView == self.searchDisplayController.searchResultsTableView)
        {
            return 1;
        }
    if(change)
    {
        
        return 1;
    }
    else
    {
       return [self.authorS count]; 
    }}

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (albumMode)
    {
        if(change)
        {
            return nil;
        }
        return nil;
    }else{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return nil;
    }
    if(change)
    {
        return nil;
    }
    else
    {
        return [[self.authorS objectAtIndex:section] name];
    }}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [self.searchResults count];
    }
	else
	{
        if (albumMode)
    {
        if(change)
        {
            return [[self.selectBook part] count];
        }
        return [self.authorS count];
    }
    else{
        if(change)
        {
            return [[self.selectBook part] count];
        }
        else
        {
            return [[[authorS objectAtIndex:section] book] count];
        }}
        
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        
        if (albumMode)
        {
            static NSString *CellIdentifier = @"Cell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            if(change)
            {
                cell.textLabel.text = [NSString stringWithFormat: @"%@", [[[[[self.selectBook part] allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]]] objectAtIndex:indexPath.row] title]];
            }else{
                cell.textLabel.text = [NSString stringWithFormat: @"%@", [[self.authorS objectAtIndex:indexPath.row] name]];}
            return cell; 
        }
        else{
            if (tableView == self.searchDisplayController.searchResultsTableView)
            {
                //Author *book = [self.authorS objectAtIndex:indexPath.row];
                static NSString *CellIdentifier = @"ce";
                UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
                cell.textLabel.text = [[self.searchResults objectAtIndex:indexPath.row] name];
                return cell; 
            } else {
                static NSString *CellIdentifier = @"Cell";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
                
                if (cell == nil)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
            
            if(change)
            {
                cell.textLabel.text = [NSString stringWithFormat: @"%@", [[[[[self.selectBook part] allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]]]objectAtIndex:indexPath.row] title]];
            }
            else
            {
                cell.textLabel.text = [NSString stringWithFormat: @"%@", [[[[[[authorS objectAtIndex:indexPath.section] book] allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]]objectAtIndex:indexPath.row] name]];
                cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bookBackground.png"]];
            }
            return cell;
            }
                
           
    }
        

}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        BookS *selectedBook = [self.searchResults objectAtIndex:indexPath.row];
        [self.detailDelegate didSelectBook:selectedBook];
    }
    else
    {
    if (albumMode)
    {
        if(change)
        {
            [self.detailDelegate showPart: [[[[self.selectBook part] allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]]] objectAtIndex:indexPath.row]];
        }else{
        Author *selectedBook = [self.authorS objectAtIndex:indexPath.row];
        [self.detailDelegate didSelectAuthor:selectedBook];
        }
    }
    else{
    if(change)
    {
        [self.detailDelegate showPart: [[[[self.selectBook part] allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]]] objectAtIndex:indexPath.row]];
    }
    else
    {
        BookS *selectBook = [[[[[authorS objectAtIndex:indexPath.section] book] allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]] objectAtIndex:indexPath.row];
        [self.detailDelegate didSelectBook:selectBook];

    }}}
}

- (IBAction)AddBook:(id)sender
{
    if (albumMode)
    {
    [self.detailDelegate addAuthor];
    }else
    {
      [self.detailDelegate addNewBook];
    }
   
}

-(void)checkRes:(NSNotification *)notification
{
    if ([[notification name] isEqualToString:@"blockButton"])
    {
        self.addBookButton.enabled = NO;
    }
    if ([[notification name] isEqualToString:@"unBlockButton"])
    {
        self.addBookButton.enabled = YES;
    }
    if ([[notification name] isEqualToString:@"reloadTable"])
    {
        self.authorS = [[(AppDelegate *)[[UIApplication sharedApplication] delegate] data] selectAuthor];
        if (!albumMode)
        {
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            for (Author *author in self.authorS)
            {
                if ([[author book] count])
                {
                    [tempArray addObject:author];
                    //NSLog(@"%lu", [[author book] count]);
                }
            }
            self.authorS = tempArray;
        }
        self.books = [[(AppDelegate *)[[UIApplication sharedApplication] delegate] data] selectBook];
        [self.tableView reloadData];
    }
}

-(void)defaultsChanged:(NSNotification *)notification
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *mode = [defaults objectForKey:@"showController"];
    if ([mode isEqual:@"0"])
    {
        if (albumMode == YES)
        {
            if (change == NO)
            {
                albumMode = NO;
                searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
                searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
                
                searchDisplayController.delegate = self;
                searchDisplayController.searchResultsDataSource = self;
                searchDisplayController.searchResultsDelegate = self;
                self.tableView.contentOffset = CGPointMake(0, self.searchDisplayController.searchBar.frame.size.height);
                UIView *headerViewToAdd = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
                [headerViewToAdd addSubview:searchBar];
                //[headerViewToAdd addSubview:searchBar];
                self.tableView.tableHeaderView = headerViewToAdd;
            }
            

            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTable" object:self];
            [self.detailDelegate changeDetail:self];
        }
        
    }else
    {
        if (albumMode == NO)
        {
            albumMode = YES;
            [searchDisplayController setActive:NO animated:YES];
            [searchBar removeFromSuperview];
            
            self.tableView.contentOffset = CGPointMake(0, 0);
            self.tableView.tableHeaderView = nil;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTable" object:self];
            [self.detailDelegate changeDetail:self];
        }
    }    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return NO;
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        if (albumMode)
        {
            if(change)
            {
                [[(AppDelegate *)[[UIApplication sharedApplication] delegate] data] deletePart:[[[[self.selectBook part] allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]]] objectAtIndex:indexPath.row]];
                //[[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTable" object:self];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            }else
            {
                [[(AppDelegate *)[[UIApplication sharedApplication] delegate] data] deleteAuthor:[self.authorS objectAtIndex:indexPath.row]];
                self.authorS = [[(AppDelegate *)[[UIApplication sharedApplication] delegate] data] selectAuthor];
                //[[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTable" object:self];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTable" object:self];
            }
        }
        else
        {
            if(change)
            {
                [[(AppDelegate *)[[UIApplication sharedApplication] delegate] data] deletePart:[[[[self.selectBook part] allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]]]objectAtIndex:indexPath.row]];
                //[[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTable" object:self];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            }
            else
            {
                [[(AppDelegate *)[[UIApplication sharedApplication] delegate] data] deleteBook:[[[[[authorS objectAtIndex:indexPath.section] book] allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]]objectAtIndex:indexPath.row]];
                [self.detailDelegate goToMain];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTable" object:self];
                
            }
        }
    }
}


 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }

 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }

#pragma mark -
#pragma mark Content Filtering
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    
    NSLog(@"Previous Search Results were removed.");
    [self.searchResults removeAllObjects];
    for (BookS *role in _books)
    {
        if ([scope isEqualToString:@"All"] || [role.name isEqualToString:scope])
        {
            NSComparisonResult result = [role.name compare:searchText
                                                                          options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)
                                                                            range:NSMakeRange(0, [searchText length])];
            if (result == NSOrderedSame)
            {
                NSLog(@"Adding role.name '%@' to searchResults as it begins with search text '%@'", role.name, searchText);
                [self.searchResults addObject:role];
            }
        }
    }
}

#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterContentForSearchText:searchString scope:@"All"];
    return YES;
}
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:@"All"];
    return YES;
}

- (IBAction)showFilter:(id)sender
{
    //self.FilterPopoverController.delegate = self;
    if (self.filterView == nil)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        self.filterView = (FilterViewViewController *)[storyboard instantiateViewControllerWithIdentifier:@"filterView"];
    }
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.filterView];
    
    self.FilterPopoverController=[[UIPopoverController alloc] initWithContentViewController:navigationController];
    self.FilterPopoverController.delegate=self;    
    [self.FilterPopoverController presentPopoverFromRect:((UIButton *)sender).bounds inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}
@end


