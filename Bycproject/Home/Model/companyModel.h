//
//  companyModel.h
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/25.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface companyModel : NSObject
@property (nonatomic , assign) NSInteger              starNum;
@property (nonatomic , copy) NSString              * subTitle;
@property (nonatomic , assign) NSInteger              customId;
@property (nonatomic , copy) NSString              * time;
@property (nonatomic , assign) NSInteger              type;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , assign) NSInteger              demoTotal;
@property (nonatomic , copy) NSString              * companyName;
@property (nonatomic , assign) NSInteger              broseNum;
@property (nonatomic , copy) NSString              * distance;
@property (nonatomic , assign) NSInteger              constructionTotal;
@property (nonatomic , copy) NSString              * companyLogo;
@property (nonatomic , copy) NSString              * demoLogo;
@end

NS_ASSUME_NONNULL_END
