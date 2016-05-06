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
//        self.title.text = self.detailItem.city;
//        self.weatherLabel.text = self.detailItem.summary;
//    self.temperatureLabel.text = self.detailItem.temperature;
//        self.feelsLikeTempLabel.text = self.detailItem.apparentTemperature;
        
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
