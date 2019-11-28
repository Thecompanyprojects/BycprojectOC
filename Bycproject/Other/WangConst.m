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

//店铺详情
NSString * const getNoVipYellowPage = @"api/company/getNoVipYellowPage.do";

//首页店铺详情
NSString * const homegetNoVipYellowPage = @"api/byc/company/getNoVipYellowPage.do";

//修改公司
NSString * const saveAreaUrl = @"api/area/saveArea.do";

//查询我的公司列表
NSString * const findCompanyListUrl = @"api/company/findCompanyList.do";

//查询所有商家类别
NSString * const tplistUrl = @"api/byc/company/tplist.do";

//找设计
NSString * const designerUrl = @"api/byc/designer/list.do";

//banner
NSString * const banner0url = @"http://bycimg.bilinerju.com/img/2019-11-26/f8f1754dd31f47ceb78a82a35db3a585.jpg";
NSString * const banner1url = @"http://bycimg.bilinerju.com/img/2019-11-26/f2ba13265fd24615bc4b1aa5b0748cb4.jpg";
NSString * const banner2url = @"http://bycimg.bilinerju.com/img/2019-11-26/38d13f47b26b4e5d880c6b2f0843c380.jpg";
NSString * const banner3url = @"http://bycimg.bilinerju.com/img/2019-11-26/55264b9ccb584bbdaa1af04f89b73b2f.jpg";

@implementation WangConst

@end
