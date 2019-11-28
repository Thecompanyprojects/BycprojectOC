//
//  designchooseView.h
//  Bycproject
//
//  Created by 王俊钢 on 2019/11/24.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol myMenudelegate <NSObject>
-(void)myMenuClick:(NSString *)btnStr;

@end

@interface designchooseView : UIView
@property(assign,nonatomic)id<myMenudelegate>delegate;
@end

NS_ASSUME_NONNULL_END
