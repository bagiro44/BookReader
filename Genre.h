//
//  Genre.h
//  BookReader
//
//  Created by Dmitriy Remezov on 16.10.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BookS;

@interface Genre : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *book;
@end

@interface Genre (CoreDataGeneratedAccessors)

- (void)addBookObject:(BookS *)value;
- (void)removeBookObject:(BookS *)value;
- (void)addBook:(NSSet *)values;
- (void)removeBook:(NSSet *)values;

@end
