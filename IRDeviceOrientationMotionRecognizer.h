//
//  IRDeviceOrientationMotionRecognizer.h
//  IRMotionRecognizer
//
//  Created by Evadne Wu on 5/11/11.
//  Copyright 2011 Iridia Productions. All rights reserved.
//

#import "IRMotionRecognizer.h"
#import "IRMotionRecognizerSubclass.h"

#ifndef __IRDeviceOrientationMotionRecognizer__
#define __IRDeviceOrientationMotionRecognizer__

enum {

	IRDestinationModeExclusive,
	IRDestinationModeInclusive

}; typedef NSUInteger IRDestinationMode;

#endif

@interface IRDeviceOrientationMotionRecognizer : IRMotionRecognizer

@property (nonatomic, readwrite, assign) IRSphericalCoordinates destination;
@property (nonatomic, readwrite, assign) IRSphericalCoordinates tolerance;
@property (nonatomic, readwrite, assign) IRDestinationMode destinationMode;

@end
