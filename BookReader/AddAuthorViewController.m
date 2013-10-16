//
//  AddAuthorViewController.m
//  BookReader
//
//  Created by Dmitriy Remezov on 14.10.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import "AddAuthorViewController.h"
#import "AppDelegate.h"

@interface AddAuthorViewController ()

@end

@implementation AddAuthorViewController

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
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper-003.jpg"]];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveAction:(id)sender
{
    UIAlertView *addAuthorAlertView1 = [[UIAlertView alloc]
                                initWithTitle:@"Ошибка"
                                message:@"Не введено имя автора..."
                                delegate:nil cancelButtonTitle:@"ОК" otherButtonTitles:nil, nil];
    UIAlertView *addAuthorAlertView2 = [[UIAlertView alloc]
                                initWithTitle:@"Ошибка"
                                message:@"Автор с таким именем уже существует в базе"
                                delegate:nil cancelButtonTitle:@"ОК" otherButtonTitles:nil, nil];
    
    DataSource *data = [(AppDelegate *)[[UIApplication sharedApplication] delegate] data];
    if (![self.authorNameTextField.text length] == 0)
    {
        if(![data addAuthor:self.authorNameTextField.text])
        {
            [addAuthorAlertView2 show];
        }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTable" object:self];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"unBlockButton" object:self];
        
            [self.navigationController popViewControllerAnimated:YES];}

    }else
    {
        [addAuthorAlertView1 show];
    }
}



- (void) viewWillDisappear:(BOOL)animated
{
    
    
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"unBlockButton" object:self];
    }
}

@end
