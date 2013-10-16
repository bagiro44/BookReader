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

@synthesize detailDelegate, authorS, change, selectBook, albumMode;

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
    DataSource *data = [(AppDelegate *)[[UIApplication sharedApplication] delegate] data];
    self.authorS = [data selectAuthor];
    self.books = [data selectBook];

    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *mode = [defaults objectForKey:@"showController"];
    if ([mode isEqual:@"0"])
    {
        albumMode = NO;
    }else
    {
        albumMode = YES;
        [self.tableView reloadData];
        [self.detailDelegate changeDetail:self];
    }
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (albumMode)
    {
        if(change)
        {
            cell.textLabel.text = [NSString stringWithFormat: @"%@", [[[[[self.selectBook part] allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]]] objectAtIndex:indexPath.row] title]];
        }else{
            cell.textLabel.text = [NSString stringWithFormat: @"%@", [[self.authorS objectAtIndex:indexPath.row] name]];}
    }
    else{
    if(change)
    {
        cell.textLabel.text = [NSString stringWithFormat: @"%@", [[[[[self.selectBook part] allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]]]objectAtIndex:indexPath.row] title]];
    }
    else
    {
        cell.textLabel.text = [NSString stringWithFormat: @"%@", [[[[[[authorS objectAtIndex:indexPath.section] book] allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]]objectAtIndex:indexPath.row] name]];
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bookBackground.png"]];
    }}
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (albumMode)
    {
        if(change)
        {
            [self.detailDelegate showPart: [[[[self.selectBook part] allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]]] objectAtIndex:indexPath.row]];
        }else{
        Author *selectedBook = [self.authorS objectAtIndex:indexPath.row];
        [self.detailDelegate didSelectAuthor:selectedBook];}
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

    }}
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
            albumMode = NO;
            [self.tableView reloadData];
            [self.detailDelegate changeDetail:self];
        }
        
    }else
    {
        if (albumMode == NO)
        {
            albumMode = YES;
            [self.tableView reloadData];
            [self.detailDelegate changeDetail:self];
        }
    }    
    NSLog(@"%@", self.splitViewController.viewControllers);
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
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
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            }else
            {
                [[(AppDelegate *)[[UIApplication sharedApplication] delegate] data] deleteAuthor:[self.authorS objectAtIndex:indexPath.row]];
                self.authorS = [[(AppDelegate *)[[UIApplication sharedApplication] delegate] data] selectAuthor];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            }
        }
        else{
            if(change)
            {
                [[(AppDelegate *)[[UIApplication sharedApplication] delegate] data] deletePart:[[[[self.selectBook part] allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]]]objectAtIndex:indexPath.row]];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            }
            else
            {
                [[(AppDelegate *)[[UIApplication sharedApplication] delegate] data] deleteBook:[[[[[authorS objectAtIndex:indexPath.section] book] allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]]objectAtIndex:indexPath.row]];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            }}
        
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
 


@end

 
