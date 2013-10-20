//
//  PublishHouseChangeViewController.m
//  BookReader
//
//  Created by Dmitriy Remezov on 20.10.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import "PublishHouseChangeViewController.h"
#import "DataSource.h"
#import "AppDelegate.h"
#import "PublishHouse.h"

@interface PublishHouseChangeViewController ()

@end

@implementation PublishHouseChangeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    filterView = [self.navigationController.viewControllers objectAtIndex:0];
    DataSource *data = [(AppDelegate *)[[UIApplication sharedApplication] delegate] data];
    self.PHArray = [data selectPublisherHouses];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [self.PHArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil )
    {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    if ([indexPath compare:self.lastIndexPath] == NSOrderedSame)
    {
        cell.textLabel.text = [NSString stringWithFormat: @"%@", [[self.PHArray objectAtIndex:indexPath.row] name]];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.textLabel.text = [NSString stringWithFormat: @"%@", [[self.PHArray objectAtIndex:indexPath.row] name]];
        if ([filterView.PHName isEqualToString:cell.textLabel.text])
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;   
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.lastIndexPath = indexPath;
    filterView.PHName = [[self.PHArray objectAtIndex:indexPath.row] name];
    [filterView.publishingHouseTable reloadData];
    [tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
