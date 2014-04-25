//
//  ZMLocationViewController.m
//  AEE
//
//  Created by Milton D. Mitjans on 6/30/13.
//  Copyright (c) 2013 Milton D. Mitjans. All rights reserved.
//

#import "ZMLocationViewController.h"
#import "MBProgressHUD.h"

@interface ZMLocationViewController ()
@property(nonatomic, strong) CLGeocoder *geoCoder;
@end

@implementation ZMLocationViewController
{
    CLLocationManager *locationManager;
    MBProgressHUD *activityView;
}

@synthesize userCoordinates;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.geoCoder = [[CLGeocoder alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    activityView = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
    
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        locationManager = [[CLLocationManager alloc] init];
        
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        [locationManager startUpdatingLocation];
        
    });

}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    CLLocation *currentLocation = [locations objectAtIndex:0];
    
    [locationManager stopUpdatingLocation];
    
    self.userCoordinates = [currentLocation coordinate];
  
    NSLog(@"Detected Location : %f, %f", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
    self.geoCoder = [[CLGeocoder alloc] init];
    
    [self.geoCoder reverseGeocodeLocation:currentLocation
                        completionHandler:^(NSArray *placemarks, NSError *error) {
                            if (error){
                                NSLog(@"Geocode failed with error: %@", error);
                                return;
                            }
                            CLPlacemark *placemark = [placemarks objectAtIndex:0];
                            
                            CLCircularRegion *clRegion = [placemark region];
                            NSLog(@"placemark.ISOcountryCode %@",placemark.ISOcountryCode);
    }];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
