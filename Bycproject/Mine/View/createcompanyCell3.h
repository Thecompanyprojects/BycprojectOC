//
//  createcompanyCell3.h
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/18.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "companyListModel.h"

NS_ASSUME_NONNULL_BEGIN

//创建一个代理
@protocol myTabVdelegate <NSObject>
-(void)myTabVClick:(UITableViewCell *)cell;
-(void)myTabwithstr:(NSString *)str with:(UITableViewCell *)cell;
@end

@interface createcompanyCell3 : UITableViewCell
@property (nonatomic,strong) UIImageView *leftImg;
@property (nonatomic,strong) UITextField *messageText;
@property (nonatomic,strong) companyListModel *model;
@property(assign,nonatomic)id<myTabVdelegate>delegate;
@end

NS_ASSUME_NONNULL_END
