//
//  IRDeviceOrientationMotionRecognizerSubclass.h
//  IRMotionRecognizer
//
//  Created by Evadne Wu on 5/11/11.
//  Copyright 2011 Iridia Productions. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>

#ifndef __IRDeviceOrientationMotionRecognizerSubclass__
#define __IRDeviceOrientationMotionRecognizerSubclass__

enum {

	IRDeviceOrientationMotionRecognizerImplUnknown = 0,
	IRDeviceOrientationMotionRecognizerImplDeviceMotionGravity = 1,
	IRDeviceOrientationMotionRecognizerImplAccelerometerGravity = 2,
	//	IRDeviceOrientationMotionRecognizerImplGyro = 3
	
}; typedef NSUInteger IRDeviceOrientationMotionRecognizerImpl;

#endif


@class IRDeviceOrientationMotionRecognizer;
@interface IRDeviceOrientationMotionRecognizer ()

@property (nonatomic, readwrite, assign) IRDeviceOrientationMotionRecognizerImpl implementation;
- (id) irInit NS_RETURNS_RETAINED; // The REAL initialization without class cluster choosing.  Remember to set self.implementation after init

@end
