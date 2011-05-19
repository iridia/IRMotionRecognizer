//
//  IRDeviceOrientationMotionRecognizer.m
//  IRMotionRecognizer
//
//  Created by Evadne Wu on 5/11/11.
//  Copyright 2011 Iridia Productions. All rights reserved.
//

#import "IRDeviceOrientationMotionRecognizer.h"
#import "IRDeviceOrientationMotionRecognizerSubclass.h"

#import "IRDeviceOrientationMotionRecognizerImpl_DeviceMotionGravity.h"
#import "IRDeviceOrientationMotionRecognizerImpl_AccelerometerGravity.h"

@implementation IRDeviceOrientationMotionRecognizer : IRMotionRecognizer
@synthesize destination, tolerance, destinationMode;
@synthesize implementation;

- (id) init {

	Class ownClass = [self class];
	[self release]; self = nil;

	if ([ownClass sharedMotionManager].deviceMotionAvailable) {
	
		NSLog(@"Should return IRDeviceOrientationMotionRecognizerImpl_DeviceMotionGravity — but it is not ready yet.  Skipping, returning one powered by accelerometer info.");
		
		self = [[IRDeviceOrientationMotionRecognizerImpl_AccelerometerGravity alloc] init];
	
	} else if ([ownClass sharedMotionManager].accelerometerAvailable) {
	
		self = [[IRDeviceOrientationMotionRecognizerImpl_AccelerometerGravity alloc] init];
	
	} else {
	
		self = nil;
	
	}
	
	return self;

}

- (id) irInit {

	self = [super init];
	if (!self) return nil;
	
	self.destination = (IRSphericalCoordinates){ 0, 0, 0 };
	self.tolerance = self.destination;
	self.destinationMode = IRDestinationModeInclusive;
	self.implementation = IRDeviceOrientationMotionRecognizerImplUnknown;
	self.continuous = NO;
	
	return self;

}

@end
