//
//  AddLocationViewController.m
//  Forecaster
//
//  Created by Donny Davis on 5/5/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

#import "AddLocationViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface AddLocationViewController ()

@end

@implementation AddLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[myButton layer] setBorderWidth:2.0f];
//    [[myButton layer] setBorderColor:[UIColor whiteColor].CGColor];
    
//    self.buttonTag.layer.borderWidth = 1.0f;
//    self.buttonCancel.layer.borderWidth = 1.0f;
//    
//    self.buttonTag.layer.borderColor = [UIColor blueColor].CGColor;
//    self.buttonCancel.layer.borderColor = [UIColor blueColor].CGColor;
//    
//    self.buttonTag.layer.cornerRadius = 4.0f;
//    self.buttonCancel.layer.cornerRadius = 4.0f;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
