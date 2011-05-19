//
//  IRDeviceOrientationMotionRecognizerImpl_AccelerometerGravity.h
//  IRMotionRecognizer
//
//  Created by Evadne Wu on 5/11/11.
//  Copyright 2011 Iridia Productions. All rights reserved.
//

@class IRDeviceOrientationMotionRecognizer;
@interface IRDeviceOrientationMotionRecognizerImpl_AccelerometerGravity : IRDeviceOrientationMotionRecognizer

@property (nonatomic, readwrite, assign) CGFloat filterValue; // Default is 0.3
@property (nonatomic, readwrite, assign) double_t x;
@property (nonatomic, readwrite, assign) double_t y;
@property (nonatomic, readwrite, assign) double_t z;

@end
