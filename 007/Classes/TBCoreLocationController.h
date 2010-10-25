//
//  TBCoreLocationController.h
//  TapPlace
//
//  Created by Thomas Balthazar on 05/10/10.
//  Copyright 2010 Suit My Mind SPRL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@protocol TBCoreLocationControllerDelegate;


@interface TBCoreLocationController : NSObject <
	CLLocationManagerDelegate,
	MKReverseGeocoderDelegate
> {
	@private
	CLLocationManager *locationManager;
	MKReverseGeocoder *reverseGeocoder;
	NSInteger nbFoundLocations;
	float bestHorizontalAccuracy;
	id <TBCoreLocationControllerDelegate> delegate;
}

@property (nonatomic, assign) id <TBCoreLocationControllerDelegate> delegate;

+ (TBCoreLocationController *)sharedInstance;
+ (BOOL)locationServicesEnabled;
- (void)startUpdatingLocation;
- (void)startReverseGeocoderWithLocation:(CLLocation *)location;

@end

@protocol TBCoreLocationControllerDelegate <NSObject>

@required
- (void)didReceiveLocation:(CLLocation *)location;

@optional
- (void)didReceivePlacemark:(MKPlacemark *)placemark; 

@end