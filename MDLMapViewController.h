//
//  MDLMapViewController.h
//  iCane
//
//  Created by Luffy on 3/16/14.
//  Copyright (c) 2014 Dumbass inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MDLSpeechModule.h"

@interface MDLMapViewController : UIViewController
{
    MDLSpeechModule * speechModule;
}

@property (strong, nonatomic) MDLSpeechModule *speechModule;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITextView *directions;
@property NSString *directionsString;
@property MKMapItem *destination;
@end
