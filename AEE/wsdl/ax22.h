#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class ax22_BreakdownArea;
@class ax22_BreakdownSummary;
@interface ax22_BreakdownArea : NSObject {
	
/* elements */
	NSString * r2Area;
	NSString * r3Status;
	NSString * r1TownOrCity;
	NSString * r4LastUpdate;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ax22_BreakdownArea *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * r2Area;
@property (retain) NSString * r3Status;
@property (retain) NSString * r1TownOrCity;
@property (retain) NSString * r4LastUpdate;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface ax22_BreakdownSummary : NSObject {
	
/* elements */
	NSString * r1TownOrCity;
	NSNumber * r2TotalBreakdowns;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (ax22_BreakdownSummary *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * r1TownOrCity;
@property (retain) NSNumber * r2TotalBreakdowns;
/* attributes */
- (NSDictionary *)attributes;
@end
