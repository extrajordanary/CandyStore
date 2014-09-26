//
//  CandyMapViewController.m
//  CandyStore
//
//  Created by Jordan on 9/23/14.
//  Copyright (c) 2014 Byjor. All rights reserved.
//

#import "CandyMapViewController.h"
//#import "AppDelegate.h"

@interface CandyMapViewController ()

@property double userLat;
@property double userLon;
@property (strong, nonatomic) IBOutlet UISwitch *editMode;

@end

#define METERS_PER_MILE 1609.344

@implementation CandyMapViewController {
    MKPointAnnotation *pressPoint;
    BOOL isEditable;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self startStandardUpdates];
    
    self.candyMap.showsUserLocation = YES;
    isEditable = NO;
    
    // set up long press detection for editing mode
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(mapViewLongPressed:)];
    [longPress setAllowableMovement:10.];
    [longPress setMinimumPressDuration:.5];
    [self.candyMap addGestureRecognizer:longPress];
    
    pressPoint = [[MKPointAnnotation alloc] init];
    [pressPoint setTitle:self.candy.name];
}

- (void)viewWillAppear:(BOOL)animated {
//    [self startStandardUpdates];
//    
//    self.candyMap.showsUserLocation = YES;
//    isEditable = NO;
//    
//    // set up long press detection for editing mode
//    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(mapViewLongPressed:)];
//    [longPress setAllowableMovement:10.];
//    [longPress setMinimumPressDuration:.5];
//    [self.candyMap addGestureRecognizer:longPress];
//    
//    pressPoint = [[MKPointAnnotation alloc] init];
//    [pressPoint setTitle:self.candy.name];
    
//    // get candy location or use current location if not already assigned
//    if ([self.candy.locationLat doubleValue] != 0 && [self.candy.locationLon doubleValue] != 0) {
//        self.candyLocation = CLLocationCoordinate2DMake([self.candy.locationLat doubleValue], [self.candy.locationLon doubleValue]);
//
//    } else {
//        self.candyLocation = self.locationManager.location.coordinate;
//    }
//
//    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(self.candyLocation, 3*METERS_PER_MILE, 3*METERS_PER_MILE);
//    [self.candyMap setRegion:viewRegion animated:YES];
//
//    pressPoint.coordinate = self.candyLocation;
//    [self.candyMap addAnnotation:pressPoint];
}

- (void)viewDidAppear:(BOOL)animated {
    // get candy location or use current location if not already assigned
    if ([self.candy.locationLat doubleValue] != 0 && [self.candy.locationLon doubleValue] != 0) {
        self.candyLocation = CLLocationCoordinate2DMake([self.candy.locationLat doubleValue], [self.candy.locationLon doubleValue]);
        
    } else {
        self.candyLocation = self.locationManager.location.coordinate;
    }
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(self.candyLocation, 3*METERS_PER_MILE, 3*METERS_PER_MILE);
    [self.candyMap setRegion:viewRegion animated:YES];
    
    pressPoint.coordinate = self.candyLocation;
    [self.candyMap addAnnotation:pressPoint];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillDisappear:(BOOL)animated {
    [self updateCandyCoords];
}
#pragma mark - Locations

- (void)startStandardUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (nil == self.locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
    }
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    // Set a movement threshold for new events.
    self.locationManager.distanceFilter = 500; // meters
    
    [self.locationManager requestAlwaysAuthorization];

    [self.locationManager startUpdatingLocation];
}

// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];
    
//    NSDate* eventDate = location.timestamp;
//    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    
//    if (abs(howRecent) < 15.0) {
    self.userLat = location.coordinate.latitude;
    self.userLon = location.coordinate.longitude;
        // If the event is recent, do something with it.
        NSLog(@"latitude %+.6f, longitude %+.6f\n",
              location.coordinate.latitude,
              location.coordinate.longitude);
//    }
}

//- (void) plotCandyPosition {
//    CandyLocation *candyLocation = [[CandyLocation alloc] initWithName:self.candy.name address:nil coordinate:self.candyLocation];
//    [self.candyMap addAnnotation:candyLocation];
//}

- (void) updateCandyCoords {
    self.candy.locationLat = [NSNumber numberWithDouble:pressPoint.coordinate.latitude];
    self.candy.locationLon = [NSNumber numberWithDouble:pressPoint.coordinate.longitude];

    NSManagedObjectContext *context = self.candy.managedObjectContext;
    NSError *error = nil;
    [context save:&error];
    if (error) {
        // error handling
    }
}

- (void) mapViewLongPressed:(UILongPressGestureRecognizer*)recognizer {
    if (isEditable) {
        [self.candyMap removeAnnotation:pressPoint];
        
        CGPoint point = [recognizer locationInView:self.candyMap];
        
        CLLocationCoordinate2D tapPoint = [self.candyMap convertPoint:point toCoordinateFromView:self.view];
        
        //    MKPointAnnotation *point1 = [[MKPointAnnotation alloc] init];
        
        pressPoint.coordinate = tapPoint;
        
        [self.candyMap addAnnotation:pressPoint];
    }
}

- (IBAction)toggleEditMode:(id)sender {
    if (self.editMode.on) {
        isEditable = YES;
    } else {
        isEditable = NO;
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//     //Get the new view controller using [segue destinationViewController].
//     //Pass the selected object to the new view controller.
//}

@end
