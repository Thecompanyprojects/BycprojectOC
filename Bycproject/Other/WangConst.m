//
//  WangConst.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/20.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "WangConst.h"

//获取验证码
NSString * const getSms = @"api/sms/getSms.do";

//上传图片
NSString * const uploadFiles = @"api/file/uploadFiles.do";

//登录注册
NSString * const loginUrl = @"api/byc/user/login.do";

//修改密码
NSString * const resetNewPwdUrl = @"api/agency/resetNewPwd.do";

//查询优秀案例
NSString * const getListUrl = @"api/excellent/getList.do";

//首页查询公司列表
NSString * const companyListUrl =@"api/storeInfrom/v2/companyList.do";

//查询城市查商品
NSString * const getMerchandiesByMapUrl = @"xcx/merchandies/getMerchandiesByMap.do";

//首页查询
NSString * const Homeindex = @"api/byc/index.do";

//城市
NSString * const getCityLists = @"api/china/getCityLists.do";

//查看个人资料
NSString * const getAgencyById = @"api/agency/myInfo.do";

//修改个人资料
NSString * const updateInfoUrl = @"api/agency/updateInfo.do";

//意见反馈
NSString * const upFeedback = @"api/feedback/upFeedback.do";

//创建公司
NSString * const saveHeadquartersUrl = @"api/company/saveHeadquarters.do";


@implementation WangConst

@end
