//
//  Location+CoreDataProperties.h
//  Forecaster
//
//  Created by Donny Davis on 5/7/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Location.h"

NS_ASSUME_NONNULL_BEGIN

@interface Location (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *city;
@property (nullable, nonatomic, retain) NSNumber *latitude;
@property (nullable, nonatomic, retain) NSNumber *longitude;
@property (nullable, nonatomic, retain) NSString *state;
@property (nullable, nonatomic, retain) NSNumber *zipCode;
@property (nullable, nonatomic, retain) NSString *image;
@property (nullable, nonatomic, retain) NSString *summary;
@property (nullable, nonatomic, retain) NSNumber *apparentTemperature;
@property (nullable, nonatomic, retain) NSNumber *temperature;

@end

NS_ASSUME_NONNULL_END
