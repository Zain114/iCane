//
//  MDLmyAnnotation.m
//  iCane
//
//  Created by Luffy on 3/1/14.
//  Copyright (c) 2014 Dumbass inc. All rights reserved.
//

#import "MDLmyAnnotation.h"

@implementation MDLmyAnnotation

- (id) initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title{
    if((self = [super init])){
        self.coordinate = coordinate;
        self.title = title;
    }
    return self;
}

@end
