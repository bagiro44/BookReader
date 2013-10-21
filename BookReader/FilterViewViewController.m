//
//  FilterViewViewController.m
//  BookReader
//
//  Created by Dmitriy Remezov on 18.10.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import "FilterViewViewController.h"
#import "ChooseViewController.h"
#import "PublishHouseChangeViewController.h"
#import "DataSource.h"
#import "AppDelegate.h"

@interface FilterViewViewController ()

@end

@implementation FilterViewViewController
@synthesize slider;

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
    self.PHName = @"Издательство";
    self.navigationController.delegate = self;
    slider = [[RangeSlider alloc] initWithFrame:CGRectMake(20, 210, 280, 30)];
    [slider setMinThumbImage:[UIImage imageNamed:@"rangethumb.png"]];
	[slider setMaxThumbImage:[UIImage imageNamed:@"rangethumb.png"]];
    
    UIImage *image; // there are two track images, one for the range "track", and one for the filled in region of the track between the slider thumbs
	
	[slider setTrackImage:[[UIImage imageNamed:@"fullrange.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(9.0, 9.0, 9.0, 9.0)]];
	
	image = [UIImage imageNamed:@"fillrange.png"];
	[slider setInRangeTrackImage:image];
    [self.view addSubview:slider];
    
    [slider addTarget:self action:@selector(report:) forControlEvents:UIControlEventValueChanged];
	self.minimalRangeValue.text = [NSString stringWithFormat:@"%.0f", slider.min*313+1700];
    self.maximumRangeValue.text = [NSString stringWithFormat:@"%.0f", slider.max*313+1700];
    
    self.accuracyTableView.delegate = self;
    self.accuracyTableView.dataSource = self;
    self.publishingHouseTable.delegate = self;
    self.publishingHouseTable.dataSource = self;
}

- (void)report:(RangeSlider *)sender
{
	self.minimalRangeValue.text = [NSString stringWithFormat:@"%.0f", sender.min*313+1700];
    self.maximumRangeValue.text = [NSString stringWithFormat:@"%.0f", sender.max*313+1700];
    NSString *report = [NSString stringWithFormat:@"current slider range is %f to %f", sender.min, sender.max];
    NSLog(report);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clearValues:(id)sender
{
    self.authorTextField.text = nil;
    self.titleTextField.text = nil;
    slider.min = 0.0;
    slider.max = 1.0;
    self.minimalRangeValue.text = [NSString stringWithFormat:@"%.0f", slider.min*313+1700];
    self.maximumRangeValue.text = [NSString stringWithFormat:@"%.0f", slider.max*313+1700];
    self.PHName = @"Издательство";
    [self.publishingHouseTable reloadData];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (tableView == self.accuracyTableView)
    {
        cell.textLabel.text = @"Точность";
    }
    else
    {
        cell.textLabel.text = self.PHName;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.accuracyTableView)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        ChooseViewController *chooseView = (ChooseViewController *)[storyboard instantiateViewControllerWithIdentifier:@"chooseView"];
        [self.navigationController pushViewController:chooseView animated:YES];
    }
    else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        PublishHouseChangeViewController *chooseView = (PublishHouseChangeViewController *)[storyboard instantiateViewControllerWithIdentifier:@"publishHouseChangeView"];
        [self.navigationController pushViewController:chooseView animated:YES];
    }
    
}

- (IBAction)applyFilter:(id)sender
{
    DataSource *data = [(AppDelegate *)[[UIApplication sharedApplication] delegate] data];
    NSMutableArray *arrr = [data seaarchBook:self.titleTextField.text author:self.authorTextField.text yearFrom:[NSNumber numberWithFloat:(slider.min*313+1700)] yearTo:[NSNumber numberWithFloat:(slider.max*313+1700)] publisherHouse:self.PHName];
    NSLog(@"%@", [[arrr objectAtIndex:0] name]);
}
@end
