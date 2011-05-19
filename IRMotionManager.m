//
//  IRMotionManager.m
//  IRMotionRecognizer
//
//  Created by Evadne Wu on 5/18/11.
//  Copyright 2011 Iridia Productions. All rights reserved.
//

#import "IRMotionManager.h"

@implementation IRMotionManager

#if 0

void (^autoreleased)(void(^)(void)) = ^ (void(^block)(void)) {

	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	block();
	[pool drain];

};

- (id) retain {

	autoreleased(^{ Log(@"%x retain %@", (unsigned int)self, [NSThread callStackSymbols]); });
	return [super retain];

}

- (id) autorelease {

	autoreleased(^{ Log(@"%x autorelease %@", (unsigned int)self, [NSThread callStackSymbols]); });
	return [super autorelease];

}

- (void) release {

	autoreleased(^{ Log(@"%x release %@", (unsigned int)self, [NSThread callStackSymbols]); });
	[super release];

}

- (void) dealloc {

	autoreleased(^{ Log(@"%x dealloc %@ \n", (unsigned int)self, [NSThread callStackSymbols]); });
	[super dealloc];

}

#endif

@end
