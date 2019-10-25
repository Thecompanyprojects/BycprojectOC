//
//  NSObject+CompressImage.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/24.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "NSObject+CompressImage.h"

@implementation NSObject (CompressImage)
+ (NSData *)imageData:(UIImage *)myimage{
    NSData *data=UIImageJPEGRepresentation(myimage, 1.0);

//    if (data.length>100*1024) {
//        if (data.length>1024*1024) {//1M以及以上
//            data=UIImageJPEGRepresentation(myimage, 0.1);
//        }else if (data.length>1024*1024*0.7) {//0.7M-1M
//            data=UIImageJPEGRepresentation(myimage, 0.5);
//        }else if (data.length>512*1024) {//0.5M-0.7M
//            data=UIImageJPEGRepresentation(myimage, 0.7);
//        }else if (data.length>200*1024) {//0.25M-0.5M
//            data=UIImageJPEGRepresentation(myimage, 0.9);
//        }
//    }


    CGFloat size = 200.0f;
    CGFloat scale = size/(data.length/1024);
    data=UIImageJPEGRepresentation(myimage, scale);

    NSData *oneData = data;
    if (data.length / 1024.0 >=  500) {
        data = [self fitSamallImage:data];
    }

    return data < oneData ? data : oneData;
    

}


+ (NSData *)fitSamallImage:(NSData *)data {
    UIImage *image= [UIImage imageWithData:data];
    if (nil == image) {
        return nil;
    }
    if (image.size.width < 414) {
        
        return UIImageJPEGRepresentation(image, 1.0);
    }
    NSLog(@"图片宽image.size.width = %f", image.size.width);
    CGSize size = CGSizeMake(414, 414 *image.size.height/image.size.width);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return UIImageJPEGRepresentation(scaledImage, 1.0);
}


+ (UIImage *)imageCompressFromImage:(UIImage *)myImage {
    NSData *data=UIImageJPEGRepresentation(myImage, 1.0);
    NSLog(@"imageData = %f", data.length/1024.0);
//    if (data.length>100*1024) {
//        if (data.length>1024*1024) {//1M以及以上
//            data=UIImageJPEGRepresentation(myImage, 0.1);
//        }else if (data.length>1024*1024*0.7) {//0.7M-1M
//            data=UIImageJPEGRepresentation(myImage, 0.5);
//        }else if (data.length>512*1024) {//0.5M-0.7M
//            data=UIImageJPEGRepresentation(myImage, 0.7);
//        }else if (data.length>200*1024) {//0.25M-0.5M
//            data=UIImageJPEGRepresentation(myImage, 0.9);
//        }
//    }
    
    CGFloat size = 200.0f;
    CGFloat scale = size/(data.length/1024);
    data=UIImageJPEGRepresentation(myImage, scale);

    NSData *oneData = data;
    if (data.length / 1024.0 >=  500) {
        data = [self fitSamallImage:data];
    }

    data = data < oneData ? data : oneData;
    if (data == nil) {
        return myImage;
    }
    return [UIImage imageWithData:data];
}


+ (void)promptWithControllerName:(NSString *)controllerName {
    


}




+ (NSData *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return UIImageJPEGRepresentation(newImage, 0.8);
}

+ (UIImage*)getSubImage:(UIImage*)image mCGRect:(CGRect)mCGRect centerBool:(BOOL)centerBool{
    /*如若centerBool为Yes则是由中心点取mCGRect范围的图片*/
    
    float imgWidth = image.size.width;
    float imgHeight = image.size.height;
    float viewWidth = mCGRect.size.width;
    float viewHidth = mCGRect.size.height;
    CGRect rect;
    if(centerBool)
        rect = CGRectMake((imgWidth-viewWidth)/2, (imgHeight-viewHidth)/2, viewWidth, viewHidth);
    else{
        if (viewHidth < viewWidth) {
            if (imgWidth <= imgHeight) {
                rect = CGRectMake(0, 0, imgWidth, imgWidth*imgHeight/viewWidth);
            }else {
                float width = viewWidth*imgHeight/imgHeight;
                float x = (imgWidth - width)/2;
                if (x > 0) {
                    rect = CGRectMake(x, 0, width, imgHeight);
                }else {
                    rect = CGRectMake(0, 0, imgWidth, imgWidth*imgHeight/viewWidth);
                }
            }
        }else
        {
            if (imgWidth <= imgHeight)
            {
                float height = imgHeight*imgWidth/viewWidth;
                if (height < imgHeight) {
                    rect = CGRectMake(0, 0, imgWidth, height);
                } else {
                    rect = CGRectMake(0, 0,  viewWidth*imgHeight/imgHeight, imgHeight);
                }
            }else
            {
                float width = viewWidth*imgHeight/imgHeight;
                if (width  < imgWidth) {
                    float x = (imgWidth - width)/2 ;
                    rect = CGRectMake(x, 0, width, imgHeight);
                } else {
                    rect = CGRectMake(0, 0, imgWidth, imgHeight);
                }
            }
        }
    }
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    //CFRelease(subImageRef);
    
    return smallImage;
}




