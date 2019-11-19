//
//  CreatecompanyVC.h
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/17.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "BaseViewController.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^SuccessBlock)(void);

@interface CreatecompanyVC : BaseViewController
@property (nonatomic,copy) NSString *companyId;
@property (nonatomic,assign) BOOL isChange;
@property (copy, nonatomic) SuccessBlock successBlock;
@end

NS_ASSUME_NONNULL_END
