//
//  ZMGeocoder.m
//  AEE
//
//  Created by Milton D. Mitjans on 6/27/13.
//  Copyright (c) 2013 Milton D. Mitjans. All rights reserved.
//


#import "ZMGeocoder.h"


@implementation ZMGeocoder
{
    CLGeocoder *geocoder;
}

@synthesize geocoder;

-(id)init {
    
    if((self = [super init])) {
        self.geocoder = [[CLGeocoder alloc] init];
	}
	
	return self;
}

-(void) getCoordinatesForPueblo:(NSString*) pueblo
                                        andBarrio:(NSString*) barrio
                                  completionBlock:(CLGeocodeCompletionHandler) block;
{
    NSString *address = [NSString stringWithFormat:@"%@ %@ %@",
                             barrio,
                             pueblo,
                             @"Puerto Rico"];
    
    [self.geocoder geocodeAddressString:address completionHandler:block];
     
}

@end
