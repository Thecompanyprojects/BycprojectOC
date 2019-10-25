//
//  headmenuView.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/16.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "headmenuView.h"

@implementation headmenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.img];
        [self addSubview:self.nameLab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf).with.offset(16);
        make.width.mas_offset(49);
        make.height.mas_offset(49);
    }];
    [weakSelf.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.img.mas_bottom).with.offset(7);
        make.left.equalTo(weakSelf);
        make.centerX.equalTo(weakSelf);
    }];
}

#pragma mark - getters

-(UIImageView *)img
{
    if(!_img)
    {
        _img = [UIImageView new];
        
    }
    return _img;
}

-(UILabel *)nameLab
{
    if(!_nameLab)
    {
        _nameLab = [UILabel new];
        _nameLab.textAlignment = NSTextAlignmentCenter;
        _nameLab.font = [UIFont systemFontOfSize:13];
        _nameLab.textColor = [UIColor blackColor];
        
    }
    return _nameLab;
}



@end
