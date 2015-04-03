//
//  LocationService.h
//  BusinessArea
//
//  Created by 花晨 on 14-7-30.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocation.h>

typedef void(^GetLocationBlock)(NSArray *locations,NSError *error);
typedef void(^ErrorBlock)(NSError *error);

typedef void(^GetPlacemarkBlock)(CLPlacemark * placeMark,NSError *error);


@interface LocationService : NSObject<CLLocationManagerDelegate>
@property (nonatomic,strong) CLLocationManager *locationManager;

-(void)getMyLocation:(GetLocationBlock)getLocationBlock;

-(void)getPlacemark:(GetPlacemarkBlock)markBlock;
-(void)startLocation;
-(void)stopLocation;


@end
