//
//  LocationService.m
//  BusinessArea
//
//  Created by 花晨 on 14-7-30.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "LocationService.h"



@interface LocationService()
@property (nonatomic,copy) GetLocationBlock getLocationBlock;
//@property (nonatomic,assign) ErrorBlock locationErrorBlock;
@property (nonatomic,copy) GetPlacemarkBlock getPlacemarkBlock;
//@property (nonatomic,assign) ErrorBlock placeMarkErrorBlock;


@end
@implementation LocationService
-(CLLocationManager *)locationManager{
    if ([CLLocationManager locationServicesEnabled]) {
        if (!_locationManager) {
            _locationManager = [[CLLocationManager alloc] init];
            _locationManager.delegate = self;
            _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            _locationManager.distanceFilter = kCLDistanceFilterNone;
//            _locationManager.distanceFilter = 1000.0f;
        }

//        _locationManager = [[CLLocationManager alloc] init];
//        _locationManager.delegate = (id)self;
//        _locationManager.distanceFilter = kCLDistanceFilterNone;
//        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//        [_locationManager startUpdatingLocation];
    }else{
        
        SIAlertView *alertViewMe =[[SIAlertView alloc] initWithTitle:@"温馨提示" andMessage:@"您的设备没有开启定位功能，请去设置里打开"];
        [alertViewMe addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:nil];

        [alertViewMe show];
    }

//    if (!_locationManager) {
//        _locationManager = [[CLLocationManager alloc] init];
//        _locationManager.delegate = self;
//        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//        _locationManager.distanceFilter = 1000.0f;
//    }
    return _locationManager;
}
- (void)startLocation
{
    if ([CLLocationManager locationServicesEnabled]) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = (id)self;
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [_locationManager startUpdatingLocation];
    }else{
        SIAlertView *alertViewMe =[[SIAlertView alloc] initWithTitle:@"温馨提示" andMessage:@"您的设备没有开启定位功能，请去设置里打开"];
        [alertViewMe addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:nil];
        
        [alertViewMe show];
    }
}
-(void)stopLocation{
    [_locationManager stopUpdatingLocation];

}

-(void)getMyLocation:(GetLocationBlock)getLocationBlock{
    if (getLocationBlock) {
        self.getLocationBlock = getLocationBlock;
    }
    
}

-(void)getPlacemark:(GetPlacemarkBlock)markBlock{
    [self getMyLocation:^(NSArray *locations, NSError *error) {
        CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
        [geoCoder reverseGeocodeLocation:[locations lastObject] completionHandler:^(NSArray *placemarks, NSError *error) {
            CLPlacemark *placemark;
            if (placemarks.count) {
                placemark = placemarks[0];
            }
            markBlock(placemark,error);
        }];

    }];
}

#pragma mark LocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
	 didUpdateLocations:(NSArray *)locations{
    if (self.getLocationBlock) {
        self.getLocationBlock(locations,nil);
    }

}

//-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
//    if (self.getLocationBlock) {
//        self.getLocationBlock(newLocation,oldLocation,nil);
//    }
//    [manager stopUpdatingLocation];
//}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	NSLog(@"%@",error);
    if (self.getLocationBlock) {
        self.getLocationBlock(nil,error);
    }
}



@end
