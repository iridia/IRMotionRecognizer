//
//  IRMotionRecognizer.h
//  IRMotionRecognizer
//
//  Created by Evadne Wu on 5/11/11.
//  Copyright 2011 Iridia Productions. All rights reserved.
//

#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

#ifndef __IRMotionRecognizer__
#define __IRMotionRecognizer__

#define IRMotionRecognizerNoOp NSNotFound

@class IRMotionRecognizer;
typedef void (^IRMotionRecognizerHandler) (IRMotionRecognizer *recognizer); 

enum {

	IRMotionRecognizerStateUnknown = 0,
	
	IRMotionRecognizerStatePossible,
	IRMotionRecognizerStateBegan,
	IRMotionRecognizerStateChanged,
	IRMotionRecognizerStateEnded,
	IRMotionRecognizerStateCancelled,
	IRMotionRecognizerStateFailed,
	IRMotionRecognizerStateRecognized = IRMotionRecognizerStateEnded

}; typedef NSUInteger IRMotionRecognizerState;

#endif

@interface IRMotionRecognizer : NSObject

+ (id) recognizerWithQueue:(NSOperationQueue *)aQueue handler:(void(^)(IRMotionRecognizer *recognizer))aHandler;

@property (nonatomic, readonly, retain) NSOperationQueue *queue;
@property (nonatomic, readonly, copy) IRMotionRecognizerHandler handler;
@property (nonatomic, readonly, assign) IRMotionRecognizerState state;
@property (nonatomic, readwrite, getter=isEnabled) BOOL enabled;

@end
