//
//  AppDelegate.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/15.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <Bugly/Bugly.h>

@interface AppDelegate ()<CLLocationManagerDelegate>
{
    CLLocationManager *locationmanager;//定位服务
    NSString *currentCity;//当前城市
    NSString *strlatitude;//经度
    NSString *strlongitude;//纬度
}
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    NSString *agencyId = [[NSUserDefaults standardUserDefaults] objectForKey:@"agencyId"];
    if (agencyId.length==0) {
        LoginViewController *lvc = [[LoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:lvc];
        self.window.rootViewController = nav;
    }
    else
    {
        MainViewController *mvc = [[MainViewController alloc] init];
        self.window.rootViewController = mvc;
    }

    [self getLocation];
    [Bugly startWithAppId:@"b8230683d2"];
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark - 定位

-(void)getLocation
{
    //判断定位功能是否打开
    if ([CLLocationManager locationServicesEnabled]) {
        locationmanager = [[CLLocationManager alloc]init];
        locationmanager.delegate = self;
        [locationmanager requestAlwaysAuthorization];
        currentCity = [NSString new];
        [locationmanager requestWhenInUseAuthorization];
        
        //设置寻址精度
        locationmanager.desiredAccuracy = kCLLocationAccuracyBest;
        locationmanager.distanceFilter = 5.0;
        [locationmanager startUpdatingLocation];
    }
}

#pragma mark 定位成功后则执行此代理方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    [locationmanager stopUpdatingHeading];
    //旧址
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    //打印当前的经度与纬度
    NSLog(@"%f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    
    NSString *latstr = [NSString stringWithFormat:@"%.2f",currentLocation.coordinate.latitude]?:@"0";
    NSString *lngstr = [NSString stringWithFormat:@"%.2f",currentLocation.coordinate.longitude]?:@"0";
    
    [[NSUserDefaults standardUserDefaults] setObject:latstr forKey:@"lat"];
    [[NSUserDefaults standardUserDefaults] setObject:lngstr forKey:@"lng"];
    
    //反地理编码
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            self->currentCity = placeMark.locality;
            if (!self->currentCity) {
                self->currentCity = @"无法定位当前城市";
            }
            
            /*看需求定义一个全局变量来接收赋值*/
            NSLog(@"----%@",placeMark.country);//当前国家
            NSLog(@"%@",self->currentCity);//当前的城市
            [[NSUserDefaults standardUserDefaults] setObject:self->currentCity forKey:@"addname"];
            
        }
    }];
    
}
@end
