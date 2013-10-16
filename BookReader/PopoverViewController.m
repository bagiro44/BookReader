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
    _data = [(AppDelegate *)[[UIApplication sharedApplication] delegate] data];
    switch ([self.numberOfChoise integerValue])
    {
    case 0:
        self.authorArray = [_data selectAuthor];
        break;
    case 1:
        self.authorArray = [[NSArray alloc] initWithObjects:@"18+", @"Аниме", @"Биография", @"Боевик", @"Вестерн", @"Военный", @"Детектив", @"Детский", @"Документальный", @"Драма", @"Игра", @"История", @"Комедия", @"Концерт", @"Короткометражка", @"Криминал", @"Мелодрама", @"Музыка", @"Мультфильм", @"Мюзикл", @"Новости", @"Приключения", @"Семейный", @"Сериал", @"Спорт", @"Ток-шоу", @"Триллер", @"Ужасы", @"Фантастика", @"Фентези", @"ТВ", nil];
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
    if ([self.numberOfChoise integerValue] == 0)
    {
        if ([self.authorArray count] > 0)
        {
            return [[self.authorArray objectAtIndex:row] name];
        }else
        {
            return @"Нет автора для выбора";
        }
        

    }else
    {
        if ([self.authorArray count] > 0)
        {
                    return [self.authorArray objectAtIndex:row];
        }else
        {
            return @"Нет жанра для выбора";
        }
    }
    
}

-(void)pickerView:(UIPickerView *)pickerView
     didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    if ([self.authorArray count] > 0)
    {
        if ([self.numberOfChoise integerValue] == 0)
        {
            return [delegate chooseAuthor:[[self.authorArray objectAtIndex:row] name] numberOfChoise:self.numberOfChoise];
        }else
        {
            return [delegate chooseAuthor:[self.authorArray objectAtIndex:row] numberOfChoise:self.numberOfChoise];
        }
    } 

}

- (void) chooseAuthor:(NSString *)authorName numberOfChoise:(NSNumber *)numberOfChoise
{
    
}
@end
