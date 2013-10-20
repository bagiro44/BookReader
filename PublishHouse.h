//
//  PublishHouse.h
//  BookReader
//
//  Created by Dmitriy Remezov on 20.10.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BookS;

@interface PublishHouse : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *pbtobook;
@end

@interface PublishHouse (CoreDataGeneratedAccessors)

- (void)addPbtobookObject:(BookS *)value;
- (void)removePbtobookObject:(BookS *)value;
- (void)addPbtobook:(NSSet *)values;
- (void)removePbtobook:(NSSet *)values;

@end
