//
//  ZMMapViewController.m
//  AEE
//
//  Created by Milton D. Mitjans on 6/25/13.
//  Copyright (c) 2013 Milton D. Mitjans. All rights reserved.
//

#import "ZMMapViewController.h"

@interface ZMMapViewController ()

@end

@implementation ZMMapViewController

@synthesize mapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
	}
	return nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //Define map view region
    MKCoordinateSpan span;
	span.latitudeDelta=.01;
	span.longitudeDelta=.01;
    
	MKCoordinateRegion region;
	region.span=span;
	region.center=CLLocationCoordinate2DMake(39.046259, -76.851195);
    
    [mapView setRegion:region animated:YES];
	[mapView regionThatFits:region];
    
    
    CLLocationCoordinate2D commuterLotCoords[5]={
		CLLocationCoordinate2DMake(39.048019,-76.850535),
        CLLocationCoordinate2DMake(39.048027,-76.850234),
        CLLocationCoordinate2DMake(39.047407,-76.850181),
        CLLocationCoordinate2DMake(39.047407,-76.8505),
        CLLocationCoordinate2DMake(39.048019,-76.850535)
	};
    
    CLLocationCoordinate2D overflowLotCoords[15]={
        CLLocationCoordinate2DMake(39.04864351611461,-76.8513227245313),
        CLLocationCoordinate2DMake(39.04851710015167,-76.8517540587399),
        CLLocationCoordinate2DMake(39.04868674731313,-76.85192728689483),
        CLLocationCoordinate2DMake(39.04850095882104,-76.85230365946416),
        CLLocationCoordinate2DMake(39.04819087100218,-76.85265260435219),
        CLLocationCoordinate2DMake(39.0477370134458,-76.85286078490296),
        CLLocationCoordinate2DMake(39.04692851484644,-76.85283202926037),
        CLLocationCoordinate2DMake(39.04695987529381,-76.85235192135768),
        CLLocationCoordinate2DMake(39.04734847050665,-76.85236298239703),
        CLLocationCoordinate2DMake(39.04779491740192,-76.85232236959109),
        CLLocationCoordinate2DMake(39.04814366462639,-76.85208905182692),
        CLLocationCoordinate2DMake(39.04838024069194,-76.85164072166863),
        CLLocationCoordinate2DMake(39.04843331131504,-76.85085998781742),
        CLLocationCoordinate2DMake(39.04857547181026,-76.8507923535788),
        CLLocationCoordinate2DMake(39.04864351611461,-76.8513227245313)
    };
    
    MKPolygon *commuterParkingPolygon=[MKPolygon polygonWithCoordinates:commuterLotCoords count:5];
	[mapView addOverlay:commuterParkingPolygon];
    
    MKPolygon *overflowParkingPolygon=[MKPolygon polygonWithCoordinates:overflowLotCoords count:15];
	[mapView addOverlay:overflowParkingPolygon];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
