//
//  UIColor+HexString.h
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/15.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (HexString)
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
@end

NS_ASSUME_NONNULL_END
