//
//  foodReusableView.h
//  Bycproject
//
//  Created by 王俊钢 on 2019/12/14.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "foodinfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface foodReusableView : UICollectionReusableView
@property (nonatomic,strong) foodinfoModel *model;
@end

NS_ASSUME_NONNULL_END
