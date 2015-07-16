//
//  LocationViewController.h
//  manantha_iOS_Sensors_Location
//
//  Created by Manishgant on 6/21/15.
//  Copyright (c) 2015 Manishgant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Mapkit/Mapkit.h>
#import <CoreLocation/CLLocationManager.h>

@interface LocationViewController : UIViewController<CLLocationManagerDelegate>

{
    //Declare Elements used in the Storyboard
    __weak IBOutlet MKMapView *currentMapView;
    
    __weak IBOutlet UISegmentedControl *mapSegmentController;
    
    __weak IBOutlet MKUserTrackingBarButtonItem *currentLocationButton ;
    
    // Declare elements used for tracking user location
    CLLocationManager *locationManager;
    
    CLLocation *currentLocation;
    
    BOOL isAnnotatedOnce;
    
    //Declare elements for timed log entry
    NSTimer *myTimer;
    
}

@end

