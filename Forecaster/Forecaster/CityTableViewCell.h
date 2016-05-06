//
//  CityTableViewCell.h
//  Forecaster
//
//  Created by Donny Davis on 5/6/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *temperature;
@property (weak, nonatomic) IBOutlet UILabel *summary;
@property (weak, nonatomic) IBOutlet UILabel *city;

@end
