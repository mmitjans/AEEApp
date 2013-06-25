//
//  ZMPueblo.m
//  AEE
//
//  Created by Milton D. Mitjans on 6/19/13.
//  Copyright (c) 2013 Milton D. Mitjans. All rights reserved.
//

#import "ZMPueblo.h"

@implementation ZMPueblo

@synthesize name;
@synthesize lsad;
@synthesize county;
@synthesize barrios;

-(id)init {
    
    if((self = [super init])) {
        
        self.barrios = [[NSMutableDictionary alloc] init];
        
	}
	
	return self;
}

-(void) addBarrio:(ZMBarrio*) barrio
{
    [self.barrios setValue:barrio forKey:[barrio name]];
}
@end
