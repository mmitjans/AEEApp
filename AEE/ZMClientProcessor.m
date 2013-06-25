//
//  ZMClientProcessor.m
//  AEE
//
//  Created by Milton D. Mitjans on 6/12/13.
//  Copyright (c) 2013 Milton D. Mitjans. All rights reserved.
//

#import "ZMClientProcessor.h"
#import "BreakdownReportSvc.h"

@interface ZMClientProcessor()

@property (nonatomic, strong) BreakdownReportSoap12Binding *myService;

@end

@implementation ZMClientProcessor

-(id)init {
    
    if((self = [super init])) {

      self.myService = [BreakdownReportSvc BreakdownReportSoap12Binding];
        
	}
	
	return self;
}

-(NSMutableArray*) getBreakdowns
{
    NSMutableArray *breakDowns = [[NSMutableArray alloc] init];
    
    BreakdownReportSvc_getBreakdownsSummary *summary =
    [BreakdownReportSvc_getBreakdownsSummary new];
    
    BreakdownReportSoap12BindingResponse *breakdownsSummaryResponse =
    [self.myService getBreakdownsSummaryUsingParameters:summary];
    
    NSArray *responseHeaders = breakdownsSummaryResponse.headers;
    NSArray *responseBodyParts = breakdownsSummaryResponse.bodyParts;
    
    for(id bodyPart in responseBodyParts) {
        
        if ([bodyPart isKindOfClass:[SOAPFault class]]) {
        }
        if([bodyPart isKindOfClass:[BreakdownReportSvc_getBreakdownsSummaryResponse class]]) {
            BreakdownReportSvc_getBreakdownsSummaryResponse *body = (BreakdownReportSvc_getBreakdownsSummaryResponse*)bodyPart;
            // Now you can extract the color from the response
            NSMutableArray *theBreakdowns = [body return_];
            
            for( ax22_BreakdownSummary *breakdown in theBreakdowns) {
                
                NSString *town = breakdown.r1TownOrCity;
                if (town != nil) {
                    
                    [breakDowns addObject:breakdown];
                }
            }
            continue;
        }
        
    }

    
    return breakDowns;
}

-(NSMutableArray*) getBreakdownsByTownOrCity:(NSString*) townOrCIty
{
    NSMutableArray *breakDowns = [[NSMutableArray alloc] init];
    
    BreakdownReportSvc_getBreakdownsByTownOrCity *towns =
    [BreakdownReportSvc_getBreakdownsByTownOrCity new];
    
    [towns setTownOrCity:townOrCIty];
    
    BreakdownReportSoap12BindingResponse *response =
        [self.myService getBreakdownsByTownOrCityUsingParameters:towns];
    
    NSArray *responseHeaders = response.headers;
    NSArray *responseBodyParts = response.bodyParts;
    
    for(id bodyPart in responseBodyParts) {
        
        if ([bodyPart isKindOfClass:[SOAPFault class]]) {
        }
        if([bodyPart isKindOfClass:[BreakdownReportSvc_getBreakdownsByTownOrCityResponse class]]) {
            
            BreakdownReportSvc_getBreakdownsByTownOrCityResponse *body = (BreakdownReportSvc_getBreakdownsByTownOrCityResponse*)bodyPart;
            // Now you can extract the color from the response
            NSMutableArray *theBreakdowns = [body return_];
            
            for( ax22_BreakdownArea *breakdown in theBreakdowns) {
                
                NSString *town = breakdown.r1TownOrCity;
                if (town != nil) {
                    
                    [breakDowns addObject:breakdown];
                }
            }
            continue;
        }
        
    }
    
    return breakDowns;
}

@end
