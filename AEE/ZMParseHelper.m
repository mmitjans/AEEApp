//
//  ZMParseHelper.m
//  AEE
//
//  Created by Milton D. Mitjans on 12/15/13.
//  Copyright (c) 2013 Milton D. Mitjans. All rights reserved.
//

#import "ZMParseHelper.h"
#import <Parse/Parse.h>

@implementation ZMParseHelper

+(void) logInWithUsername:(NSString*) username andPassword:(NSString*) password andParseBlock:(PFUserResultBlock)block
{
    PFUser *currentUser = [PFUser currentUser];
    
    if (!currentUser)
    {
        [PFUser logInWithUsernameInBackground:username
                                     password:password
                                        block:^(PFUser *user, NSError *error) {
                                            
                                            if (user) {
                                                // successful login
                                                if(block != nil)
                                                {
                                                    block(user, error);
                                                }
                                                
                                            } else {
                                                
                                                // Didn't get a user.
                                                NSLog(@"%s didn't get a user!", __PRETTY_FUNCTION__);
                                                
                                                UIAlertView *alertView = nil;
                                                
                                                if (error == nil) {
                                                    
                                                    // the username or password is probably wrong.
                                                    alertView = [[UIAlertView alloc] initWithTitle:@"Couldn’t log in:\nThe username or password were wrong."
                                                                                           message:nil
                                                                                          delegate:self
                                                                                 cancelButtonTitle:nil
                                                                                 otherButtonTitles:@"Ok", nil];
                                                } else {
                                                    
                                                    // Something else went horribly wrong:
                                                    alertView = [[UIAlertView alloc] initWithTitle:[[error userInfo]
                                                                                                    objectForKey:@"error"]
                                                                                           message:nil
                                                                                          delegate:self
                                                                                 cancelButtonTitle:nil
                                                                                 otherButtonTitles:@"Ok", nil];
                                                }
                                                
                                                [alertView show];
                                            }
                                        }];
    }
}

@end
