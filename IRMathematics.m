//
//  IRMathematics.m
//  IRMotionRecognizer
//
//  Created by Evadne Wu on 4/10/11.
//  Copyright 2011 Iridia Productions. All rights reserved.
//

#import "IRMathematics.h"

IRSphericalCoordinates IRSphericalCoordinatesMake (double_t distance, IRRadians elevation, IRRadians azimuth) {

	return (IRSphericalCoordinates){ distance, elevation, azimuth };

}

IRSphericalCoordinates IRSphericalCoordinatesMakeWithDegrees (double_t distance, IRDegrees elevation, IRDegrees azimuth) {

	return IRSphericalCoordinatesMake(distance, IRRadiansFromDegrees(elevation), IRRadiansFromDegrees(azimuth));

}

IRSphericalCoordinates IRSphericalCoordinatesMakeWithCartesianCoordinates(double_t x, double_t y, double_t z) {

	IRSphericalCoordinates returnedCoordinates = { 0, 0, 0 };
	
	// r = (x ^ 2 + y ^ 2 + z ^ 2) ^ 0.5
	// θ = cos( z / r ) ^ -1
	// φ = tan( x / y ) ^ -1
	
	double radius, theta, phi;
	
	radius = sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2));
	returnedCoordinates.distance = radius;
	
	if (radius == 0)
	return returnedCoordinates; // all is zero in this sense
	
	phi = asin(z / radius);
	theta = acos(x / (radius * cos(phi)));
	returnedCoordinates.elevation = phi;//pow((double)(acos( z / returnedCoordinates.distance )), -1);
	returnedCoordinates.azimuth = theta;//pow((double)(atan( x / y )), -1);
	
	return returnedCoordinates;

}

IRSphericalCoordinates IRSphericalCoordinatesStandardize(IRSphericalCoordinates coords) {

	return (IRSphericalCoordinates) {
	
		coords.distance,
		IRRadiansStandardize(coords.elevation),
		IRRadiansStandardize(coords.azimuth)
	
	};

}

IRRadians IRRadiansStandardize (IRRadians radians) {

	return IRMathematicsStandardize(radians, (2 * M_PI));

}

extern IRDegrees IRDegreesStandardize (IRDegrees degrees) {

	return IRMathematicsStandardize(degrees, 360);

}

extern IRDegrees IRDegreesFromRadians (IRRadians radians) {

	return radians * (360 / (2 * M_PI));

}

extern IRRadians IRRadiansFromDegrees (IRDegrees degrees) {

	return degrees * ((2 * M_PI) / 360);

}

extern NSString *NSStringFromSphericalCoordinates (IRSphericalCoordinates coords) {
	
	return [NSString stringWithFormat:@"{ Distance: %f, Elevation: %f (%f°), Azimuth: %f (%f°) }",
	
		coords.distance, 
		coords.elevation, IRDegreesFromRadians(coords.elevation),
		coords.azimuth, IRDegreesFromRadians(coords.azimuth) 
	
	];

}
