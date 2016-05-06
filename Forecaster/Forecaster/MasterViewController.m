//
//  MasterViewController.m
//  Forecaster
//
//  Created by Donny Davis on 5/5/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

#import "MasterViewController.h"
#import "CityTableViewCell.h"
#import "DetailViewController.h"
#import "AddLocationViewController.h"
#import "Location.h"
#import "Weather.h"

@interface MasterViewController () <NSURLSessionDelegate>
@property (strong,nonatomic)Location *locationObject;
@property NSMutableData * recievedWeatherData;

// Properties for JSON data received from Google Maps API request
@property NSMutableData *receivedData;
@property NSMutableArray *coordArray;

- (void)getCoordinates:(NSString *)zipCode;
- (void)getForecastlatitude:(float)latitude longitude:(float)longitude;

- (void)updateLocation:(NSDictionary *)locationDataDictionary;
- (void)updateWeather:(NSDictionary *)weatherDataDictionary;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Cities";

    // Do any additional setup after loading the view, typically from a nib.
    
    self.coordArray = [[NSMutableArray alloc]init];
    
    // Hide the separators between cells
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];

    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
    
    // Hide empty cells that don't have data
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)isZipCode:(NSString *)zipCodeString{
    BOOL rc = NO;
    
    NSCharacterSet * set =[NSCharacterSet characterSetWithCharactersInString:@"1234567890"];
    
    rc = ([zipCodeString length] ==5)&&([zipCodeString rangeOfCharacterFromSet:set].location != NSNotFound);
    
    return rc;
    
}


- (IBAction)insertNewObject:(UIStoryboardSegue *)unwindSegue {
    
    AddLocationViewController *newItemALVC = (AddLocationViewController *)unwindSegue.sourceViewController;

    if ([self isZipCode:newItemALVC.zipCodeTextField.text]) {
        // Call method for the Google API here
        [self getCoordinates:newItemALVC.zipCodeTextField.text];
        
        // Call method for the Forecast.io API here
        
        // Populate our data to our models here
        // Location info
        
        // Weather info
  
    }else{
        UIAlertController * alertController =
        [UIAlertController alertControllerWithTitle:@"ERROR"
         
                                            message: @"ZipCode is invalid!"
                                     preferredStyle:UIAlertControllerStyleAlert];
        

        
        
        UIAlertAction *okAlert =
        [UIAlertAction actionWithTitle : @"ok" style:UIAlertActionStyleDefault handler:nil];
        
        
        
        [alertController addAction: okAlert];
                
        [self presentViewController:alertController animated:YES completion:nil];

        
    }

}

#pragma mark - retrieve weather information with API

- (void)getForecastlatitude:(float)latitude longitude:(float)longitude{
    
    //trim coordinates for URL
    
    
    //code format with input from coordinates
    NSString * urlString = [NSString stringWithFormat:@"https://api.forecast.io/forecast/5d288b25264d7b5e082c405582ddc873/%f,%f", latitude, longitude];
    
    //OR hard code raleigh address FOR TESTING
    // NSString * urlString = [NSString stringWithFormat:@"https://api.forecast.io/forecast/5d288b25264d7b5e082c405582ddc873/35.7796, -78.6382"];
    
    //create NS URL from string
    NSURL * url = [NSURL URLWithString:urlString];
    
    //configure what part of processor is being used - main Queue is where all UI elements need to happen
    NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
//pragma mark delegate needs to be set
    NSURLSession * session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    //create data task - which downloads from url
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url];
    
    // tell data task whether to start, stop, resume etc
    [dataTask resume];
}

#pragma mark - getCoordinates

// Send query to Google Maps API to get coordinates (latitude & longitude), city, state given input of zip code
- (void)getCoordinates: (NSString *)zipCode {
    

    // Sample Google Maps API call without city name or sensor (not required)
    // https://maps.googleapis.com/maps/api/geocode/json?&components=postal_code:27701
    
    // Create string which puts together api address plus zip code
    NSString * urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?&components=postal_code:%@",zipCode];
    
    // Create NS URL from string
    NSURL * url = [NSURL URLWithString:urlString];
    
    // Configure what part of processor is being used - main Queue is where all UI elements need to happen
    NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    // Create data task - which downloads from URL
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url];
    
    // Tell data task whether to start, stop, resume etc
    [dataTask resume];
    
}

#pragma mark - Update Location and Weather

