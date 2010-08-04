//
//  Place.h
//  TapPlace
//
//  Created by Thomas Balthazar on 13/07/10.
//  Copyright 2010 Suit My Mind SPRL. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Place :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * subAdministrativeArea;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * countryCode;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSString * administrativeArea;
@property (nonatomic, retain) NSString * subLocality;
@property (nonatomic, retain) NSString * thoroughfare;
@property (nonatomic, retain) NSString * subThoroughfare;
@property (nonatomic, retain) NSString * postalCode;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * locality;
@property (nonatomic, retain) NSNumber * horizontalAccuracy;

@end



