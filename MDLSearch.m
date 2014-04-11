//
//  MDLSearch.m
//  iCane
//
//  Created by Luffy on 3/14/14.
//  Copyright (c) 2014 Dumbass inc. All rights reserved.
//

#import "MDLSearch.h"

#define METERS_PER_MILE 1609.344

@implementation MDLSearch

- (void) doSearchWithRequest:(MKLocalSearchRequest *)request
{
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
    [self searchCompletionHandler:response WithError:error];
    }];
}

- (void) searchCompletionHandler:(MKLocalSearchResponse *)response WithError:(NSError *) error
{
    //self.results = [[NSMutableArray alloc] initWithArray:response.mapItems];
    self.results = (NSMutableArray *)response.mapItems;

}

- (void) makeSearchRequestWithQuery:(NSString *)query
{
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 40.740848;
    zoomLocation.longitude = -73.991145;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.3*METERS_PER_MILE, 0.3*METERS_PER_MILE);
    
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = query;
    request.region = viewRegion;
    
    [self doSearchWithRequest:request];
}

@end
