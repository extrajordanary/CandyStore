//
//  CandyMapViewController.h
//  CandyStore
//
//  Created by Jordan on 9/23/14.
//  Copyright (c) 2014 Byjor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h> 

@interface CandyMapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *candyMap;

@property (strong, nonatomic) CLLocationManager *locationManager;
@end
