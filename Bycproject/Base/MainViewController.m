//
//  MainViewController.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/15.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "MainViewController.h"
#import "BycnavViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *array;
    array = @[@"HomeViewController",@"FindViewController",@"ChangeViewController",@"MineViewController"];
    NSArray *imgArray = @[@"icon_shouye",@"icon_zhuangxiu",@"icon_jiancai",@"icon_wo"];
    NSArray *nameArray = @[@"首页",@"找装修",@"选建材",@"我的",@"我的"];
    NSArray *titleArray = @[@"",@"",@"",@""];
    NSArray *sImageArray = @[@"icon_shouye_jihuo",@"icon_zhuangxiu_jihuo",@"icon_jiancai_jihuo",@"icon_wo_jihuo"];
    if (@available(iOS 13.0, *)) {
        [[UITabBar appearance] setUnselectedItemTintColor:[UIColor lightGrayColor]];
    }
    for (int i = 0; i < 4; i++) {
        
        Class class = NSClassFromString(array[i]);
        UIViewController *vc = [[class alloc] init];
        BycnavViewController *nvc = [[BycnavViewController alloc] initWithRootViewController:vc];
        UIImage *image = [UIImage imageNamed:imgArray[i]];
        nvc.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        nvc.tabBarItem.title = nameArray[i];
        nvc.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
        vc.navigationItem.title = titleArray[i];
        UIImage *sImage = [UIImage imageNamed:sImageArray[i]];
        nvc.tabBarItem.selectedImage = [sImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //更改tabbar上字体的颜色
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:MainColor, NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:10],NSFontAttributeName, nil] forState:UIControlStateSelected];
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:10],NSFontAttributeName, nil] forState:UIControlStateNormal];
        [self addChildViewController:nvc];
    }
}

@end
