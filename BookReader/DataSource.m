//
//  DataSource.m
//  BookReader
//
//  Created by Dmitriy Remezov on 02.10.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import "DataSource.h"

@implementation DataSource

- (NSMutableArray *) selectPublisherHouses
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PublishHouse" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    NSMutableArray *result= nil;
    result = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    return result;
}


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

- (BOOL) seacrhByPartTitle:(NSString *)part inBook:(BookS *)book
{
    /*NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *authorEntity = [NSEntityDescription entityForName:@"Author" inManagedObjectContext:self.managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", author];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:authorEntity];
    Author *array = [[self.managedObjectContext executeFetchRequest:fetchRequest error:nil] lastObject];
    [book addAuthoObject:array];*/
    return  YES;
}
- (BOOL) seacrhByBookName:(NSString *)name
{
    return  YES;
}
- (BOOL) seacrhByAuthorName:(NSString *)name
{
    return  YES;
}

- (NSMutableArray *) seaarchBook:(NSString *)bookName author:(NSString *) author yearFrom:(NSNumber *)yearFrom yearTo:(NSNumber *) yearTo publisherHouse:(NSString *) publisherHouse
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *authorEntity = [NSEntityDescription entityForName:@"BookS" inManagedObjectContext:self.managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"year > %@", yearFrom];
    NSPredicate *rp1 = [NSPredicate predicateWithFormat:@"year < %@", yearTo];
    predicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:predicate, rp1, nil]];
    if ([bookName length] >0)
    {
        NSPredicate *pr = [NSPredicate predicateWithFormat:@"(name CONTAINS[cd] %@)", bookName];
        predicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:predicate, pr, nil]];
    }
    if ([author length] >0)
    {
        NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"(autho.name CONTAINS[cd] %@)", author];
        predicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:predicate, predicate1, nil]];
    }
    if (![publisherHouse isEqualToString:@"Издательство"])
    {
        NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"(booktopb.name == %@)", publisherHouse];
        predicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:predicate, predicate2, nil]];
    }else if ([publisherHouse isEqualToString:@"Нет издательства"])
    {
        NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"(booktopb.name == Нет издательства)", publisherHouse];
        predicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:predicate, predicate2, nil]];
    }
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:authorEntity];
    return [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
}


- (BOOL) addAuthor:(NSString *)author
{
    NSFetchRequest *fetchRequest1 = [[NSFetchRequest alloc] init];
    NSEntityDescription *authorEntity1 = [NSEntityDescription entityForName:@"Author" inManagedObjectContext:self.managedObjectContext];
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"(name like[cd] %@)", author];
    [fetchRequest1 setPredicate:predicate1];
    [fetchRequest1 setEntity:authorEntity1];
    NSArray *tempArray = [self.managedObjectContext executeFetchRequest:fetchRequest1 error:nil];
    if([tempArray count] != 0)
    {
        return NO;
    }
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Author" inManagedObjectContext:self.managedObjectContext];
    Author *authorToDB = [[Author alloc] initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];
    authorToDB.name = author;
    
    if ([self saveContext]) {
        return YES;
    }
    return NO;
}

- (BOOL) addGenre:(NSString *)genre;
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Genre" inManagedObjectContext:self.managedObjectContext];
    NSManagedObjectModel *iii = [NSEntityDescription insertNewObjectForEntityForName:[entity name]  inManagedObjectContext:self.managedObjectContext];
    
    [iii setValue:genre forKey:@"name"];
    if ([self saveContext])
    {
        return YES;
    }
    return NO;
}

- (BOOL) addPublisherHouse:(NSString *)publisherHouse
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PublishHouse" inManagedObjectContext:self.managedObjectContext];
    NSManagedObjectModel *iii = [NSEntityDescription insertNewObjectForEntityForName:[entity name]  inManagedObjectContext:self.managedObjectContext];
    
    [iii setValue:publisherHouse forKey:@"name"];
    if ([self saveContext])
    {
        return YES;
    }
    return NO;
}

- (BOOL) addBook:(NSString *)author year:(NSString *)year genre:(NSString *)genre name:(NSString *)name image:(NSData *)image publisherHouse:(NSString *)publisherHouse
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *authorEntity = [NSEntityDescription entityForName:@"BookS" inManagedObjectContext:self.managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(name like[cd] %@)", name];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:authorEntity];
    NSArray *tempArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    if(tempArray != nil)
    {
        for (BookS *book in tempArray)
        {
            if ([[[[book.autho allObjects] lastObject] name] isEqualToString:author])
            {
                return NO;
            }
        }
    }

    //описание новой книги для добавления в БД
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BookS" inManagedObjectContext:self.managedObjectContext];
    BookS *book = [[BookS alloc] initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];    
    book.year = [NSNumber numberWithInteger:[year integerValue]];
    book.name = name;
    book.image = image;
    book.genre = genre;
    
    fetchRequest = [[NSFetchRequest alloc] init];
    authorEntity = [NSEntityDescription entityForName:@"PublishHouse" inManagedObjectContext:self.managedObjectContext];
    predicate = [NSPredicate predicateWithFormat:@"name == %@", publisherHouse];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:authorEntity];
    PublishHouse *arrayPH = [[self.managedObjectContext executeFetchRequest:fetchRequest error:nil] lastObject];
    if (arrayPH == nil)
    {
        if ([publisherHouse length] == 0)
        {
            publisherHouse = @"Нет издательства";
        }
        
        [self addPublisherHouse:publisherHouse];
        fetchRequest = [[NSFetchRequest alloc] init];
        authorEntity = [NSEntityDescription entityForName:@"PublishHouse" inManagedObjectContext:self.managedObjectContext];
        predicate = [NSPredicate predicateWithFormat:@"name == %@", publisherHouse];
        [fetchRequest setPredicate:predicate];
        [fetchRequest setEntity:authorEntity];
        arrayPH = [[self.managedObjectContext executeFetchRequest:fetchRequest error:nil] lastObject];
    }
    [book setBooktopb:arrayPH];
    
    //получение автора для добавления связи с книгой
    fetchRequest = [[NSFetchRequest alloc] init];
    authorEntity = [NSEntityDescription entityForName:@"Author" inManagedObjectContext:self.managedObjectContext];
    predicate = [NSPredicate predicateWithFormat:@"name == %@", author];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:authorEntity];
    Author *array = [[self.managedObjectContext executeFetchRequest:fetchRequest error:nil] lastObject];
    [book addAuthoObject:array];
    
        
    if ([self saveContext]) {
        return YES;
    }
    return NO;
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
    
    if ([self saveContext]) {
        return YES;
    }
    return NO;
}


- (BOOL) deleteBook:(BookS *)book
{
    [self.managedObjectContext deleteObject:book];
    if ([self saveContext]) {
        return YES;
    }
    return NO;
}
- (BOOL) deleteAuthor:(Author *)author
{
    [self.managedObjectContext deleteObject:author];
    if ([self saveContext]) {
        return YES;
    }
    return NO;

}
- (BOOL) deletePart:(Part *)part
{
    [self.managedObjectContext deleteObject:part];
    if ([self saveContext]) {
        return YES;
    }
    return NO;
}


- (BOOL) saveContext
{
    if(nil != self.managedObjectContext){
        if([self.managedObjectContext hasChanges] && ![self.managedObjectContext save:nil])
        {
            NSLog(@"saveContext in datasource error");
            return NO;
            abort();
        }
    }
    return YES;
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
