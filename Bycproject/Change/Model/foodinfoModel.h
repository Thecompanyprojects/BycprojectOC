//
//  foodinfoModel.h
//  Bycproject
//
//  Created by 王俊钢 on 2019/12/14.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface foodinfoModel : NSObject
@property (nonatomic , assign) NSInteger              modify;
@property (nonatomic , assign) NSInteger              Newid;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , copy) NSString              * picture;
@property (nonatomic , assign) NSInteger              type;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , assign) NSInteger              addTm;
@end

NS_ASSUME_NONNULL_END