+ (void)companyShareStatisticsWithConpanyId:(NSString *)companyId {
    NSString *defaultApi = [BaseURL stringByAppendingString:@"company/addShareNumbers.do"];
    NSDictionary *paramDic = @{
                               @"companyId" : companyId
                               };
    [NetManager afPostRequest:defaultApi parms:paramDic finished:^(id responseObj) {
        
    } failed:^(NSString *errorMsg) {
        
    }];
}

+ (void)contructionShareStatisticsWithConstructionId:(NSString *)constructionId {
    NSString *defaultApi = [BaseURL stringByAppendingString:@"construction/addShareNumbers.do"];
    
    NSDictionary *paramDic = @{
                               @"constructionId" : constructionId
                               };
    [NetManager afPostRequest:defaultApi parms:paramDic finished:^(id responseObj) {
        
    } failed:^(NSString *errorMsg) {
    }];
}

+ (void)goodsShareStatisticsWithMerchandiesId:(NSString *)merchandiesId {
    NSString *defaultApi = [BaseURL stringByAppendingString:@"merchandies/addShareNumbers.do"];
    NSDictionary *paramDic = @{
                               @"merchandiesId" : merchandiesId
                               };
    [NetManager afPostRequest:defaultApi parms:paramDic finished:^(id responseObj) {
        
    } failed:^(NSString *errorMsg) {
    }];
}

+ (void)needDecorationStatisticsWithConpanyId:(NSString *)companyId {

}


+ (void)uploadImgWith:(NSArray *)imgArray completion:(void(^)(NSArray * imageURLArray))completion{
    //    NSLog(@"名字:%@ 和身份证号:%@", name, idNum);
    // －－－－－－－－－－－－－－－－－－－－－－－－－－－－上传图片－－－－
    /*
     此段代码如果需要修改，可以调整的位置
     1. 把upload.php改成网站开发人员告知的地址
     2. 把name改成网站开发人员告知的字段名
     */
    // 查询条件
    //    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:name, @"name", idNum, @"idNumber", nil];
    
    // 基于AFN3.0+ 封装的HTPPSession句柄
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    NSString *defaultApi = [BaseURL stringByAppendingString:@"file/uploadFiles.do"];
    
    // 在parameters里存放照片以外的对象
    [manager POST:defaultApi parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
        // 这里的_photoArr是你存放图片的数组
        for (int i = 0; i < imgArray.count; i++) {
            
            UIImage *image = imgArray[i];
            //            NSData *imageData = UIImageJPEGRepresentation(image, PHOTO_COMPRESS);
            NSData *imageData = [NSObject imageData:image];
            
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
            /*
             *该方法的参数
             1. appendPartWithFileData：要上传的照片[二进制流]
             2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
             3. fileName：要保存在服务器上的文件名
             4. mimeType：上传的文件的类型
             */
            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"]; //
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
      
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
      
        NSArray *arr = [responseObject objectForKey:@"imgList"];
        NSMutableArray *multArray = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            NSString *imgUrl = [dict objectForKey:@"imgUrl"];
            [multArray addObject:imgUrl];
        }
        completion([multArray copy]);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        
    }];
}


+ (int)compareDate:(NSString*)date01 littlewithDate:(NSString*)date02{
    int ci;
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *dt1 = [[NSDate alloc]init];
    NSDate *dt2 = [[NSDate alloc]init];
    dt1 = [df dateFromString:date01];
    dt2 = [df dateFromString:date02];
    NSComparisonResult result = [dt1 compare:dt2];
    switch (result)
    {
            //date02比date01大
        case(NSOrderedAscending): ci=1;break;
            //date02比date01小
        case(NSOrderedDescending): ci=-1;break;
            //date02=date01
        case NSOrderedSame: ci=0;break;
        default:
            
            break;
    }
    return ci;
}

+ (NSString*)timeStringFromTimeIntervalString:(NSTimeInterval)timerInterval WithFromatter:(NSString *)format {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSDate *datenow = [NSDate dateWithTimeIntervalSince1970:timerInterval];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
    
}

@end
