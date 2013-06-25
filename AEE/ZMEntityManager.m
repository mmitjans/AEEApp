//
//  ZMEntityManager.m
//  AEE
//
//  Created by Milton D. Mitjans on 6/23/13.
//  Copyright (c) 2013 Milton D. Mitjans. All rights reserved.
//

#import "ZMEntityManager.h"



#import "ZMPueblo.h"
#import "ZMCoordinate.h"

#import "Pueblo.h"
#import "Barrios.h"
#import "Coordinates.h"

@implementation ZMEntityManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize fetchedResultsController = _fetchedResultsController;

+ (ZMEntityManager*) sharedInstance{
    static ZMEntityManager *SharedInstance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        SharedInstance = [ZMEntityManager new]; });
    return SharedInstance;
}

// Getter Methos
-(Barrios*) getBarriosFromPueblo:(Pueblo*) pueblo
{}

-(NSArray*) getAllPueblos
{
    NSFetchedResultsController* resultsController = [self fetchedResultsController];
    NSError* error = nil;
    if(![resultsController performFetch:&error]){
        return nil;
    }
    return [resultsController fetchedObjects];;
}

-(NSArray*) getAllBarrios
{
    NSFetchedResultsController* resultsController = [self fetchedResultsControllerBarrios];
    NSError* error = nil;
    if(![resultsController performFetch:&error]){
        return nil;
    }
    return [resultsController fetchedObjects];;
}

-(NSArray*) getAllCoordinates
{
    NSFetchedResultsController* resultsController = [self fetchedResultsControllerCoordinates];
    NSError* error = nil;
    if(![resultsController performFetch:&error]){
        return nil;
    }
    return [resultsController fetchedObjects];;
}

-(void) clearPueblos
{
    NSArray *pueblos = [self getAllPueblos];
    
    for(Pueblo* pueblo in pueblos)
    {
        NSSet *barrios = [pueblo relationship];
        [pueblo removeRelationship:barrios];
        
        [_managedObjectContext deleteObject:pueblo];
    }
    
    NSArray *barrios = [self getAllBarrios];
    
    for(Barrios* barrio in barrios)
    {
        [_managedObjectContext deleteObject:barrio];
    }
    
    NSArray *coordinates = [self getAllCoordinates];
    
    for(Coordinates* coordinate in coordinates)
    {
        [_managedObjectContext deleteObject:coordinate];
    }
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
    }
}

// Setter Methods
-(void) storePueblo:(NSMutableDictionary*) pueblos
{
    [pueblos enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
        
        ZMPueblo* currentPueblo = obj;
        
        if (currentPueblo != nil)
        {
            NSMutableDictionary* barrios = [currentPueblo barrios];
            
            Pueblo *pueblo = (Pueblo *)[NSEntityDescription insertNewObjectForEntityForName:@"Pueblo"
                                                                     inManagedObjectContext:[self managedObjectContext]];
            
            [barrios enumerateKeysAndObjectsUsingBlock: ^(id key, id obj, BOOL *stop) {
                
                ZMBarrio *currentBarrio = obj;
                
                Barrios *barrio =
                (Barrios *)[NSEntityDescription insertNewObjectForEntityForName:@"Barrios"
                                                         inManagedObjectContext:[self managedObjectContext]];
                
                barrio.name = [currentBarrio name];
                barrio.county = [currentBarrio county];
                
                NSMutableArray *coordinates = [currentBarrio coordinates];
                
                [coordinates enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL *stop){
                    ZMCoordinate *coordinates = (ZMCoordinate*)obj;
                    
                    Coordinates *coordinateEntity =
                    (Coordinates *)[NSEntityDescription insertNewObjectForEntityForName:@"Coordinates"
                                                             inManagedObjectContext:[self managedObjectContext]];
                    
                    coordinateEntity.x = [NSNumber numberWithDouble:[coordinates x]];
                    coordinateEntity.y = [NSNumber numberWithDouble:[coordinates y]];
                    
                    [barrio addRelationshipObject:coordinateEntity];
                    
                }];
                
                [pueblo addRelationshipObject:barrio];
            }];
            
            [pueblo setName:currentPueblo.name];
            
            NSError *error;
            
            // here's where the actual save happens, and if it doesn't we print something out to the console
            if (![_managedObjectContext save:&error])
            {
                NSLog(@"Problem saving: %@", [error localizedDescription]);
            }
        }
        
    }];
    
}

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Pueblo"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name"
                                                                   ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc]
                                                             initWithFetchRequest:fetchRequest
                                                             managedObjectContext:self.managedObjectContext
                                                             sectionNameKeyPath:nil cacheName:@"Master"];
    _fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should
        // not use this function in a shipping application, although it may be useful during
        // development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return _fetchedResultsController;
}

- (NSFetchedResultsController *)fetchedResultsControllerBarrios
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Barrios"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name"
                                                                   ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc]
                                                             initWithFetchRequest:fetchRequest
                                                             managedObjectContext:self.managedObjectContext
                                                             sectionNameKeyPath:nil cacheName:@"Master"];
    _fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should
        // not use this function in a shipping application, although it may be useful during
        // development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return _fetchedResultsController;
}

- (NSFetchedResultsController *)fetchedResultsControllerCoordinates
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Coordinates"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name"
                                                                   ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc]
                                                             initWithFetchRequest:fetchRequest
                                                             managedObjectContext:self.managedObjectContext
                                                             sectionNameKeyPath:nil cacheName:@"Master"];
    _fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should
        // not use this function in a shipping application, although it may be useful during
        // development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return _fetchedResultsController;
}



#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    
    if (self->_managedObjectContext != nil)
    {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil)
    {
        return _managedObjectModel;
    }
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    return _managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    
    if (_persistentStoreCoordinator != nil)
    {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Model.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

@end