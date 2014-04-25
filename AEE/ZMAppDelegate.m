//
//  ZMAppDelegate.m
//  AEE
//
//  Created by Milton D. Mitjans on 6/11/13.
//  Copyright (c) 2013 Milton D. Mitjans. All rights reserved.
//

#import "ZMAppDelegate.h"

#import <Parse/Parse.h>

#import "ZMConfigDataParser.h"
#import "ZMPueblo.h"

#import "Pueblo.h"
#import "ZMEntityManager.h"

#import <CoreData/CoreData.h>

@interface ZMAppDelegate()

@end

@implementation ZMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    [Parse setApplicationId:@"Ps3Z5KuhwrExyxK5P2JxwIVa0gf42obU1UnUv6rN"
                  clientKey:@"d0oDmDkFt8x5LqhtAlHUS8zNzNk1yE7T2IRrg3LA"];
    
    [PFFacebookUtils initializeFacebook];
    
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert |
        UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];
    
    // Get notified when a user changes a setting
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleSettingsChanged:)
                                                 name:NSUserDefaultsDidChangeNotification
                                               object:nil];
    
    if(launchOptions[UIApplicationLaunchOptionsLocalNotificationKey] != nil)
    {
        UILocalNotification *notification =
            launchOptions[UIApplicationLaunchOptionsLocalNotificationKey];
        [self application:application didReceiveLocalNotification:notification];
    }
    else
    {
        [self scheduleNotification];
    
    }
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    ZMEntityManager *entityManager = [ZMEntityManager sharedInstance];
    
    NSArray *currentPueblos = [entityManager getAllPueblos];
    
    // If there are no pueblos
    if([currentPueblos count] == 0 )
    {
        ZMConfigDataParser *parser = [[ZMConfigDataParser alloc] init];
        
        NSMutableDictionary* pueblos = [parser processConfigData];
        [entityManager storePueblo:pueblos];
    }
    
    // create a standardUserDefaults variable
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    // saving an NSString
    [standardUserDefaults setObject:@"mystring" forKey:@"string"];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [PFFacebookUtils handleOpenURL:url];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [FBSession.activeSession handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [FBSession.activeSession close];
    
    // Removes the default setting notification
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [PFPush handlePush:userInfo];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSError *theError = error;
}

-(void) application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Test"
                                                        message:@"Wakup"
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    
    [alertView show];
}

-(void)scheduleNotification
{/*
    UILocalNotification *localNofitication = [[UILocalNotification alloc] init];
    
    localNofitication.fireDate = [NSDate dateWithTimeIntervalSinceNow:8];
    localNofitication.timeZone = [[NSCalendar currentCalendar] timeZone];
    localNofitication.alertBody = NSLocalizedString(@"Testing", nil);
    localNofitication.hasAction = YES;
    localNofitication.alertAction = NSLocalizedString(@"View", nil);
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNofitication];*/
}

-(void)handleSettingsChanged:(NSNotification*)notification
{
    
}


@end
