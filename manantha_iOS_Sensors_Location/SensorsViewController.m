//
//  SensorsViewController.m
//  manantha_iOS_Sensors_Location
//
//  Created by Manishgant on 6/21/15.
//  Copyright (c) 2015 Manishgant. All rights reserved.
//

#import "SensorsViewController.h"

@interface SensorsViewController ()

@end

@implementation SensorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Assign Andrew ID to the corresponding label
    
    andrewID.text = @"manantha";
    [andrewID setEnabled:YES];
    
    //Get and display Device type
    deviceTypeLabel.text = [UIDevice currentDevice].model;
    
    //Declare mutable NSArray to store Sensors Log information
    NSMutableArray *sensorLog = [[NSMutableArray alloc] init];
    
    //Find out Available Sensors - The corresponding methods are written below
    
    if ([self isGPSAvailable]) {
        
        uiSensorList1.text = @"GPS";
        [uiSensorList1 setEnabled:YES];
        [sensorLog addObject:@"GPS"];
        
    } else {
        
        uiSensorList1.text = @"No GPS";
        [uiSensorList1 setEnabled:NO];
        [sensorLog addObject:@" No GPS"];
    }
    
    if ([self isAccelerometerAvailable]) {
        
        
        uiSensorList2.text = @"Accelerometer";
        [uiSensorList2 setEnabled:YES];
        [sensorLog addObject:@"Accelerometer"];
    }
    
    
    if ([self isGyroscopeAvailable]) {
        
        
        uiSensorList3.text = @"Gyroscope";
        [uiSensorList3 setEnabled:YES];
        [sensorLog addObject:@"Gyroscope"];
    }
    
    
    if ([self isMagnetoMeterAvailable]) {
        
        uiSensorList4.text = @"Magnetometer";
        [uiSensorList4 setEnabled:YES];
        [sensorLog addObject:@"Magnetometer"];
    }
    
    
    if ([self isMotionDetectorAvailable]) {
        
        
        uiSensorList5.text = @"Motion Detector";
        [uiSensorList5 setEnabled:YES];
        [sensorLog addObject:@"Motion Detector"];
        
    }
    
    //Print the available sensor information to Output Console
    
    NSLog(@"List of Available Sensors: %@",sensorLog);
    
}

//Use the below method to get and refresh current time, everytime Sensors tab is loaded

-(void)viewWillAppear:(BOOL)animated {
    //Declare Date datatype to obtain current time
    NSDate *date = [[NSDate alloc]init];
    
    //Declare Date Formatter to format date according to problem
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    //Write the current date to Output Console
    NSLog(@"User's current Date & Time: %@",date);
    
    //Assign the current time to Label in UI
    timeStamp.text = dateString;
    [timeStamp setEnabled:YES];
    
}

/*
 The following are the methods to check if the device has the particular Sensor or not
 
 There are isXAvailablMethods to check if the Sensors are availale
 
 There are also isXActiveMethods to check if a paricular sensor is active or not
 */

- (BOOL) isGPSAvailable;
{
    NSString *deviceType = [UIDevice currentDevice].model;
    
    if ([deviceType isEqualToString:@"iPod5,1"] || [deviceType isEqualToString:@"iPad2,1"] || [deviceType isEqualToString:@"iPad2,4"] || [deviceType isEqualToString:@"iPad3,1"] || [deviceType isEqualToString:@"iPad3,4"] || [deviceType isEqualToString:@"iPad2,5"] || [deviceType isEqualToString:@"iPad4,1"] || [deviceType isEqualToString:@"iPad4,4"]) {
        
        return FALSE;
        
    } else {
        
        return TRUE;
    }
    
}


- (BOOL) isGyroscopeAvailable
{
    CMMotionManager *motionManager = [[CMMotionManager alloc] init];
    BOOL gyroAvailable = motionManager.gyroAvailable;
    return gyroAvailable;
    
}

- (BOOL) isGyroscopeActive
{
    CMMotionManager *motionManager = [[CMMotionManager alloc] init];
    BOOL gyroActive = motionManager.gyroActive;
    return gyroActive;
    
}



- (BOOL) isAccelerometerAvailable
{
    CMMotionManager *motionManager = [[CMMotionManager alloc] init];
    BOOL accelAvailable = motionManager.accelerometerAvailable;
    return accelAvailable;
    
}

- (BOOL) isAccelerometerActive
{
    CMMotionManager *motionManager = [[CMMotionManager alloc] init];
    BOOL accelActive = motionManager.accelerometerActive;
    return accelActive;
    
}


- (BOOL) isMagnetoMeterAvailable
{
    CMMotionManager *motionManager = [[CMMotionManager alloc] init];
    BOOL magnetoMAvailable = motionManager.magnetometerAvailable;
    return magnetoMAvailable;
    
}

- (BOOL) isMagnetoMeterActive
{
    CMMotionManager *motionManager = [[CMMotionManager alloc] init];
    BOOL magnetoMActive = motionManager.magnetometerActive;
    return magnetoMActive;
    
}

- (BOOL) isMotionDetectorAvailable
{
    CMMotionManager *motionManager = [[CMMotionManager alloc] init];
    BOOL motionDetectorAvailable = motionManager.deviceMotionAvailable;
    return motionDetectorAvailable;
    
}

- (BOOL) isMotionDetectorActive
{
    CMMotionManager *motionManager = [[CMMotionManager alloc] init];
    BOOL motionDetectorActive = motionManager.deviceMotionActive;
    return motionDetectorActive;
    
}

@end

