//
//  IRMathematics.h
//  IRMotionRecognizer
//
//  Created by Evadne Wu on 4/10/11.
//  Copyright 2011 Iridia Productions. All rights reserved.
//

// #import <Foundation/Foundation.h>

#import <math.h>

#ifndef __IRMathmatics__
#define __IRMathmatics__

#define IRMathematicsStandardize(value, range) fmod( (double_t)(fmod((double_t)(value), (double_t)(range)) + (range)), (double_t)range )

typedef double_t IRRadians;
typedef double_t IRDegrees;

typedef struct IRSphericalCoordinates {
	
	double_t distance; // r
	IRRadians elevation; // θ
	IRRadians azimuth; // φ
	
} IRSphericalCoordinates;

#endif

extern NSString *NSStringFromSphericalCoordinates (IRSphericalCoordinates coords);
// extern IRSphericalCoordinates IRSphericalCoordinatesFromString (NSString *aString);

extern IRSphericalCoordinates IRSphericalCoordinatesMake (double_t distance, IRRadians elevation, IRRadians azimuth);
extern IRSphericalCoordinates IRSphericalCoordinatesMakeWithDegrees (double_t distance, IRDegrees elevation, IRDegrees azimuth);
extern IRSphericalCoordinates IRSphericalCoordinatesMakeWithCartesianCoordinates (double_t x, double_t y, double_t z);
extern IRSphericalCoordinates IRSphericalCoordinatesStandardize (IRSphericalCoordinates coords);

extern IRRadians IRRadiansStandardize (IRRadians radians);
extern IRDegrees IRDegreesStandardize (IRDegrees degrees);

extern IRDegrees IRDegreesFromRadians (IRRadians radians);
extern IRRadians IRRadiansFromDegrees (IRDegrees degrees);
