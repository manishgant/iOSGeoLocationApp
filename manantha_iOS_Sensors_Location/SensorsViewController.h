//
//  SensorsViewController.h
//  manantha_iOS_Sensors_Location
//
//  Created by Manishgant on 6/21/15.
//  Copyright (c) 2015 Manishgant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface SensorsViewController : UIViewController
{
    //Declare Labels for Andrew ID and timestamp
    __weak IBOutlet UILabel *andrewID;
    
    __weak IBOutlet UILabel *timeStamp;
    
    //Declare Label to display device type
    __weak IBOutlet UILabel *deviceTypeLabel;
    
    
    //Declare Labels to display list of sensors
    __weak IBOutlet UILabel *uiSensorList1;
    
    __weak IBOutlet UILabel *uiSensorList2;
    
    __weak IBOutlet UILabel *uiSensorList3;
    
    __weak IBOutlet UILabel *uiSensorList4;
    
    __weak IBOutlet UILabel *uiSensorList5;
    
    
    
}



@end

