//
//  IRMotionManager.h
//  IRMotionRecognizer
//
//  Created by Evadne Wu on 5/18/11.
//  Copyright 2011 Iridia Productions. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>

#if 1

@interface IRMotionManager : CMMotionManager

@end

#else

@protocol IRMotionManagerSpoofing;
@interface IRMotionManager : NSObject <IRMotionManagerSpoofing>
@end


@protocol IRMotionManagerSpoofing

@property(assign, nonatomic) NSTimeInterval accelerometerUpdateInterval;
@property(readonly, nonatomic, getter=isAccelerometerAvailable) BOOL accelerometerAvailable;
@property(readonly, nonatomic, getter=isAccelerometerActive) BOOL accelerometerActive;
@property(readonly) CMAccelerometerData *accelerometerData;
- (void)startAccelerometerUpdates;
- (void)startAccelerometerUpdatesToQueue:(NSOperationQueue *)queue withHandler:(CMAccelerometerHandler)handler;
- (void)stopAccelerometerUpdates;

@property(assign, nonatomic) NSTimeInterval gyroUpdateInterval;
@property(readonly, nonatomic, getter=isGyroAvailable) BOOL gyroAvailable;
@property(readonly, nonatomic, getter=isGyroActive) BOOL gyroActive;
@property(readonly) CMGyroData *gyroData;
- (void)startGyroUpdates;
- (void)startGyroUpdatesToQueue:(NSOperationQueue *)queue withHandler:(CMGyroHandler)handler;
- (void)stopGyroUpdates;

@property(assign, nonatomic) NSTimeInterval deviceMotionUpdateInterval;
@property(readonly, nonatomic, getter=isDeviceMotionAvailable) BOOL deviceMotionAvailable;
@property(readonly, nonatomic, getter=isDeviceMotionActive) BOOL deviceMotionActive;
@property(readonly) CMDeviceMotion *deviceMotion;
- (void)startDeviceMotionUpdates;
- (void)startDeviceMotionUpdatesToQueue:(NSOperationQueue *)queue withHandler:(CMDeviceMotionHandler)handler;
- (void)stopDeviceMotionUpdates;

@end

@interface CMMotionManager (Spoofing) <IRMotionManagerSpoofing>
@end

@interface IRMotionManager (Spoofing) <IRMotionManagerSpoofing>
@property (nonatomic, readwrite, assign) CMMotionManager *placebo;
@end

#endif
