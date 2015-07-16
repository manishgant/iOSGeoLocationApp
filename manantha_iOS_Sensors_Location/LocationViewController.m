//
//  LocationViewController.m
//  manantha_iOS_Sensors_Location
//
//  Created by Manishgant on 6/21/15.
//  Copyright (c) 2015 Manishgant. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController ()

@end

@implementation LocationViewController


-(void) viewDidLoad {
    
    [super viewDidLoad];
    
    self->locationManager = [[CLLocationManager alloc] init];
    self->locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self->locationManager.delegate = self;
    [self-> locationManager requestWhenInUseAuthorization];
    
    
    // Zoom into user's current location upon opening the Locate Me view
    
    [currentMapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    
    //Get Curent Location coordinates from current MapView
    currentLocation = [[CLLocation alloc] initWithLatitude:currentMapView.userLocation.coordinate.latitude longitude:currentMapView.userLocation.coordinate.longitude];
    
    //Set Maptype as standard initially on load
    currentMapView.mapType = MKMapTypeStandard;
    NSLog(@"%@", currentMapView.userLocation.title);
    
    //Set Annotation Flag so that even if location fluctuates, there are no multiple annotations
    isAnnotatedOnce = NO;
    
}

/*
 The below method writes the current user location to the log
 */

-(void) locationLogMethod:(NSTimer*) theTimer {
    
    NSLog(@" User is at location %@", locationManager.location.description);
}

/*
 When the location details are updated, call the reverse Geocoding method
 to get the address for the location
 */

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    
    if (!isAnnotatedOnce) {
        [self reverseGeocode:self->locationManager.location];
        isAnnotatedOnce = YES;
    }
    
}


/*
 The below method uses a UITabBarButton to zoom into current location
 whenever the user navigates away from the map. It uses the same zoom level
 that was used on viewDidLoad method
 */

- (IBAction)backToCurrentLocation:(UIBarButtonItem *)sender {
    
    float spanX = 0.00725;
    float spanY = 0.00725;
    MKCoordinateRegion mapRegion;
    mapRegion.center = currentMapView.userLocation.coordinate;
    mapRegion.span = MKCoordinateSpanMake(spanX, spanY);
    
    [currentMapView setRegion:mapRegion animated:YES];
    
    NSLog(@"Pressed Button and Back to Current Location");
    
}

/*
 The Reverse Geocoding method gets the coordinates for the current location
 and performs an Async Callback to get the human readable address from Apple's
 Web service
 
 Also since the annotation depends on the string returned from the service,
 The code for annotations are also encapsulated in this method
 */

- (void)reverseGeocode:(CLLocation *)location {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Finding address");
        if (error) {
            NSLog(@"Error %@", error.description);
        } else {
            CLPlacemark *placemark = [placemarks lastObject];
            
            
            MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
            
            point.coordinate = self->locationManager.location.coordinate;
            
            point.title = [placemark.subThoroughfare stringByAppendingString:@" "];
            point.title = [point.title stringByAppendingString: placemark.thoroughfare];
            
            point.subtitle = [placemark.locality stringByAppendingString:@" "];
            point.subtitle = [point.subtitle stringByAppendingString:placemark.administrativeArea];
            point.subtitle = [point.subtitle stringByAppendingString:@" "];
            point.subtitle = [point.subtitle stringByAppendingString:placemark.postalCode];
            
            MKPinAnnotationView *pinView = [[MKPinAnnotationView alloc]initWithAnnotation:point reuseIdentifier:@"Pin"];
            
            pinView.animatesDrop = TRUE;
            
            pinView.canShowCallout = TRUE;
            
            //Clear old annotations when user switches screen, navigates to different location and comes back
            [currentMapView removeAnnotations:currentMapView.annotations];
            [currentMapView addAnnotation:point];
            [currentMapView selectAnnotation:point animated:YES];
            
            
        }
    }];
}

/*
 The below method is to listen for touch on UISegmentController
 and change the mapview to either Normal, Satellite
 or Hybrid views
 */

- (IBAction)setMapType:(UISegmentedControl *)sender {
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            currentMapView.mapType = MKMapTypeStandard;
            
            mapSegmentController.tintColor = [UIColor colorWithRed: 0.0 green:0.0 blue:255.0 alpha:1];
            NSLog(@"Switched to Normal View");
            break;
        case 1:
            currentMapView.mapType = MKMapTypeSatellite;
            
            mapSegmentController.tintColor = [UIColor colorWithRed: 255.0 green:255.0 blue:255.0 alpha:1];
            NSLog(@"Switched to Satellite View");
            break;
        case 2:
            currentMapView.mapType = MKMapTypeHybrid;
            
            mapSegmentController.tintColor = [UIColor colorWithRed: 255.0 green:255.0 blue:255.0 alpha:1];
            NSLog(@"Switched to Hybrid View");
            break;
        default:
            break;
    }
    
}


/*
 Start the reverse geocode process for the new location once the user comes back into Locate Me View
 Also initiate the timer once location is fixed
 */
-(void) viewWillAppear:(BOOL)animated {
    
    [self->locationManager startUpdatingLocation];
    currentMapView.showsUserLocation = YES;
    [self reverseGeocode:self->locationManager.location];
    
    //Set a NSTimer Object to call the logging function and update location tracking info every 1 second
    myTimer= [NSTimer scheduledTimerWithTimeInterval: 1.0 target:self selector:@selector(locationLogMethod:) userInfo:nil repeats: YES];
    
    
}


/*
 Stop Updating Location once the user switches to Sensors View
 Alo stop writing to the log by invalidating NSTimer object
 */

-(void) viewWillDisappear:(BOOL)animated {
    
    [currentMapView removeAnnotation:currentMapView.annotations.lastObject];
    
    currentMapView.showsUserLocation = NO;
    
    [currentMapView setUserTrackingMode:MKUserTrackingModeNone animated:YES];
    
    [self->locationManager stopUpdatingLocation];
    
    [self->locationManager stopUpdatingHeading];
    
    [myTimer invalidate];
    
    NSLog(@"View has changed.Updating Location has been stopped");
    
    NSLog(@"Writing location info to log is stopped");
    
}

@end