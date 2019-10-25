//
//  MineManager.h
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/21.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineManager : NSObject
+(NSString *)getCachesSize;

+ (void)removeCache;
@end

NS_ASSUME_NONNULL_END
