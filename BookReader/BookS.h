//
//  BookS.h
//  BookReader
//
//  Created by Dmitriy Remezov on 26.09.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BookS : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * author;
@property (nonatomic, retain) NSNumber * year;
@property (nonatomic, retain) NSNumber * genre;
@property (nonatomic, retain) NSDate * image;

@end
