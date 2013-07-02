//
//  ZMMapViewController.m
//  AEE
//
//  Created by Milton D. Mitjans on 6/25/13.
//  Copyright (c) 2013 Milton D. Mitjans. All rights reserved.
//

#import "ZMMapViewController.h"
#import "ZMEntityManager.h"
#import "ZMPointAnnotation.h"

#import "Barrios.h"
#import "Coordinates.h"

@interface ZMMapViewController ()

@end

@implementation ZMMapViewController

@synthesize mapView;
@synthesize barrioName;
@synthesize puebloName;
@synthesize myGeocoder;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        myGeocoder = [[ZMGeocoder alloc] init];
    }
    return self;
}

-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay{
	if([overlay isKindOfClass:[MKPolygon class]]){
		MKPolygonView *view = [[MKPolygonView alloc] initWithOverlay:overlay];
		view.lineWidth=1;
		view.strokeColor=[UIColor blueColor];
		view.fillColor=[[UIColor blueColor] colorWithAlphaComponent:0.5];
		return view;
	} else if ([overlay isKindOfClass:[MKCircle class]]){
		MKCircleView *view = [[MKCircleView alloc] initWithOverlay:overlay];
		view.lineWidth=1;
		view.strokeColor=[UIColor blueColor];
		view.fillColor=[[UIColor blueColor] colorWithAlphaComponent:0.5];
		return view;
	}
	return nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    ZMEntityManager *entityManager = [ZMEntityManager sharedInstance];
    
    NSArray *coordinates = [entityManager getCoordinatesForBarrio:barrioName];
    
    NSUInteger count = [coordinates count];
    
    //Define map view region
    MKCoordinateSpan span;
	span.latitudeDelta=.1;
	span.longitudeDelta=.1;
    
    __block MKCoordinateRegion region;
	region.span=span;
    
    if(count > 0) {
        // no coordinate in database
        CLLocationCoordinate2D barrioCoordinate[count];
        
        int iter = 0;
        for(Coordinates *currentCoordinate in coordinates)
        {
            barrioCoordinate[iter] =
            CLLocationCoordinate2DMake([[currentCoordinate y] doubleValue],
                                       [[currentCoordinate x] doubleValue]);
            iter++;
        }
        
        region.center=barrioCoordinate[iter/2];
        
        MKPolygon *commuterParkingPolygon=[MKPolygon polygonWithCoordinates:barrioCoordinate count:90];
        [mapView addOverlay:commuterParkingPolygon];
        
        [self setMapRegion:region];
        
        //        [mapView setRegion:region animated:YES];
        //        [mapView regionThatFits:region];
        
    } else {
        
        __block CLLocationCoordinate2D coordinate;
        
        __weak ZMMapViewController *viewController = self;
        
        geoCoderHandler = ^(NSArray *placemarks, NSError *error)
        {
            MKCircle *circle;
            
            if ([placemarks count] > 0)
            {
                CLPlacemark *placemark = [placemarks objectAtIndex:0];
                CLLocation *location = placemark.location;
                coordinate = location.coordinate;
                
                circle = [MKCircle circleWithCenterCoordinate:coordinate radius:[[placemark region] radius]];

            }
            
            region.center = coordinate;
            
            ZMPointAnnotation *annotation =
            [[ZMPointAnnotation alloc] initWithCoordinates:coordinate
                                                title:@"My Title" subTitle:@"My Sub Title"];
            
            
            [viewController setMapRegion:region];
            [viewController addOverlay:circle];
            [viewController setAnnotation:annotation];
            
        };
        
        [self.myGeocoder getCoordinatesForPueblo:puebloName
                                       andBarrio:barrioName
                                 completionBlock:geoCoderHandler];
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

-(void) setMapRegion:(MKCoordinateRegion) region
{
    [mapView setRegion:region animated:YES];
    [mapView regionThatFits:region];
}
-(void) setAnnotation:(ZMPointAnnotation*) annotation
{
    /* And eventually add it to the map */
    [mapView addAnnotation:annotation];
}
- (void)addOverlay:(id < MKOverlay >)overlay
{
    [mapView addOverlay:overlay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
