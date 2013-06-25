//
//  ZMPueblo.h
//  AEE
//
//  Created by Milton D. Mitjans on 6/19/13.
//  Copyright (c) 2013 Milton D. Mitjans. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZMBarrio.h"
@interface ZMPueblo : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *lsad;
@property (nonatomic, strong) NSString* county;
@property (nonatomic, strong) NSMutableDictionary *barrios;

-(void) addBarrio:(ZMBarrio*) barrio;
@end
