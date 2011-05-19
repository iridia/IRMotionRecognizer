//
//  IRMotionRecognizerSubclass.h
//  IRMotionRecognizer
//
//  Created by Evadne Wu on 5/11/11.
//  Copyright 2011 Iridia Productions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

#import "IRMathematics.h"

@interface IRMotionRecognizer ()

+ (CMMotionManager *) sharedMotionManager;

- (void) irConfigure; // Called in init

//	It is intended that the subclasses create a block bouncing the results to -handleMotionManagerUpdate: on self.queue
//	Note that you might like to say [self.queue cancelAllOperations] in -endMotionManagerUpdates
- (void) startMotionManagerUpdates; // Call super before working
- (void) endMotionManagerUpdates; // Call super after working
- (void) handleMotionManagerUpdate:(CMLogItem *)update;

//	These are already provided by the base class, so DON’T synthesize your own
@property (nonatomic, readwrite, retain) NSOperationQueue *queue;
@property (nonatomic, readwrite, copy) IRMotionRecognizerHandler handler;
@property (nonatomic, readwrite, retain) CMMotionManager *motionManager;
@property (nonatomic, readwrite, assign) IRMotionRecognizerState state;
@property (nonatomic, readwrite, assign, getter=isContinuous) BOOL continuous; // Defaults to YES — when a new state is set, if isContinuous == YES, a new “changed” state would still yield a handler callback

@end
