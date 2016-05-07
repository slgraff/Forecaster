//
//  DetailViewController.m
//  Forecaster
//
//  Created by Donny Davis on 5/5/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

#import "DetailViewController.h"
#import "MasterViewController.h"
#import "Location.h"
#import "Weather.h"
@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        
        
        Weather *weatherObject = (Weather*)self.detailItem.forecast;
        NSString *temperatureString = [NSString stringWithFormat:@"%ld℉", [weatherObject.temperature integerValue]];
        NSString *feelsLikeTemp = [NSString stringWithFormat:@"Feels Like %ld℉", [weatherObject.apparentTemperature integerValue]];
        
        self.title = self.detailItem.city;
        self.weatherLabel.text = weatherObject.summary;
        self.temperatureLabel.text = temperatureString;
        self.feelsLikeTempLabel.text = feelsLikeTemp;
        if (![weatherObject.image isEqualToString:@""]){
            self.weatherImage.image = [UIImage imageNamed:weatherObject.image];
            
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentLabel.text =@"CURRENTLY";
    
    
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
