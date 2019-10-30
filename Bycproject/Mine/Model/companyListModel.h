//
//  companyListModel.h
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/27.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface companyListModel : NSObject
@property (nonatomic,copy) NSString *picId;
@property (nonatomic,copy) NSString *picUrl;
@property (nonatomic,copy) NSString *sort;
@property (nonatomic,copy) NSString *companyId;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *picTitle;
@property (nonatomic,copy) NSString *picHref;

@end

NS_ASSUME_NONNULL_END
