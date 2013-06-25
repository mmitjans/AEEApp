//
//  ZMClientProcessor.h
//  AEE
//
//  Created by Milton D. Mitjans on 6/12/13.
//  Copyright (c) 2013 Milton D. Mitjans. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMClientProcessor : NSObject

-(NSMutableArray*) getBreakdowns;

-(NSMutableArray*) getBreakdownsByTownOrCity:(NSString*) townOrCIty;

@end
