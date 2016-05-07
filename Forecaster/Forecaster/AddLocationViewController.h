//
//  AddLocationViewController.h
//  Forecaster
//
//  Created by Donny Davis on 5/5/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol AddLocationDelegate <NSObject>

- (void)insertNewObject:(NSString *)zipCodeString;

@end

@interface AddLocationViewController : UIViewController

@property (weak, nonatomic) id<AddLocationDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *zipCodeTextField;

@end
