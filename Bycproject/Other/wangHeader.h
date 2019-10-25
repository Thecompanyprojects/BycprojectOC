//
//  wangHeader.h
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/15.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#ifndef wangHeader_h
#define wangHeader_h

// Include any system framework and library headers here that should be included in all compilation units.
// You will also need to set the Prefix Header build setting of one or more of your targets to reference this file.
#define WIDTH  [UIScreen mainScreen].bounds.size.width
#define HEIGHT  [UIScreen mainScreen].bounds.size.height

//16进制转rgb颜色的宏定义
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
////软件的版本号设置
//获取设备的系统版本
#define PHONEVERSION [[UIDevice currentDevice] systemVersion]
//判断设备是否是iPhone X
#define ISIPHONEX [UIScreen mainScreen].bounds.size.height == 812 ? 1 : 0

#define isiPhoneX ([UIScreen mainScreen].bounds.size.height == 812.0f || [UIScreen mainScreen].bounds.size.height == 896.0f)

//判断是否是iPhone p
#define ISIPHONEPLUS [UIScreen mainScreen].bounds.size.height == 736 ? 1 : 0
//iPhone X 顶部导航距离
#define IPHONEXTOPH 88
//iPhone X 底部触碰区距离
#define IPHONEXBOTTOMH 34

#define W_SCREEN [UIScreen mainScreen].bounds.size.width/375
//屏幕高度比例
#define H_SCREEN [UIScreen mainScreen].bounds.size.height/640

//导航栏高度
#define getRectNavAndStatusHight  self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height


#define MainColor [UIColor colorWithHexString:@"cf4e39"]

#define _weakself              __weak typeof(self)      weakself = self
#define WEAK_SELF              __weak typeof(self)      weakSelf = self;

// 防止多次调用
#define kPreventRepeatClickTime(_seconds_) \
static BOOL shouldPrevent; \
if (shouldPrevent) return; \
shouldPrevent = YES; \
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((_seconds_) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ \
shouldPrevent = NO; \
}); \


#define BaseURL  @"http://bycapi.bilinerju.com/"

#endif /* wangHeader_h */
