//
//  ZMLocationViewController.h
//  AEE
//
//  Created by Milton D. Mitjans on 6/30/13.
//  Copyright (c) 2013 Milton D. Mitjans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ZMLocationViewController : UIViewController<CLLocationManagerDelegate>

@property (nonatomic, assign) CLLocationCoordinate2D userCoordinates;

@end
