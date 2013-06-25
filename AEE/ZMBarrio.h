//
//  ZMBarrio.h
//  AEE
//
//  Created by Milton D. Mitjans on 6/21/13.
//  Copyright (c) 2013 Milton D. Mitjans. All rights reserved.
//

#import <Foundation/Foundation.h>

struct Coordinate {
    double x;
    double y;
};

@interface ZMBarrio : NSObject
@property (nonatomic, strong) NSString* county;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSMutableArray* coordinates;

@end
