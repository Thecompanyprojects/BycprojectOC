//
//  companyManager.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/27.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "companyManager.h"

@implementation companyManager

+(NSString *)getTypeWithTitle:(NSString *)index {
    NSArray *titleArr = @[@"装修公司", @"成品定制", @"门窗",
                          @"瓷砖", @"品牌橱柜", @"油漆涂料",
                          @"墙布墙纸", @"暖通管道", @"地板",
                          @"软装馆", @"卫浴洁具", @"电器",
                          @"品牌衣柜", @"房屋中介", @"设计工作室",
                          @"家具沙发", @"石材", @"吊顶",
                          @"隔断背景墙", @"环保材料", @"装饰辅材",
                          @"五金日杂", @"冷暖净水", @"灯具开关",
                          @"监理公司", @"家纺布艺", @"智能家居",
                          @"软包纱窗", @"家政保洁", @"搬家运输",
                          @"瓷砖美缝", @"家居风水", @"绿植花卉",
                          @"艺术玻璃", @"机电工具", @"家居用品",
                          @"竹木材料", @"金属材料", @"消防器材",
                          @"办公家具", @"广告传媒", @"橡胶材料",
                          @"楼梯", @"空气治理", @"整装公司", @"新型装修", @"新型材料", @"新风系统", @"艺术字画", @"名人名画", @"钟表摆件", @"机器人", @"晾衣架"];
    NSArray *typeArr = @[@"1018", @"1035", @"1049",
                         @"1003", @"1004", @"1008",
                         @"1053", @"1037", @"1051",
                         @"1001", @"1002", @"1056",
                         @"1024", @"1020", @"1022",
                         @"1025", @"1050", @"1054",
                         @"1026", @"1041", @"1055",
                         @"1027", @"1042", @"1052",
                         @"1063", @"1062", @"1019",
                         @"1017", @"1013", @"1014",
                         @"1016", @"1044", @"1059",
                         @"1031", @"1045", @"1060",
                         @"1032", @"1046", @"1033",
                         @"1047", @"1034", @"1048",
                         @"1043", @"1015", @"1064", @"1065", @"1068", @"1075", @"1076", @"1077", @"1078", @"1079", @"1082"];
    
    NSString *newIndex = [NSString stringWithFormat:@"%@",index];
    
    NSString *titleStr = [NSString new];
    for (int i = 0; i<typeArr.count; i++) {
        NSString *type = [typeArr objectAtIndex:i];
        if ([newIndex isEqualToString:type]) {
            titleStr = [titleArr objectAtIndex:i];
            return titleStr;
        }
    }
    
    return @"";
}
@end