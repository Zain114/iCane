//
//  MDLViewController.m
//  iCane
//
//  Created by Luffy on 3/1/14.
//  Copyright (c) 2014 Dumbass inc. All rights reserved.
//

#import "MDLViewController.h"
#import "MDLmyAnnotation.h"

#define METERS_PER_MILE 1609.344

@interface MDLViewController ()

@end

@implementation MDLViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 40.740848;
    zoomLocation.longitude = -73.991145;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.3*METERS_PER_MILE, 0.3*METERS_PER_MILE);
    
    [self.mapView setRegion:viewRegion animated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.mapView.delegate = self;
    
    CLLocationCoordinate2D coordinate1;
    coordinate1.latitude = 40.740384;
    coordinate1.longitude = -73.991146;
    MDLmyAnnotation *annotation = [[MDLmyAnnotation alloc] initWithCoordinate:coordinate1 title:@"Starbucks NY"];
    [self.mapView addAnnotation:annotation];
    
    CLLocationCoordinate2D coordinate2;
    coordinate2.latitude = 40.741623;
    coordinate2.longitude = -73.992021;
    MDLmyAnnotation *annotation2 = [[MDLmyAnnotation alloc] initWithCoordinate:coordinate2 title:@"Gallery"];
    [self.mapView addAnnotation:annotation2];
    
    CLLocationCoordinate2D coordinate3;
    coordinate3.latitude = 40.739490;
    coordinate3.longitude = -73.991154;
    MDLmyAnnotation *annotation3 = [[MDLmyAnnotation alloc] initWithCoordinate:coordinate3 title:@"Virgin Records"];
    [self.mapView addAnnotation:annotation3];
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id)annotation{
    if([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    static NSString *identifier = @"MDLmyAnnotation";
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if(!annotationView)
    {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationView.pinColor = MKPinAnnotationColorPurple;
        annotationView.animatesDrop = YES;
        annotationView.canShowCallout = YES;
    } else {
        annotationView.annotation = annotation;
    }
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    return annotationView;
}



@end
