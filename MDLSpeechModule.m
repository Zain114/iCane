//
//  MDLSpeechModule.m
//  iCane
//
//  Created by Luffy on 3/16/14.
//  Copyright (c) 2014 Dumbass inc. All rights reserved.
//

#import "MDLSpeechModule.h"
#import <OpenEars/LanguageModelGenerator.h>



@implementation MDLSpeechModule

@synthesize pocketsphinxController;
@synthesize openEarsEventsObserver;
@synthesize detected;
@synthesize slt;
@synthesize fliteController;

//////////////////////////////LAZY INITIALIZERS///////////////////////////////

- (PocketsphinxController *)pocketsphinxController {
	if (pocketsphinxController == nil) {
		pocketsphinxController = [[PocketsphinxController alloc] init];
	}
	return pocketsphinxController;
}

- (OpenEarsEventsObserver *)openEarsEventsObserver {
	if (openEarsEventsObserver == nil) {
		openEarsEventsObserver = [[OpenEarsEventsObserver alloc] init];
	}
	return openEarsEventsObserver;
}

- (FliteController *)fliteController {
	if (fliteController == nil) {
		fliteController = [[FliteController alloc] init];
	}
	return fliteController;
}

- (Slt *)slt {
	if (slt == nil) {
		slt = [[Slt alloc] init];
	}
	return slt;
}

/////////////////////INITIALIZATION/////////////////////////////////////

-(MDLSpeechModule *) init
{
    NSLog(@"Initializing speech module");
    
    LanguageModelGenerator *langModel = [[LanguageModelGenerator alloc] init];
    
    NSArray *words = [NSArray arrayWithObjects:@"SEARCH", @"DELETE", @"PIZZA", nil];
    NSString *fileName = @"language-model";
    NSError *error = [langModel generateLanguageModelFromArray:words withFilesNamed:fileName forAcousticModelAtPath:[AcousticModel pathToModel:@"AcousticModelEnglish"]];
    NSDictionary *languageGeneratorResults = nil;
    self.lmPath = nil;
    self.dicPath = nil;
    if([error code] == noErr) {
        languageGeneratorResults = [error userInfo];
		
        self.lmPath = [languageGeneratorResults objectForKey:@"LMPath"];
        self.dicPath = [languageGeneratorResults objectForKey:@"DictionaryPath"];
    } else {
        NSLog(@"Error: %@",[error localizedDescription]);
    }
    
    return self;
}

-(MDLSpeechModule *) initWithWords:(NSArray *) words
{
    NSLog(@"Initializing speech module");
    
    LanguageModelGenerator *langModel = [[LanguageModelGenerator alloc] init];
    
    NSString *fileName = @"language-model";
    NSError *error = [langModel generateLanguageModelFromArray:words withFilesNamed:fileName forAcousticModelAtPath:[AcousticModel pathToModel:@"AcousticModelEnglish"]];
    NSDictionary *languageGeneratorResults = nil;
    self.lmPath = nil;
    self.dicPath = nil;
    if([error code] == noErr) {
        languageGeneratorResults = [error userInfo];
		
        self.lmPath = [languageGeneratorResults objectForKey:@"LMPath"];
        self.dicPath = [languageGeneratorResults objectForKey:@"DictionaryPath"];
    } else {
        NSLog(@"Error: %@",[error localizedDescription]);
    }
    
    return self;
}

////////////////////////////SPEECHDETECTION//////////////////////////
- (void) detectSpeech
{
    [self.openEarsEventsObserver setDelegate:self];
    [self.pocketsphinxController startListeningWithLanguageModelAtPath:self.lmPath dictionaryAtPath:self.dicPath acousticModelAtPath:[AcousticModel pathToModel:@"AcousticModelEnglish"] languageModelIsJSGF:NO];
}

- (void) echoString:(NSString *)string
{
    [fliteController say:string withVoice:slt];
}

///////////////////////////DELEGATES/////////////////////////////////
- (void) pocketsphinxDidReceiveHypothesis:(NSString *)hypothesis recognitionScore:(NSString *)recognitionScore utteranceID:(NSString *)utteranceID {
	NSLog(@"The received hypothesis is %@ with a score of %@ and an ID of %@", hypothesis, recognitionScore, utteranceID);
    [self setValue:hypothesis forKey:@"detected"];
}

- (void) pocketsphinxDidStartCalibration {
	NSLog(@"Pocketsphinx calibration has started.");
}

- (void) pocketsphinxDidCompleteCalibration {
	NSLog(@"Pocketsphinx calibration is complete.");
}

- (void) pocketsphinxDidStartListening {
	NSLog(@"Pocketsphinx is now listening.");
}

- (void) pocketsphinxDidDetectSpeech {
	NSLog(@"Pocketsphinx has detected speech.");
}

- (void) pocketsphinxDidDetectFinishedSpeech {
	NSLog(@"Pocketsphinx has detected a period of silence, concluding an utterance.");
}

- (void) pocketsphinxDidStopListening {
	NSLog(@"Pocketsphinx has stopped listening.");
}

- (void) pocketsphinxDidSuspendRecognition {
	NSLog(@"Pocketsphinx has suspended recognition.");
}

- (void) pocketsphinxDidResumeRecognition {
	NSLog(@"Pocketsphinx has resumed recognition.");
}

- (void) pocketsphinxDidChangeLanguageModelToFile:(NSString *)newLanguageModelPathAsString andDictionary:(NSString *)newDictionaryPathAsString {
	NSLog(@"Pocketsphinx is now using the following language model: \n%@ and the following dictionary: %@",newLanguageModelPathAsString,newDictionaryPathAsString);
}

- (void) pocketSphinxContinuousSetupDidFail { // This can let you know that something went wrong with the recognition loop startup. Turn on OPENEARSLOGGING to learn why.
	NSLog(@"Setting up the continuous recognition loop has failed for some reason, please turn on OpenEarsLogging to learn more.");
}
- (void) testRecognitionCompleted {
	NSLog(@"A test file that was submitted for recognition is now complete.");
}

- (NSString *) getQuery
{
    return self.detected;
}

-(void) stop
{
    [pocketsphinxController stopListening];
}

@end
