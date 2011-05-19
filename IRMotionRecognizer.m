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

+ (dispatch_queue_t) sharedDispatchQueue {

	static dispatch_once_t pred = 0;
	static dispatch_queue_t returned = nil;
	dispatch_once(&pred, ^ { returned = dispatch_queue_create("iridia.motionManager.dispatchQueue", 0); });
	return returned;

}

- (id) init {

	self = [super init];
	if (!self) return nil;
	
	[self irConfigure];
	
	return self;

}

- (void) irConfigure {

	dispatch_sync([[self class] sharedDispatchQueue], ^ {
	
		self.motionManager = [[[IRMotionManager alloc] init] autorelease];
	
	});
	
	self.state = IRMotionRecognizerStateUnknown;
	self.enabled = YES;
	self.continuous = YES;

}

- (void) dealloc {

	//		if (![NSThread isMainThread]) {
	//		
	//			__block __typeof__(self) nrSelf = self;
	//			dispatch_sync(dispatch_get_main_queue(), ^ { [nrSelf dealloc]; });
	//			return;
	//		
	//		}
	
	dispatch_sync([[self class] sharedDispatchQueue], ^ {
	
		if (motionManager.accelerometerActive || motionManager.gyroActive || motionManager.deviceMotionActive)
		[self endMotionManagerUpdates];
		
		[motionManager release];
		
	});
	
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
	
	//	Work
	
}

- (void) endMotionManagerUpdates {

	//	Work
	
	[self.queue waitUntilAllOperationsAreFinished];

}

- (void) handleMotionManagerUpdate:(CMLogItem *)update {

	//	Handle update in subclass

}

- (void) setState:(IRMotionRecognizerState)newState {

	if (self.continuous && (newState == state)) {
		
		if (self.handler)
		self.handler(self);
		
		return;
	
	}
	
	BOOL firesHandler = (state != IRMotionRecognizerStateUnknown);
	
	[self willChangeValueForKey:@"state"];
	state = newState;
	[self didChangeValueForKey:@"state"];
	
	if (firesHandler && self.handler)
	self.handler(self);

}

@end
