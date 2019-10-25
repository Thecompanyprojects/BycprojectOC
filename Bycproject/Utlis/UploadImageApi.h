//
//  UploadImageApi.h
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/24.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UploadImageApi : NSObject
+(void)requestimagedata:(UIImage *)image success:(void (^)(NSString *response))success failure:(void (^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
