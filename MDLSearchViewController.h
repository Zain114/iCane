//
//  MDLSearchViewController.h
//  iCane
//
//  Created by Luffy on 3/14/14.
//  Copyright (c) 2014 Dumbass inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDLSearch.h"

@interface MDLSearchViewController : UITableViewController
{
    NSString *query;
    MDLSearch *searchRequest;
    NSInteger destIndex;
}

@property NSString *query;
@property (retain) MDLSearch *searchRequest;
@property NSInteger destIndex;

@end
