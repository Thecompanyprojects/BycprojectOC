//
//  createshowView.h
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/31.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^sureBlock)(NSDictionary *dic);

@interface createshowView : UIView
@property(nonatomic,copy)sureBlock sureClick;

-(void)withSureClick:(sureBlock)block;
@end

NS_ASSUME_NONNULL_END
