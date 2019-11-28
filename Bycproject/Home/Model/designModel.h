//
//  designModel.h
//  Bycproject
//
//  Created by 王俊钢 on 2019/11/28.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface designModel : NSObject
@property (nonatomic , copy) NSString              * Newdescription;
@property (nonatomic , assign) NSInteger              type;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * photo;

@end

NS_ASSUME_NONNULL_END
