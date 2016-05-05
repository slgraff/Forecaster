//
//  Location+CoreDataProperties.m
//  Forecaster
//
//  Created by Donny Davis on 5/5/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Location+CoreDataProperties.h"

@implementation Location (CoreDataProperties)

@dynamic city;
@dynamic state;
@dynamic zipCode;
@dynamic latitude;
@dynamic longitude;
@dynamic forecast;

@end
