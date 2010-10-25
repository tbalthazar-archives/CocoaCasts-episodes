//
//  TBCoreLocationController.m
//  TapPlace
//
//  Created by Thomas Balthazar on 05/10/10.
//  Copyright 2010 Suit My Mind SPRL. All rights reserved.
//

#import "TBCoreLocationController.h"

#define kCoreLocationDistanceFilter 5.0
#define kCoreLocationOldLocationValidity 2.0


#pragma mark -
#pragma mark -
#pragma mark Private properties/methods

@interface TBCoreLocationController ()

@property (nonatomic, readonly) CLLocationManager *locationManager;
@property (nonatomic, retain) MKReverseGeocoder *reverseGeocoder;

- (void)didReceiveLocation:(CLLocation *)location;
- (void)didReceivePlacemark:(MKPlacemark *)placemark;

@end


#pragma mark -
#pragma mark -
#pragma mark Implementation


@implementation TBCoreLocationController

@synthesize delegate, reverseGeocoder;

static TBCoreLocationController *sharedInstance = nil;

- (id)init {
	if (self = [super init]) {
		nbFoundLocations = 0;
		bestHorizontalAccuracy = 0.0;
	}
	return self;
}


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

- (void)startReverseGeocoderWithLocation:(CLLocation *)location {
	// make sure we cancel the previous reverseGeocoder
	if (self.reverseGeocoder!=nil) {
		[self.reverseGeocoder cancel];
		self.reverseGeocoder.delegate = nil;
		[reverseGeocoder release];
		reverseGeocoder = nil;
	}

	MKReverseGeocoder *geocoder = [[MKReverseGeocoder alloc] 
								   initWithCoordinate:location.coordinate];
	self.reverseGeocoder = geocoder;
	[geocoder release];
	self.reverseGeocoder.delegate = self;
	[self.reverseGeocoder start];
}



#pragma mark -
#pragma mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
	// --- test if the location we receive can be considered as valid
	BOOL isVeryFirstLocation = (oldLocation==nil);
	NSDate* eventDate = newLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
	BOOL isInvalidFirstLocation = isVeryFirstLocation && 
									abs(howRecent) > kCoreLocationOldLocationValidity;

	// --- return immediately if it is not valid
	if (newLocation.horizontalAccuracy < 0.0f || isInvalidFirstLocation) {
		return;
	}
	else {
		// --- we found a valid location, we will keep it if :
		//		- it is the first *valid* location OR
		//		- this location is more accurate than the previous one OR
		//		- we have moved 'significantly' from the previous location
		nbFoundLocations+=1;
		BOOL isFirstValidLocation = (nbFoundLocations==1);
		BOOL isMoreAccurate = newLocation.horizontalAccuracy < bestHorizontalAccuracy;
		float distanceFromOldLocation = [newLocation distanceFromLocation:oldLocation];
		BOOL hasMovedSignificantly = distanceFromOldLocation > kCoreLocationDistanceFilter;

		if (isFirstValidLocation || isMoreAccurate || hasMovedSignificantly) {
			bestHorizontalAccuracy = newLocation.horizontalAccuracy;
			[self didReceiveLocation:newLocation];
		}				
	}	
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
	NSLog(@"did receive an error…");
}


#pragma mark -
#pragma mark MKReverseGeocoderDelegate

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder 
	   didFindPlacemark:(MKPlacemark *)placemark {
	[self didReceivePlacemark:placemark];
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder
	   didFailWithError:(NSError *)error {
	NSLog(@"did receive an error…");
}


#pragma mark -
#pragma mark delegate methods

- (void)didReceiveLocation:(CLLocation *)location {
	if ([self.delegate respondsToSelector:@selector(didReceiveLocation:)]) {
		[self.delegate didReceiveLocation:location];
	}	
}

- (void)didReceivePlacemark:(MKPlacemark *)placemark {
	if ([self.delegate respondsToSelector:@selector(didReceivePlacemark:)]) {
		[self.delegate didReceivePlacemark:placemark];
	}
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
	[reverseGeocoder release];
	self.delegate = nil;
	NSLog(@"=== SHOULD NEVER BE DEALLOCATED ===");

	[super dealloc];
}


@end
