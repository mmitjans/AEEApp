//
//  ZMPointAnnotation.m
//  AEE
//
//  Created by Milton D. Mitjans on 6/28/13.
//  Copyright (c) 2013 Milton D. Mitjans. All rights reserved.
//

#import "ZMPointAnnotation.h"

@implementation ZMPointAnnotation

-(id) initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates
                    title:(NSString *)paramTitle
                 subTitle:(NSString *)paramSubTitle
{
    
    self = [super init];
    if (self != nil){
        _coordinate = paramCoordinates;
        _title = paramTitle;
        _subtitle = paramSubTitle;
    }
    return(self); }

@end
