//
//  ZMEntityManager.h
//  AEE
//
//  Created by Milton D. Mitjans on 6/23/13.
//  Copyright (c) 2013 Milton D. Mitjans. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Barrios;
@class Pueblo;
@class User;

@interface ZMEntityManager : NSObject

+ (ZMEntityManager*) sharedInstance;

// Getter Methos
-(Barrios*) getBarriosFromPueblo:(Pueblo*) pueblo;
-(Barrios*) getBarrio:(NSString*)name;
-(NSArray*) getCoordinatesForBarrio:(NSString*) name;

-(NSArray*) getAllPueblos;

-(User*) getUser;

// Setter Methods
-(void) storePueblo:(NSMutableDictionary*) pueblos;
-(void) storeUserCoordinate:(NSNumber*) xCoordinate
              andCoordinate:(NSNumber*) yCoordinate
                forUserName:(NSString*) name;


-(User*) storeUser:(NSString*) userName andPassword:(NSString*) password;

-(void) clearPueblos;

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong, readonly) NSFetchedResultsController *fetchedResultsController;
@end
