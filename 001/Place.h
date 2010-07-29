//
//  Place.h
//  TapPlace
//
//  Created by Thomas Balthazar on 13/07/10.
//  Copyright 2010 Suit My Mind SPRL. All rights reserved.
//
//  This file is part of TapPlace.
//  
//  TapPlace is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//  
//  TapPlace is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//  
//  You should have received a copy of the GNU General Public License
//  along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
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



