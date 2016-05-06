//
//  MasterViewController.h
//  Forecaster
//
//  Created by Donny Davis on 5/5/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

-(BOOL) isZipCode: (NSString*)zipCode;

@end

