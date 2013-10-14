//
//  PopoverViewController.m
//  BookReader
//
//  Created by Dmitriy Remezov on 26.09.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import "PopoverViewController.h"


@interface PopoverViewController ()

@end

@implementation PopoverViewController

@synthesize authorArray, authorName, delegate;

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
    self.addGenreButton.hidden = YES;
    self.addGenreLabel.hidden = YES;
    self.addGenreTextField.hidden = YES;
    
    
    
    _data = [(AppDelegate *)[[UIApplication sharedApplication] delegate] data];
    switch ([self.numberOfChoise integerValue])
    {
    case 0:
        self.showAddGenreButton.hidden = YES;
            //[self.picker setFrame:[CGRectMake(0, 39, <#CGFloat width#>, <#CGFloat height#>)]];
        self.authorArray = [_data selectAuthor];
        break;
    case 1:
        self.topLabel.text = @"Выберите жанр:";
        self.authorArray = [_data selectYear];
        break;
    default:
        break;
    }

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([self.authorArray count] > 0)
    {
        return [self.authorArray count];
    }else{
        return 1;
    }
    
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ([self.authorArray count] > 0)
    {
        return [[self.authorArray objectAtIndex:row] name];
    }else{
        return @"Нет жанра для выбора";
    }
    
}

-(void)pickerView:(UIPickerView *)pickerView
     didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    if ([self.authorArray count] > 0)
    {
        [delegate chooseAuthor:[[self.authorArray objectAtIndex:row] name] numberOfChoise:self.numberOfChoise];
    } 

}

- (void) chooseAuthor:(NSString *)authorName numberOfChoise:(NSNumber *)numberOfChoise
{
    
}

- (IBAction)addGenre:(id)sender
{
    [_data addGenre:self.addGenreTextField.text];
    
    self.topLabel.hidden = NO;
    self.addGenreButton.hidden = YES;
    self.addGenreLabel.hidden = YES;
    self.addGenreTextField.hidden = YES;
    self.picker.hidden = NO;
    self.showAddGenreButton.hidden = NO;
    
}
- (IBAction)showAddGenreView:(id)sender
{
    self.topLabel.hidden = YES;
    self.addGenreButton.hidden = NO;
    self.addGenreLabel.hidden = NO;
    self.addGenreTextField.hidden = NO;
    self.picker.hidden = YES;
    self.showAddGenreButton.hidden = YES;
}
@end
