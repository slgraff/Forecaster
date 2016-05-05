//
//  Forecast.m
//  Forecaster
//
//  Created by Allen Spicer on 5/5/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

#import "Forecast.h"

@implementation Forecast

+(Forecast*)forecastWithDictionary:(NSDictionary *) forecastDictionary
{
    Forecast *aForecast = nil;
    if (forecastDictionary)
    {
        if (forecastDictionary) {
        aForecast = [[Forecast alloc]init];
        aForecast.apparentTemperature = [forecastDictionary objectForKey:@"apparentTemperature"];
        aForecast.summary = [forecastDictionary objectForKey:@"summary"];
        aForecast.temperature = [forecastDictionary objectForKey:@"temperature"];
                                }

    }
    return aForecast;
}
@end