//
//  AddressViewController.h
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/21.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^RefreshBlock)(NSDictionary *modelDic);
@interface AddressViewController : BaseViewController
@property (copy, nonatomic) RefreshBlock refreshBlock;
@end

NS_ASSUME_NONNULL_END
