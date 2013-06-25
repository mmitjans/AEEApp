//
//  Pueblo.m
//  AEE
//
//  Created by Milton D. Mitjans on 6/23/13.
//  Copyright (c) 2013 Milton D. Mitjans. All rights reserved.
//

#import "Pueblo.h"
#import "Barrios.h"


@implementation Pueblo

@dynamic name;
@dynamic lsad;
@dynamic county;
@dynamic relationship;


//- (void)addRelationshipObject:(Barrios *)value
//{
//    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
//    [self willChangeValueForKey:@"barrios" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
//    [[self primitiveValueForKey:@"barrios"] addObject:value];
//    [self didChangeValueForKey:@"barrios" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
//}
//
//- (void)removeRelationshipObject:(Barrios *)value
//{
//    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
//    [self willChangeValueForKey:@"barrios" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
//    [[self primitiveValueForKey:@"barrios"] removeObject:value];
//    [self didChangeValueForKey:@"barrios" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
//}
//
//- (void)addRelationship:(NSSet *)values
//{
//    [self willChangeValueForKey:@"barrios" withSetMutation:NSKeyValueUnionSetMutation usingObjects:values];
//    [[self primitiveValueForKey:@"barrios"] unionSet:values];
//    [self didChangeValueForKey:@"barrios" withSetMutation:NSKeyValueUnionSetMutation usingObjects:values];
//    
//}
//- (void)removeRelationship:(NSSet *)values
//{
//    [self willChangeValueForKey:@"barrios" withSetMutation:NSKeyValueMinusSetMutation usingObjects:values];
//    [[self primitiveValueForKey:@"barrios"] minusSet:values];
//    [self didChangeValueForKey:@"barrios" withSetMutation:NSKeyValueMinusSetMutation usingObjects:values];
//    
//}

@end
