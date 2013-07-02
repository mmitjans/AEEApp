//
//  User.h
//  AEE
//
//  Created by Milton D. Mitjans on 6/30/13.
//  Copyright (c) 2013 Milton D. Mitjans. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Coordinates;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * pueblo;
@property (nonatomic, retain) NSString * barrio;
@property (nonatomic, retain) Coordinates *coordinates;

@end
