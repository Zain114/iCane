//
//  MDLSpeechModule.h
//  iCane
//
//  Created by Luffy on 3/16/14.
//  Copyright (c) 2014 Dumbass inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenEars/PocketsphinxController.h>
#import <OpenEars/AcousticModel.h>
#import <OpenEars/OpenEarsEventsObserver.h>
#import <Slt/Slt.h>
#import <OpenEars/FliteController.h>

@interface MDLSpeechModule : NSObject <OpenEarsEventsObserverDelegate>
{
    NSString *detected;
    Slt *slt;
    FliteController *fliteController;
}

@property (strong, nonatomic) PocketsphinxController *pocketsphinxController;
@property NSString *lmPath;
@property NSString *dicPath;
@property (strong, nonatomic) OpenEarsEventsObserver *openEarsEventsObserver;
@property NSString *detected;
@property (strong, nonatomic) Slt *slt;
@property (strong, nonatomic) FliteController *fliteController;

- (void) detectSpeech;

- (NSString *) getQuery;

-(void) stop;

-(void) echoString:(NSString *)string;

-(MDLSpeechModule *) initWithWords:(NSArray *)words;

@end
