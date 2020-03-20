//
//  CaseinfoViewController.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/12/15.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "CaseinfoViewController.h"


@interface CaseinfoViewController ()

@end

@implementation CaseinfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"案例详情";
}



#pragma mark - getters



#pragma mark - 长度计算

-(CGFloat)textHeight:(NSString *)str{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
//Attribute传和label设定的一样
    NSDictionary * attributes = @{
                                  NSFontAttributeName:[UIFont systemFontOfSize:12.f],
                                  NSParagraphStyleAttributeName: paragraphStyle
                                  };
//这里的size，width传label的宽，高默认都传MAXFLOAT
    CGSize textRect = CGSizeMake([UIScreen mainScreen].bounds.size.width - 30, MAXFLOAT);
    CGFloat textHeight = [str boundingRectWithSize: textRect
                                           options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                        attributes:attributes
                                           context:nil].size.height;
    return textHeight;
}

@end