- (void)updateLocation:(NSDictionary *)locationDataDictionary {
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *locationEntity = [[self.fetchedResultsController fetchRequest] entity];
    self.locationObject = [NSEntityDescription insertNewObjectForEntityForName:[locationEntity name] inManagedObjectContext:context];
    
    NSArray *resultsArray = locationDataDictionary[@"results"];
    self.locationObject.latitude = resultsArray[0][@"geometry"][@"location"][@"lat"];
    self.locationObject.longitude = resultsArray[0][@"geometry"][@"location"][@"lng"];
    NSArray *addressComponentsArray = resultsArray[0][@"address_components"];
    for (NSDictionary *addressInfo in addressComponentsArray) {
        if ([addressInfo[@"types"][0] isEqualToString:@"postal_code"]) {
            self.locationObject.zipCode = [NSNumber numberWithInteger:[addressInfo[@"short_name"] integerValue]];
        }
        if ([addressInfo[@"types"][0] isEqualToString:@"locality"]) {
            self.locationObject.city = addressInfo[@"long_name"];
        }
        if ([addressInfo[@"types"][0] isEqualToString:@"administrative_area_level_1"]) {
            self.locationObject.state = addressInfo[@"short_name"];
        }
    }
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    [self getForecastlatitude:[self.locationObject.latitude floatValue] longitude:[self.locationObject.longitude floatValue]];
    
}

- (void)updateWeather:(NSDictionary *)weatherDataDictionary {
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *weatherEntity= [NSEntityDescription entityForName:@"Weather" inManagedObjectContext:context];
    Weather *weatherObject = [NSEntityDescription insertNewObjectForEntityForName:[weatherEntity name] inManagedObjectContext:context];
  
    

    weatherObject.temperature = [NSNumber numberWithInteger:[weatherDataDictionary [@"currently"][@"temperature"] integerValue]];
    weatherObject.summary = weatherDataDictionary[@"currently"][@"summary"];
    weatherObject.apparentTemperature = [NSNumber numberWithInteger:[weatherDataDictionary[@"currently"][@"apparentTemperature"] integerValue]];
    self.locationObject.forecast = weatherObject;
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Location *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CityTableViewCell *cell = (CityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CityCell" forIndexPath:indexPath];
    Location *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    
    cell.city.text = object.city;
    [self configureCell:cell withObject:object];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
            
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void)configureCell:(CityTableViewCell *)cell withObject:(Location *)object {
//    NSString *temperatureString = [NSString stringWithFormat:@"%@℉", object.temperature];
//    cell.temperature.text = temperatureString;
//    cell.summary.text = object.summary;
    cell.city.text = object.city;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}


#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *locationEntity = [NSEntityDescription entityForName:@"Location" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:locationEntity];
    
    NSEntityDescription *weatherEntity = [NSEntityDescription entityForName:@"Weather" inManagedObjectContext:self.managedObjectContext];
//    [fetchRequest setEntity:weatherEntity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"city" ascending:YES];

    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
	     // Replace this implementation with code to handle the error appropriately.
	     // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _fetchedResultsController;
}    

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            return;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] withObject:anObject];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

/*
// Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // In the simplest, most efficient, case, reload the table view.
    [self.tableView reloadData];
}
 */

#pragma mark - NSURLSessionDelegate

//bring in data task information
//- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
//    didReceiveData:(NSData *)data{
//    //use variable created above. create loop to incrementaly add to our mutable data variable
//    if (!self.recievedWeatherData) {
//        self.recievedWeatherData = [[NSMutableData alloc]initWithData:data];
//    }else{
//        [self.recievedWeatherData appendData:data];
//    }
//}



////figure out if the download happened with or without an error
//- (NSDictionary*)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
//didCompleteWithError:(nullable NSError *)error{
//    
//    if (!error) {
//        NSDictionary * jsonResponse = [NSJSONSerialization JSONObjectWithData:self.recievedWeatherData options:NSJSONReadingMutableContainers error:nil];
//               return jsonResponse;
//    }
//    return nil;
//}
//
//
////magic code
//- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
//{
//    completionHandler(NSURLSessionResponseAllow);
//}

// Used when we receive data
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    
    // Check to see if receivedData exists
    if(!self.receivedData) {
        // If there is nothing in variable initialize it with received data
        self.receivedData = [[NSMutableData alloc]initWithData:data];
    } else {
        // If it does exist already, append received data
        [self.receivedData appendData:data];
    }
}

// Used when we get an error
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
        didCompleteWithError:(nullable NSError *)error {
    if (!error) {
        // NSLog(@"Download successful! %@", [self.receivedData description]);
        
        // Puts the data received into mutable arrays and dictionaries
        NSDictionary * jsonResponse = [NSJSONSerialization JSONObjectWithData:self.receivedData options:NSJSONReadingMutableContainers error:nil];
        if (jsonResponse[@"results"]) {
            // Update our location data model
        [self updateLocation:jsonResponse];
            
        }else if(jsonResponse[@"currently"]){
            [self updateWeather:jsonResponse];
        }
    }
    self.receivedData = nil;
}

// didReceiveResponse implementation
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    completionHandler(NSURLSessionResponseAllow);
}


@end
