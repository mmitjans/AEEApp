//
//  ZMMapViewController.h
//  AEE
//
//  Created by Milton D. Mitjans on 6/25/13.
//  Copyright (c) 2013 Milton D. Mitjans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ZMMapViewController : UIViewController <MKMapViewDelegate>
{
        MKMapView *_mapView;
}
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
