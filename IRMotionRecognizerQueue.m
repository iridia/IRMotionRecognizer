//
//  IRMotionRecognizerQueue.m
//  IRMotionRecognizer
//
//  Created by Evadne Wu on 5/29/11.
//  Copyright 2011 Iridia Productions. All rights reserved.
//

#import "IRMotionRecognizerQueue.h"


@implementation IRMotionRecognizerQueue

- (void) cancelAllOperations {
	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	[super cancelAllOperations];
	[pool drain];

}

@end
