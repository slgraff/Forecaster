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

- (BOOL)isZipCode:(NSString *)zipCodeString;
- (void)displayErrorForTitle:(NSString *)title andMessage:(NSString *)message;
@end

@implementation AddLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.findCityButton.layer.cornerRadius = 7.0f;
    [[self.findCityButton layer] setBorderWidth:2.0f];
    [[self.findCityButton layer] setBorderColor:[UIColor colorWithRed:(64/255.0) green:(123/255.0) blue:(152/255.0) alpha:1.0].CGColor];
    [self.zipCodeTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Actions

- (IBAction)cancelAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)findCityAction:(UIButton *)sender {
    
    if (![self isZipCode:self.zipCodeTextField.text]) {
        [self displayErrorForTitle:@"Error" andMessage:@"Invalid zip code entered."];
    } else {
        [self.delegate insertNewObject:self.zipCodeTextField.text];
    }
    
}

#pragma mark - Error handling

- (BOOL)isZipCode:(NSString *)zipCodeString{
    BOOL rc = NO;
    
    NSCharacterSet * set =[NSCharacterSet characterSetWithCharactersInString:@"1234567890"];
    
    rc = ([zipCodeString length] ==5)&&([zipCodeString rangeOfCharacterFromSet:set].location != NSNotFound);
    
    return rc;
    
}

- (void)displayErrorForTitle:(NSString *)title andMessage:(NSString *)message {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message: message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAlert = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction: okAlert];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
