//
//  IRDeviceOrientationMotionRecognizerImpl_AccelerometerGravity.m
//  IRMotionRecognizer
//
//  Created by Evadne Wu on 5/11/11.
//  Copyright 2011 Iridia Productions. All rights reserved.
//

#import "IRMotionRecognizer.h"
#import "IRMotionRecognizerSubclass.h"
#import "IRDeviceOrientationMotionRecognizer.h"
#import "IRDeviceOrientationMotionRecognizerSubclass.h"

#import "IRDeviceOrientationMotionRecognizerImpl_AccelerometerGravity.h"

@implementation IRDeviceOrientationMotionRecognizerImpl_AccelerometerGravity
@dynamic destination, tolerance;
@synthesize filterValue, x, y, z;

- (id) init {
	
	self = [super irInit];
	if (!self) return nil;
	
	self.implementation = IRDeviceOrientationMotionRecognizerImplAccelerometerGravity;
	self.filterValue = 0.15f;
	self.x = 0;
	self.y = 0;
	self.z = 0;
	
	return self;

}

- (void) startMotionManagerUpdates {

	[super startMotionManagerUpdates];

	self.motionManager.accelerometerUpdateInterval = 0.01f;
	
	__block __typeof__(self) nrSelf = self;

	[self.motionManager startAccelerometerUpdatesToQueue:self.queue withHandler: ^ (CMAccelerometerData *accelerometerData, NSError *error) {
	
		[nrSelf handleMotionManagerUpdate:accelerometerData];
	
	}];

}

- (void) endMotionManagerUpdates {

	[self.motionManager stopAccelerometerUpdates];
	
	self.x = 0;
	self.y = 0;
	self.z = 0;
	
	[super endMotionManagerUpdates];
	
}

- (void) handleMotionManagerUpdate:(CMAccelerometerData *)accelerometerData {

	if (!self.enabled)
	return;
	
	if (!accelerometerData)
	return;
	
	CMAcceleration acc = accelerometerData.acceleration;
	
	x = x ? x : acc.x; x = (acc.x * filterValue) + x * (1.0f - filterValue);
	y = y ? y : acc.y; y = (acc.y * filterValue) + y * (1.0f - filterValue);
	z = z ? z : acc.z; z = (acc.z * filterValue) + z * (1.0f - filterValue);
	
	IRSphericalCoordinates currentCoords = IRSphericalCoordinatesMakeWithCartesianCoordinates(x, y, z);
	
	BOOL passableElevation = (self.destination.elevation == NSNotFound) || (IRDegreesFromRadians(self.tolerance.elevation) >= fabs(IRDegreesStandardize(IRDegreesFromRadians(currentCoords.elevation)) - IRDegreesFromRadians(self.destination.elevation)));
	
	BOOL passableAzimuth = (self.destination.azimuth == NSNotFound) || (IRDegreesFromRadians(self.tolerance.azimuth) >= fabs(IRDegreesStandardize(IRDegreesFromRadians(currentCoords.azimuth)) - IRDegreesFromRadians(self.destination.azimuth)));
	
	BOOL passableState = passableElevation && passableAzimuth;
	
	dispatch_async(dispatch_get_main_queue(), ^ {
		self.state = passableState ? IRMotionRecognizerStateRecognized : IRMotionRecognizerStatePossible;
	});
	
}

@end
