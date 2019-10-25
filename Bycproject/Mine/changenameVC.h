//
//  changenameVC.h
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/24.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^RefreshBlock)(NSString *name);
@interface changenameVC : BaseViewController
@property (nonatomic,copy) NSString *nameStr;
@property (copy, nonatomic) RefreshBlock refreshBlock;
@end

NS_ASSUME_NONNULL_END
