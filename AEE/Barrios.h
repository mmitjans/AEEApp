//
//  Barrios.h
//  AEE
//
//  Created by Milton D. Mitjans on 6/23/13.
//  Copyright (c) 2013 Milton D. Mitjans. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Coordinates;

@interface Barrios : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * county;
@property (nonatomic, retain) NSSet *relationship;
@end

@interface Barrios (CoreDataGeneratedAccessors)

- (void)addRelationshipObject:(Coordinates *)value;
- (void)removeRelationshipObject:(Coordinates *)value;
- (void)addRelationship:(NSSet *)values;
- (void)removeRelationship:(NSSet *)values;

@end
