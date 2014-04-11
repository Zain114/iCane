//
//  MDLmyAnnotation.h
//  iCane
//
//  Created by Luffy on 3/1/14.
//  Copyright (c) 2014 Dumbass inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MDLmyAnnotation : NSObject

@property (strong, nonatomic) NSString *title;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

- (id) initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title;

@end
