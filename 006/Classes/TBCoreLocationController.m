//
//  TBCoreLocationController.m
//  TapPlace
//
//  Created by Thomas Balthazar on 05/10/10.
//  Copyright 2010 Suit My Mind SPRL. All rights reserved.
//

#import "TBCoreLocationController.h"

#define kCoreLocationDistanceFilter 5.0


#pragma mark -
#pragma mark -
#pragma mark Private properties/methods

@interface TBCoreLocationController ()

@property (nonatomic, readonly) CLLocationManager *locationManager;

@end


#pragma mark -
#pragma mark -
#pragma mark Implementation


@implementation TBCoreLocationController

static TBCoreLocationController *sharedInstance = nil;


- (CLLocationManager *)locationManager {
    if(locationManager!=nil) {
        return locationManager;
    }
    locationManager = [[CLLocationManager alloc] init];
	locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	locationManager.distanceFilter = kCoreLocationDistanceFilter;
	locationManager.delegate = self;
	
    return locationManager;
}

+ (BOOL)locationServicesEnabled {
	return [CLLocationManager locationServicesEnabled];
}


#pragma mark -
#pragma mark public methods

- (void)startUpdatingLocation {
	NSLog(@"start updating location…");
	[[self locationManager] startUpdatingLocation];
}


#pragma mark -
#pragma mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
	NSLog(@"did receive a location…");
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
	NSLog(@"did receive an error…");
}


#pragma mark -
#pragma mark Singleton methods

+ (TBCoreLocationController *)sharedInstance {
	if (sharedInstance==nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [[self sharedInstance] retain];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax;  //denotes an object that cannot be released
}

- (void)release
{
    //do nothing
}

- (id)autorelease
{
    return self;
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[locationManager release];
	NSLog(@"=== SHOULD NEVER BE DEALLOCATED ===");

	[super dealloc];
}


@end
