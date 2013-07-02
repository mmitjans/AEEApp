//
//  ZMGeocoder.h
//  AEE
//
//  Created by Milton D. Mitjans on 6/27/13.
//  Copyright (c) 2013 Milton D. Mitjans. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface ZMGeocoder : NSObject

@property (nonatomic, strong) CLGeocoder *geocoder;

-(void) getCoordinatesForPueblo:(NSString*) pueblo
                                        andBarrio:(NSString*) barrio
                                  completionBlock:(CLGeocodeCompletionHandler) block;

@end
