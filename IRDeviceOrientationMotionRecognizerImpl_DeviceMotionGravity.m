//
//  IRDeviceOrientationMotionRecognizerImpl_DeviceMotionGravity.m
//  IRMotionRecognizer
//
//  Created by Evadne Wu on 5/11/11.
//  Copyright 2011 Iridia Productions. All rights reserved.
//

#import "IRMotionRecognizer.h"
#import "IRMotionRecognizerSubclass.h"
#import "IRDeviceOrientationMotionRecognizer.h"
#import "IRDeviceOrientationMotionRecognizerSubclass.h"

#import "IRDeviceOrientationMotionRecognizerImpl_DeviceMotionGravity.h"

@implementation IRDeviceOrientationMotionRecognizerImpl_DeviceMotionGravity

- (id) init {
	
	self = [super irInit];
	if (!self) return nil;
	
	self.implementation = IRDeviceOrientationMotionRecognizerImplDeviceMotionGravity;
	
	return self;

}

@end
