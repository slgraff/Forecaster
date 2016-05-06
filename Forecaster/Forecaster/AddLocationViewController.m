//
//  AddLocationViewController.m
//  Forecaster
//
//  Created by Donny Davis on 5/5/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

#import "AddLocationViewController.h"

@interface AddLocationViewController ()
@property(weak,nonatomic)IBOutlet UIButton* findCityButton;
@end

@implementation AddLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.findCityButton.layer.cornerRadius = 2.0f;
    [[self.findCityButton layer] setBorderWidth:2.0f];
//    [[self.findCityButton layer] setBorderColor:[UIColor colorWithRed:<#(CGFloat)#> green:<#(CGFloat)#> blue:<#(CGFloat)#> alpha:1.0].CGColor];
    
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
