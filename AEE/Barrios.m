//
//  Barrios.m
//  AEE
//
//  Created by Milton D. Mitjans on 6/23/13.
//  Copyright (c) 2013 Milton D. Mitjans. All rights reserved.
//

#import "Barrios.h"
#import "Coordinates.h"

@implementation Barrios

@dynamic name;
@dynamic county;
@dynamic relationship;
//
//- (void)addRelationshipObject:(Coordinates *)value
//{
//    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
//    [self willChangeValueForKey:@"coordinates" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
//    [[self primitiveValueForKey:@"coordinates"] addObject:value];
//    [self didChangeValueForKey:@"coordinates" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
//}
//
//- (void)removeRelationshipObject:(Coordinates *)value
//{
//    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
//    [self willChangeValueForKey:@"coordinates" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
//    [[self primitiveValueForKey:@"coordinates"] removeObject:value];
//    [self didChangeValueForKey:@"coordinates" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
//}
//
//- (void)addRelationship:(NSSet *)values
//{
//    [self willChangeValueForKey:@"coordinates" withSetMutation:NSKeyValueUnionSetMutation usingObjects:values];
//    [[self primitiveValueForKey:@"coordinates"] unionSet:values];
//    [self didChangeValueForKey:@"coordinates" withSetMutation:NSKeyValueUnionSetMutation usingObjects:values];
//    
//}
//- (void)removeRelationship:(NSSet *)values
//{
//    [self willChangeValueForKey:@"coordinates" withSetMutation:NSKeyValueMinusSetMutation usingObjects:values];
//    [[self primitiveValueForKey:@"coordinates"] minusSet:values];
//    [self didChangeValueForKey:@"coordinates" withSetMutation:NSKeyValueMinusSetMutation usingObjects:values];
//    
//}
//
@end
