//
//  BookCollectionCell.h
//  BookReader
//
//  Created by Dmitriy Remezov on 11.10.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookS.h"

@interface BookCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageBook;
@property (weak, nonatomic) IBOutlet UILabel *titleBook;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property NSIndexPath *indexpath;
- (IBAction)deleteBook:(id)sender;

@property BookS *book;

@end
