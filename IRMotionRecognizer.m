//
//  IRMotionRecognizer.m
//  IRMotionRecognizer
//
//  Created by Evadne Wu on 5/11/11.
//  Copyright 2011 Iridia Productions. All rights reserved.
//

#import "IRMotionRecognizer.h"
#import "IRMotionRecognizerSubclass.h"

#import "IRMotionManager.h"

@implementation IRMotionRecognizer
@synthesize queue, handler, state, enabled, motionManager, continuous;

+ (IRMotionRecognizer *) recognizerWithQueue:(NSOperationQueue *)aQueue handler:(void(^)(IRMotionRecognizer *recognizer))aHandler {

	IRMotionRecognizer *returned = [[[self alloc] init] autorelease];
	if (!returned) return nil;
	
	returned.enabled = NO;
	returned.queue = aQueue ? aQueue : [[[NSOperationQueue alloc] init] autorelease]; // Don’t use the main queue because it can not be explicitly destroyed then
	returned.handler = aHandler;
	returned.enabled = YES;
	
	return returned;

}

+ (CMMotionManager *) sharedMotionManager {

	static dispatch_once_t pred = 0;
	static id returned = nil;
	dispatch_once(&pred, ^ { returned = [[IRMotionManager alloc] init]; });
	return returned;

}

- (id) init {

	self = [super init];
	if (!self) return nil;
	
	[self irConfigure];
		
	return self;

}

- (void) irConfigure {

	self.state = IRMotionRecognizerStateUnknown;
	self.enabled = YES;
	self.continuous = YES;

}

- (void) dealloc {

	[motionManager autorelease]; // Background thread needs it
	[queue release];
	[handler release];
	
	[super dealloc];

}

- (void) setEnabled:(BOOL)flag {

	if (enabled == flag) return;
	
	[self willChangeValueForKey:@"enabled"];
	[self willChangeValueForKey:@"state"];
	
	enabled = flag;
	if (enabled) {
	
		[self startMotionManagerUpdates];
	
	} else {
		
		[self endMotionManagerUpdates];
	
	}
	
	state = IRMotionRecognizerStateUnknown;
	
	[self didChangeValueForKey:@"enabled"];
	[self didChangeValueForKey:@"state"];

}

- (void) startMotionManagerUpdates {

	self.motionManager = [[[IRMotionManager alloc] init] autorelease];
	
}

- (void) endMotionManagerUpdates {

	

}

- (void) handleMotionManagerUpdate:(CMLogItem *)update {

	//	Handle update in subclass

}

- (void) setState:(IRMotionRecognizerState)newState {

	if (newState == state) {
		
		if (!self.continuous)
		return;
		
		if (self.handler)
		self.handler(self);
		
		return;
	
	}
	
	[self willChangeValueForKey:@"state"];
	
	BOOL firesHandler = (state != IRMotionRecognizerStateUnknown);

	state = newState;
	
	if (firesHandler && self.handler)
	self.handler(self);
	
	[self didChangeValueForKey:@"state"];

}

@end
