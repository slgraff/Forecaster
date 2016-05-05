//
//  Forecast.h
//  Forecaster
//
//  Created by Allen Spicer on 5/5/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Forecast : NSObject


@property (strong, nonatomic) NSString *apparentTemperature;
@property (strong, nonatomic) NSString *summary;
@property (strong, nonatomic) NSString *temperature;

+(Forecast*)forecastWithDictionary:(NSDictionary *) forecastDictionary;

@end
