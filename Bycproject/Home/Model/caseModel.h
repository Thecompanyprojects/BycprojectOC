//
//  caseModel.h
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/20.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface caseModel : NSObject
@property (nonatomic , assign) NSInteger              caseId;
@property (nonatomic , copy) NSString              * caseTitle;
@property (nonatomic , copy) NSString              * caseHref;
@property (nonatomic , assign) NSInteger              userId;
@property (nonatomic , assign) NSInteger              agencyId;
@property (nonatomic , assign) NSInteger              addTime;
@property (nonatomic , copy) NSString              * coverMap;
@property (nonatomic , assign) NSInteger              designsId;
@property (nonatomic , copy) NSString              * type;
@end

NS_ASSUME_NONNULL_END
