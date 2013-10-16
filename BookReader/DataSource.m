//
//  DataSource.m
//  BookReader
//
//  Created by Dmitriy Remezov on 02.10.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import "DataSource.h"

@implementation DataSource




- (NSMutableArray *) selectAuthor
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Author" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    NSMutableArray *result= nil;
    result = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    return result;
}

- (NSMutableArray *) selectYear
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Genre" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    NSMutableArray *result= nil;
    result = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    return result;
}

- (NSMutableArray *) selectBook
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BookS"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    NSMutableArray *result= nil;
    result = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    return result;
}

- (BOOL) addAuthor:(NSString *)author
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Author" inManagedObjectContext:self.managedObjectContext];
    Author *authorToDB = [[Author alloc] initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];
    authorToDB.name = author;
    
    [self saveContext];    
    return YES;
}

- (BOOL) addGenre:(NSString *)genre;
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Genre" inManagedObjectContext:self.managedObjectContext];
    NSManagedObjectModel *iii = [NSEntityDescription insertNewObjectForEntityForName:[entity name]  inManagedObjectContext:self.managedObjectContext];
    
    [iii setValue:genre forKey:@"name"];
    [self saveContext];
    
    return YES;
}

- (BOOL) addBook:(NSString *)author year:(NSString *)year genre:(NSString *)genre name:(NSString *)name
{
    //описание новой книги для добавления в БД
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BookS" inManagedObjectContext:self.managedObjectContext];
    BookS *book = [[BookS alloc] initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];    
    book.year = [NSNumber numberWithInteger:year];
    book.name = name;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *authorEntity = [NSEntityDescription entityForName:@"Genre" inManagedObjectContext:self.managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", genre];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:authorEntity];
    Genre *genree = [[self.managedObjectContext executeFetchRequest:fetchRequest error:nil] lastObject];
    //получение автора для добавления связи с книгой
    fetchRequest = [[NSFetchRequest alloc] init];
    authorEntity = [NSEntityDescription entityForName:@"Author" inManagedObjectContext:self.managedObjectContext];
    predicate = [NSPredicate predicateWithFormat:@"name == %@", author];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:authorEntity];
    Author *array = [[self.managedObjectContext executeFetchRequest:fetchRequest error:nil] lastObject];
    if (array == nil)
    {
        [self addAuthor:author];
        array = [[self.managedObjectContext executeFetchRequest:fetchRequest error:nil] lastObject];
    }    

    [book addAuthoObject:array];
    [book addGenrObject:genree];
    
    
    
    [self saveContext];
    
    return YES;
}

- (BOOL) addBPart:(NSString *)book number:(NSString *)number title:(NSString *)title desc:(NSString *)description
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Part" inManagedObjectContext:self.managedObjectContext];
    Part *partToDB = [[Part alloc] initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];
    partToDB.descriptionpart = description;
    partToDB.title = title;
    partToDB.number = [NSNumber numberWithInt:1];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *authorEntity = [NSEntityDescription entityForName:@"BookS" inManagedObjectContext:self.managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", book];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:authorEntity];
    
    BookS *array = [[self.managedObjectContext executeFetchRequest:fetchRequest error:nil] lastObject];
    [array addPartObject:partToDB];
    
    [self saveContext];
    
    return YES;
}


- (BOOL) deleteBook:(BookS *)book
{
    [self.managedObjectContext deleteObject:book];
    [self saveContext];
    return  YES;
}
- (BOOL) deleteAuthor:(Author *)author
{
    [self.managedObjectContext deleteObject:author];
    [self saveContext];
    return YES;
}
- (BOOL) deletePart:(Part *)part
{
    [self.managedObjectContext deleteObject:part];
    [self saveContext];
    return YES;
}


- (void)saveContext
{
    if(nil != self.managedObjectContext){
        if([self.managedObjectContext hasChanges] && ![self.managedObjectContext save:nil])
        {
            NSLog(@"saveContext in datasource error");
            abort();
        }
    }
}


- (NSManagedObjectModel *)managedObjectModel
{
    if(nil != _managedObjectModel)
        return _managedObjectModel;
    
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if(nil != _persistentStoreCoordinator)
        return _persistentStoreCoordinator;
    
    NSURL *storeURL = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                               inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:@"Books.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]){
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext
{
    if(nil != _managedObjectContext)
        return _managedObjectContext;
    
    NSPersistentStoreCoordinator *store = self.persistentStoreCoordinator;
    if(nil != store){
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:store];
    }
    
    return _managedObjectContext;
}

@end
