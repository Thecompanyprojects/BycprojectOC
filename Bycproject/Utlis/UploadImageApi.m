//
//  UploadImageApi.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/24.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "UploadImageApi.h"
#import <AFNetworking/AFNetworking.h>

@implementation UploadImageApi

+(void)requestimagedata:(UIImage *)image success:(void (^)(NSString *response))success failure:(void (^)(NSError *error))failure;
{
    NSData *data = [NSObject imageData:image];
    NSString *str = [BaseURL stringByAppendingString:uploadFiles];
    // 可以在上传时使用当前的系统事件作为文件名
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置时间格式
    formatter.dateFormat = @"yyyyMMddHHmmss";
    //获取上传图片的时间
    NSString *str1 = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.png", str1];
               
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setRequestSerializer:[AFJSONRequestSerializer  serializer]];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain", nil];

    
    [manager POST:str parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"code"] integerValue] == 1000) {
            for (NSDictionary *dic in responseObject[@"imgList"]) {
                NSString *imgUrl = dic[@"imgUrl"]?:@"";
                if (success) {
                    success(imgUrl);
                }
            }
        }
        else
        {
            success(@"");
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
}


@end
