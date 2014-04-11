//
//  MDLMapViewController.m
//  iCane
//
//  Created by Luffy on 3/16/14.
//  Copyright (c) 2014 Dumbass inc. All rights reserved.
//

#import "MDLMapViewController.h"
#import "MDLCBPeripheralManager.h"

#define METERS_PER_MILE 1609.344

@interface MDLMapViewController ()

@end

@implementation MDLMapViewController

@synthesize directionsString;
@synthesize speechModule;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //get directions
    
    /*
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 40.740848;
    zoomLocation.longitude = -73.991145;
    NSDictionary *addressDict = [[NSDictionary alloc] initw]
    MKPlacemark *sourcePlacemark = [[MKPlacemark alloc] initWithCoordinate:zoomLocation addressDictionary:<#(NSDictionary *)#>];
    MKMapItem *source = [[MKMapItem alloc] initWithPlacemark:sourcePlacemark];
     */
    NSString *toEcho = @"Begining navigation. Please hold cane firmly";
    [speechModule echoString:toEcho];
    
    MKMapItem *source = [MKMapItem mapItemForCurrentLocation];
    
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    request.source = source;
    request.destination = self.destination;
    
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        [self printTurnByTurn:response WithError:error];
    }];
    
    //CB manager
    MDLCBPeripheralManager *peripheral = [[MDLCBPeripheralManager alloc] initWithData:directionsString];
    //need to attach an observer to the data
    [peripheral addObserver:peripheral forKeyPath:@"directionsString" options:NSKeyValueObservingOptionNew context:nil];
}

-(void) printTurnByTurn:(MKDirectionsResponse *)response WithError:(NSError *)error
{
    for(MKRoute *route in response.routes)
    {
        self.directionsString = @"Directions to ";
        self.directionsString = [self.directionsString stringByAppendingString:self.destination.name];
        self.directionsString = [self.directionsString stringByAppendingString:@": ETA "];
        NSString *ETA = [NSString stringWithFormat:@"%f", route.expectedTravelTime];
        self.directionsString = [self.directionsString stringByAppendingString:ETA];
        self.directionsString = [self.directionsString stringByAppendingString:@"seconds\n"];
        for(MKRouteStep *step in route.steps)
        {
            NSString *newStep = step.instructions;
            self.directionsString = [self.directionsString stringByAppendingString:newStep];
            self.directionsString = [self.directionsString stringByAppendingString:@" "];
            NSString *stepDistance = [NSString stringWithFormat:@"%f", step.distance];
            self.directionsString = [self.directionsString stringByAppendingString:stepDistance];
            self.directionsString = [self.directionsString stringByAppendingString:@"\n"];
        }
        self.directions.text = self.directionsString;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
