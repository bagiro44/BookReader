//
//  ChooseViewController.m
//  BookReader
//
//  Created by Dmitriy Remezov on 18.10.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import "ChooseViewController.h"
#import "FilterViewViewController.h"

@interface ChooseViewController ()

@end

@implementation ChooseViewController

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
    self.fromTextField.text = [NSString stringWithFormat:@"%.0f", filterView.slider.min*313+1700];
    self.toTextField.text = [NSString stringWithFormat:@"%.0f", filterView.slider.max*313+1700];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:nil action:@selector(doneButtonPressed)];
    [[self navigationItem] setRightBarButtonItem:doneButton];
}

- (void) doneButtonPressed
{
    
        if (([self.fromTextField.text intValue] && self.fromTextField.text.length == 4) && ([self.toTextField.text intValue] && self.toTextField.text.length == 4))
        {
            if ([self.fromTextField.text floatValue] <= [self.toTextField.text floatValue])
            {
            filterView.slider.min = ([self.fromTextField.text floatValue]-1700)/313;
            filterView.slider.max = ([self.toTextField.text floatValue]-1700)/313;
            [filterView report:filterView.slider];
            [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                UIAlertView *fromToAlertView = [[UIAlertView alloc] initWithTitle: @"Ошибка" message:@"Начало периода выборки книги не может быть позже конца выборки" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [fromToAlertView show];
            }
        }else
        {
            UIAlertView *yearLenghtAlertView = [[UIAlertView alloc] initWithTitle: @"Ошибка" message:@"Неправильно введен год, правильный формат ввода года YYYY" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [yearLenghtAlertView show];
        }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
