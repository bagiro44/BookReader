//
//  DataSource.h
//  BookReader
//
//  Created by Dmitriy Remezov on 02.10.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Author.h"
#import "BookS.h"
#import "Part.h"
#import "PublishHouse.h"

@interface DataSource : NSObject

@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;


- (NSMutableArray *) selectAuthor;
- (NSMutableArray *) selectYear;
- (NSMutableArray *) selectGenre;
- (NSMutableArray *) selectBook;
- (NSMutableArray *) selectPart;
- (NSMutableArray *) selectPublisherHouses;

- (BOOL) seacrhByPartTitle:(NSString *)part inBook:(BookS *)book;
- (BOOL) seacrhByBookName:(NSString *)name;
- (BOOL) seacrhByAuthorName:(NSString *)name;
- (NSMutableArray *) seaarchBook:(NSString *)bookName author:(NSString *) author yearFrom:(NSNumber *)yearFrom yearTo:(NSNumber *) yearTo publisherHouse:(NSString *) publisherHouse;

- (BOOL) addAuthor:(NSString *)author;
- (BOOL) addPublisherHouse:(NSString *)publisherHouse;
- (BOOL) addBook:(NSString *)author year:(NSString *)year genre:(NSString *)genre name:(NSString *)name image:(NSData *)image publisherHouse:(NSString *)publisherHouse;
- (BOOL) addBPart:(NSString *)book number:(NSString *)number title:(NSString *)title desc:(NSString *)description;
- (BOOL) addGenre:(NSString *)genre;

- (BOOL) deleteBook:(BookS *)book;
- (BOOL) deleteAuthor:(Author *)author;
- (BOOL) deletePart:(Part *)part;
@end
