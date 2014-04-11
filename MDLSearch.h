//
//  MDLSearch.h
//  iCane
//
//  Created by Luffy on 3/14/14.
//  Copyright (c) 2014 Dumbass inc. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MDLSearch : MKLocalSearch

@property NSMutableArray *results;

- (void) makeSearchRequestWithQuery:(NSString *)query;

@end
