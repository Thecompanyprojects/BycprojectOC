//
//  DetailViewController.h
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/24.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^RefreshBlock)(NSDictionary *dic);
@interface DetailViewController : BaseViewController
@property (copy, nonatomic) RefreshBlock refreshBlock;
@end

NS_ASSUME_NONNULL_END
