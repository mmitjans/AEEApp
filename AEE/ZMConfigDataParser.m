//
//  ZMConfigDataParser.m
//  AEE
//
//  Created by Milton D. Mitjans on 6/17/13.
//  Copyright (c) 2013 Milton D. Mitjans. All rights reserved.
//

#import "ZMConfigDataParser.h"
#import "ZMPueblo.h"
#import "ZMBarrio.h"
#import "ZMCoordinate.h"

@implementation ZMConfigDataParser

-(id)init {
    
    if((self = [super init])) {
        
	}
	
	return self;
}

- (NSMutableDictionary*) processConfigData
{
    NSString *jsonFilePath = [[NSBundle mainBundle] pathForResource:@"barrios" ofType:@"json"];
    
    NSString *jsonString = [[NSString alloc] initWithContentsOfFile:jsonFilePath encoding:NSUTF8StringEncoding error: NULL];
    
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error = NULL;
    
    // now deserialize the data
    id jsonDeserialized = [NSJSONSerialization
                           JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    NSMutableDictionary *puebloObj = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *barriosObj = [[NSMutableDictionary alloc] init];
    
    if (jsonDeserialized != nil && error == nil)
    {
        NSDictionary *deserializedDictionary = (NSDictionary *)jsonDeserialized;
        
        NSDictionary *barrios = [deserializedDictionary valueForKey:@"barrios"];
        
        NSDictionary *features = [barrios valueForKey:@"features"];
        
        for (NSDictionary *eachFeature in features)
        {
            
            NSDictionary* geometries = [eachFeature valueForKey:@"geometry"];
            NSDictionary *properties = [eachFeature valueForKey:@"properties"];
            
            NSString* lsad = [properties valueForKey:@"LSAD"];
            NSString* name = [properties valueForKey:@"NAME"];
            NSString* county = [properties valueForKey:@"COUNTY"];
            
            NSArray *coordinates = [geometries valueForKey:@"coordinates"];
            
            NSArray *geotile = [coordinates objectAtIndex:0];
            
            NSMutableArray *theGeotile = [[NSMutableArray alloc] init];

            for(NSArray * eachValue in geotile) {
                
                ZMCoordinate *theCoordinates = [[ZMCoordinate alloc] init];
                
                NSString *xCoordinate = [eachValue objectAtIndex:0];
                NSString *yCoordinate = [eachValue objectAtIndex:1];
                
                @try {
                    
                    theCoordinates.x = [xCoordinate doubleValue];
                    theCoordinates.y = [yCoordinate doubleValue];
                    
                    [theGeotile addObject:theCoordinates];
                  
                }
                @catch (NSException *exception) {
                    NSLog(@"Exception: %@", name);
                }
                @finally {
                }

            }
            
            if([lsad isEqualToString:@"barrio"]) {
                
                ZMBarrio *currentBarrio = [[ZMBarrio alloc] init];
                [currentBarrio setCounty:county];
                [currentBarrio setName:name];
                [currentBarrio setCoordinates:theGeotile];
                
                [barriosObj setValue:currentBarrio forKey:name];
            } else {
                ZMPueblo *currentPueblo = [[ZMPueblo alloc] init];
                [currentPueblo setLsad:lsad];
                [currentPueblo setName:name];
                [puebloObj setValue:currentPueblo forKey:county];
            }
            
        }
        
    } // End Json Deserialization
    
    [barriosObj enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
        
        ZMBarrio *currentBarrio = obj;
        
        ZMPueblo* currentPueblo = [puebloObj valueForKey:[currentBarrio county]];
        
        if (currentPueblo != nil) {
            [currentPueblo addBarrio:currentBarrio];
        }
        
    }];
    
    return puebloObj;
}

@end
