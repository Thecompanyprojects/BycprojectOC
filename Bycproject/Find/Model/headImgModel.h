//
//  headImgModel.h
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/27.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface headImgModel : NSObject
@property (nonatomic , copy) NSString              * picUrl;
@property (nonatomic , copy) NSString              * picHref;
@property (nonatomic , assign) NSInteger              sort;
@property (nonatomic , copy) NSString              * picTitle;
@property (nonatomic , assign) NSInteger              relId;
@property (nonatomic , assign) NSInteger              picId;
@property (nonatomic , assign) NSInteger              type;

@end

NS_ASSUME_NONNULL_END
