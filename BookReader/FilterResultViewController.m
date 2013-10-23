//
//  FilterResultViewController.m
//  BookReader
//
//  Created by Dmitriy Remezov on 21.10.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import "FilterResultViewController.h"
#import "BookCollectionViewController.h"

@interface FilterResultViewController ()

@end

@implementation FilterResultViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [self.resultArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *CellIdentifier = @"Cell1";
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [[self.resultArray objectAtIndex:indexPath.row] name];
   return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MasterViewController *navigationControllerMaster = [[[self.splitViewController.viewControllers objectAtIndex:0] viewControllers] objectAtIndex:0];
    BookCollectionViewController *navigationControllerMaster1 = [[[self.splitViewController.viewControllers lastObject] viewControllers] objectAtIndex:0];
    if([navigationControllerMaster1 isMemberOfClass:[BookCollectionViewController class]])
    {
        [navigationControllerMaster.detailDelegate changeDetail:navigationControllerMaster];
    }
    [navigationControllerMaster.detailDelegate didSelectBook:[self.resultArray objectAtIndex:indexPath.row]];
}


@end
