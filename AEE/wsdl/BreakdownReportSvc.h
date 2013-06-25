#import <Foundation/Foundation.h>
#import "USAdditions.h"
#import <libxml/tree.h>
#import "USGlobals.h"
@class BreakdownReportSvc_getBreakdownsByTownOrCity;
@class BreakdownReportSvc_getBreakdownsByTownOrCityResponse;
@class BreakdownReportSvc_getBreakdownsSummaryResponse;
#import "ax22.h"

@interface BreakdownReportSvc_getBreakdownsSummary : NSObject {
	
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;

@end


@interface BreakdownReportSvc_getBreakdownsByTownOrCity : NSObject {
	
/* elements */
	NSString * townOrCity;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (BreakdownReportSvc_getBreakdownsByTownOrCity *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
@property (retain) NSString * townOrCity;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface BreakdownReportSvc_getBreakdownsByTownOrCityResponse : NSObject {
	
/* elements */
	NSMutableArray *return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (BreakdownReportSvc_getBreakdownsByTownOrCityResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addReturn_:(ax22_BreakdownArea *)toAdd;
@property (readonly) NSMutableArray * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
@interface BreakdownReportSvc_getBreakdownsSummaryResponse : NSObject {
	
/* elements */
	NSMutableArray *return_;
/* attributes */
}
- (NSString *)nsPrefix;
- (xmlNodePtr)xmlNodeForDoc:(xmlDocPtr)doc elementName:(NSString *)elName elementNSPrefix:(NSString *)elNSPrefix;
- (void)addAttributesToNode:(xmlNodePtr)node;
- (void)addElementsToNode:(xmlNodePtr)node;
+ (BreakdownReportSvc_getBreakdownsSummaryResponse *)deserializeNode:(xmlNodePtr)cur;
- (void)deserializeAttributesFromNode:(xmlNodePtr)cur;
- (void)deserializeElementsFromNode:(xmlNodePtr)cur;
/* elements */
- (void)addReturn_:(ax22_BreakdownSummary *)toAdd;
@property (readonly) NSMutableArray * return_;
/* attributes */
- (NSDictionary *)attributes;
@end
/* Cookies handling provided by http://en.wikibooks.org/wiki/Programming:WebObjects/Web_Services/Web_Service_Provider */
#import <libxml/parser.h>
#import "xsd.h"
#import "BreakdownReportSvc.h"
#import "ax22.h"
@class BreakdownReportSoap11Binding;
@class BreakdownReportSoap12Binding;
@interface BreakdownReportSvc : NSObject {
	
}
+ (BreakdownReportSoap11Binding *)BreakdownReportSoap11Binding;
+ (BreakdownReportSoap12Binding *)BreakdownReportSoap12Binding;
@end
@class BreakdownReportSoap11BindingResponse;
@class BreakdownReportSoap11BindingOperation;
@protocol BreakdownReportSoap11BindingResponseDelegate <NSObject>
- (void) operation:(BreakdownReportSoap11BindingOperation *)operation completedWithResponse:(BreakdownReportSoap11BindingResponse *)response;
@end
@interface BreakdownReportSoap11Binding : NSObject <BreakdownReportSoap11BindingResponseDelegate> {
	NSURL *address;
	NSTimeInterval defaultTimeout;
	NSMutableArray *cookies;
	BOOL logXMLInOut;
	BOOL synchronousOperationComplete;
	NSString *authUsername;
	NSString *authPassword;
}
@property (copy) NSURL *address;
@property (assign) BOOL logXMLInOut;
@property (assign) NSTimeInterval defaultTimeout;
@property (nonatomic, retain) NSMutableArray *cookies;
@property (nonatomic, retain) NSString *authUsername;
@property (nonatomic, retain) NSString *authPassword;
- (id)initWithAddress:(NSString *)anAddress;
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(BreakdownReportSoap11BindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (BreakdownReportSoap11BindingResponse *)getBreakdownsByTownOrCityUsingParameters:(BreakdownReportSvc_getBreakdownsByTownOrCity *)aParameters ;
- (void)getBreakdownsByTownOrCityAsyncUsingParameters:(BreakdownReportSvc_getBreakdownsByTownOrCity *)aParameters  delegate:(id<BreakdownReportSoap11BindingResponseDelegate>)responseDelegate;
- (BreakdownReportSoap11BindingResponse *)getBreakdownsSummaryUsing;

@end
@interface BreakdownReportSoap11BindingOperation : NSOperation {
	BreakdownReportSoap11Binding *binding;
	BreakdownReportSoap11BindingResponse *response;
	id<BreakdownReportSoap11BindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) BreakdownReportSoap11Binding *binding;
@property (readonly) BreakdownReportSoap11BindingResponse *response;
@property (nonatomic, assign) id<BreakdownReportSoap11BindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(BreakdownReportSoap11Binding *)aBinding delegate:(id<BreakdownReportSoap11BindingResponseDelegate>)aDelegate;
@end
@interface BreakdownReportSoap11Binding_getBreakdownsByTownOrCity : BreakdownReportSoap11BindingOperation {
	BreakdownReportSvc_getBreakdownsByTownOrCity * parameters;
}
@property (retain) BreakdownReportSvc_getBreakdownsByTownOrCity * parameters;
- (id)initWithBinding:(BreakdownReportSoap11Binding *)aBinding delegate:(id<BreakdownReportSoap11BindingResponseDelegate>)aDelegate
	parameters:(BreakdownReportSvc_getBreakdownsByTownOrCity *)aParameters
;
@end
@interface BreakdownReportSoap11Binding_getBreakdownsSummary : BreakdownReportSoap11BindingOperation {
BreakdownReportSvc_getBreakdownsSummary * parameters;
}
- (id)initWithBinding:(BreakdownReportSoap11Binding *)aBinding delegate:(id<BreakdownReportSoap11BindingResponseDelegate>)aDelegate
;
@end
@interface BreakdownReportSoap11Binding_envelope : NSObject {
}
+ (BreakdownReportSoap11Binding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface BreakdownReportSoap11BindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
@class BreakdownReportSoap12BindingResponse;
@class BreakdownReportSoap12BindingOperation;
@protocol BreakdownReportSoap12BindingResponseDelegate <NSObject>
- (void) operation:(BreakdownReportSoap12BindingOperation *)operation completedWithResponse:(BreakdownReportSoap12BindingResponse *)response;
@end
@interface BreakdownReportSoap12Binding : NSObject <BreakdownReportSoap12BindingResponseDelegate> {
	NSURL *address;
	NSTimeInterval defaultTimeout;
	NSMutableArray *cookies;
	BOOL logXMLInOut;
	BOOL synchronousOperationComplete;
	NSString *authUsername;
	NSString *authPassword;
}
@property (copy) NSURL *address;
@property (assign) BOOL logXMLInOut;
@property (assign) NSTimeInterval defaultTimeout;
@property (nonatomic, retain) NSMutableArray *cookies;
@property (nonatomic, retain) NSString *authUsername;
@property (nonatomic, retain) NSString *authPassword;
- (id)initWithAddress:(NSString *)anAddress;
- (void)sendHTTPCallUsingBody:(NSString *)body soapAction:(NSString *)soapAction forOperation:(BreakdownReportSoap12BindingOperation *)operation;
- (void)addCookie:(NSHTTPCookie *)toAdd;
- (BreakdownReportSoap12BindingResponse *)getBreakdownsByTownOrCityUsingParameters:(BreakdownReportSvc_getBreakdownsByTownOrCity *)aParameters ;
- (void)getBreakdownsByTownOrCityAsyncUsingParameters:(BreakdownReportSvc_getBreakdownsByTownOrCity *)aParameters  delegate:(id<BreakdownReportSoap12BindingResponseDelegate>)responseDelegate;
- (BreakdownReportSoap12BindingResponse *)getBreakdownsSummaryUsing;
- (BreakdownReportSoap12BindingResponse *)getBreakdownsSummaryUsingParameters:(BreakdownReportSvc_getBreakdownsSummary *)aParamaters;
//- (void)getBreakdownsSummaryAsyncUsing:(id<BreakdownReportSoap12BindingResponseDelegate>)responseDelegate;
@end
@interface BreakdownReportSoap12BindingOperation : NSOperation {
	BreakdownReportSoap12Binding *binding;
	BreakdownReportSoap12BindingResponse *response;
	id<BreakdownReportSoap12BindingResponseDelegate> delegate;
	NSMutableData *responseData;
	NSURLConnection *urlConnection;
}
@property (retain) BreakdownReportSoap12Binding *binding;
@property (readonly) BreakdownReportSoap12BindingResponse *response;
@property (nonatomic, assign) id<BreakdownReportSoap12BindingResponseDelegate> delegate;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *urlConnection;
- (id)initWithBinding:(BreakdownReportSoap12Binding *)aBinding delegate:(id<BreakdownReportSoap12BindingResponseDelegate>)aDelegate;
@end
@interface BreakdownReportSoap12Binding_getBreakdownsByTownOrCity : BreakdownReportSoap12BindingOperation {
	BreakdownReportSvc_getBreakdownsByTownOrCity * parameters;
}
@property (retain) BreakdownReportSvc_getBreakdownsByTownOrCity * parameters;
- (id)initWithBinding:(BreakdownReportSoap12Binding *)aBinding delegate:(id<BreakdownReportSoap12BindingResponseDelegate>)aDelegate
	parameters:(BreakdownReportSvc_getBreakdownsByTownOrCity *)aParameters
;
@end
@interface BreakdownReportSoap12Binding_getBreakdownsSummary : BreakdownReportSoap12BindingOperation {

BreakdownReportSvc_getBreakdownsSummary * parameters;
}
@property (retain) BreakdownReportSvc_getBreakdownsSummary * parameters;
- (id)initWithBinding:(BreakdownReportSoap12Binding *)aBinding delegate:(id<BreakdownReportSoap12BindingResponseDelegate>)aDelegate;
- (id)initWithBinding:(BreakdownReportSoap12Binding *)aBinding delegate:(id<BreakdownReportSoap12BindingResponseDelegate>)responseDelegate parameters:(BreakdownReportSvc_getBreakdownsSummary *)aParameters;
@end
@interface BreakdownReportSoap12Binding_envelope : NSObject {
}
+ (BreakdownReportSoap12Binding_envelope *)sharedInstance;
- (NSString *)serializedFormUsingHeaderElements:(NSDictionary *)headerElements bodyElements:(NSDictionary *)bodyElements;
@end
@interface BreakdownReportSoap12BindingResponse : NSObject {
	NSArray *headers;
	NSArray *bodyParts;
	NSError *error;
}
@property (retain) NSArray *headers;
@property (retain) NSArray *bodyParts;
@property (retain) NSError *error;
@end
