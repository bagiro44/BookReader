//
//  Part.h
//  BookReader
//
//  Created by Dmitriy Remezov on 08.10.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BookS;

@interface Part : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * descriptionpart;
@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) BookS *books;

@end
