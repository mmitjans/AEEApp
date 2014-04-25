//
//  ZMMapViewController.h
//  AEE
//
//  Created by Milton D. Mitjans on 6/25/13.
//  Copyright (c) 2013 Milton D. Mitjans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "ZMGeocoder.h"

@interface ZMMapViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) NSString* barrioName;
@property (nonatomic, strong) NSString* puebloName;
@property (nonatomic, strong) ZMGeocoder* myGeocoder;
@end
