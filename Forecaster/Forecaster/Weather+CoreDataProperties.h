//
//  Weather+CoreDataProperties.h
//  Forecaster
//
//  Created by Donny Davis on 5/5/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Weather.h"

NS_ASSUME_NONNULL_BEGIN

@interface Weather (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *temperature;
@property (nullable, nonatomic, retain) NSNumber *apparentTemperature;
@property (nullable, nonatomic, retain) NSString *summary;
@property (nullable, nonatomic, retain) NSString *image;
@property (nullable, nonatomic, retain) NSSet<Location *> *location;

@end

@interface Weather (CoreDataGeneratedAccessors)

- (void)addLocationObject:(Location *)value;
- (void)removeLocationObject:(Location *)value;
- (void)addLocation:(NSSet<Location *> *)values;
- (void)removeLocation:(NSSet<Location *> *)values;

@end

NS_ASSUME_NONNULL_END
