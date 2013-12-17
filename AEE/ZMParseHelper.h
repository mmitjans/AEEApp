//
//  ZMParseHelper.h
//  AEE
//
//  Created by Milton D. Mitjans on 12/15/13.
//  Copyright (c) 2013 Milton D. Mitjans. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Parse/Parse.h>

@interface ZMParseHelper : NSObject

+(void) logInWithUsername:(NSString*) username andPassword:(NSString*) password andParseBlock:(PFUserResultBlock)block;

@end
