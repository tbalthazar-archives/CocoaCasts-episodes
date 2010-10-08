//
//  TBCoreLocationController.h
//  TapPlace
//
//  Created by Thomas Balthazar on 05/10/10.
//  Copyright 2010 Suit My Mind SPRL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface TBCoreLocationController : NSObject <CLLocationManagerDelegate> {
	@private
	CLLocationManager *locationManager;
}

+ (TBCoreLocationController *)sharedInstance;
+ (BOOL)locationServicesEnabled;
- (void)startUpdatingLocation;

@end
