//
//  mineinfoView.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/16.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "mineinfoView.h"

@interface mineinfoView()

@property (nonatomic,strong) UILabel *contentLab;
@property (nonatomic,strong) UIImageView *rightImg;
@end
 
@implementation mineinfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.iconImg];
        [self addSubview:self.nameLab];
        [self addSubview:self.contentLab];
        [self addSubview:self.rightImg];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(55);
        make.height.mas_offset(55);
        make.centerY.equalTo(weakSelf);
        make.left.equalTo(weakSelf).with.offset(6);
    }];
    [weakSelf.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.iconImg.mas_right).with.offset(17);
        make.top.equalTo(weakSelf.iconImg).with.offset(12);
        make.right.equalTo(weakSelf).with.offset(-12);
        make.height.mas_offset(17);
    }];
    [weakSelf.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.nameLab);
        make.top.equalTo(weakSelf.nameLab.mas_bottom).with.offset(8);
//
        make.height.mas_offset(12);
    }];
    [weakSelf.rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(6);
        make.height.mas_offset(12);
        make.centerY.equalTo(weakSelf.contentLab);
        make.left.equalTo(weakSelf.contentLab.mas_right).with.offset(6);
    }];
}

#pragma mark - getters

-(UIImageView *)iconImg
{
    if(!_iconImg)
    {
        _iconImg = [UIImageView new];
        _iconImg.layer.masksToBounds = YES;
        _iconImg.layer.cornerRadius = 55/2;

    }
    return _iconImg;
}

-(UILabel *)nameLab
{
    if(!_nameLab)
    {
        _nameLab = [UILabel new];
        _nameLab.textColor = [UIColor colorWithHexString:@"000000"];
        _nameLab.font = [UIFont systemFontOfSize:16];
  
    }
    return _nameLab;
}

-(UILabel *)contentLab
{
    if(!_contentLab)
    {
        _contentLab = [UILabel new];
        _contentLab.font = [UIFont systemFontOfSize:12];
        _contentLab.text = @"查看个人主页";
        _contentLab.textColor = [UIColor colorWithHexString:@"999999"];
    }
    return _contentLab;
}

-(UIImageView *)rightImg
{
    if(!_rightImg)
    {
        _rightImg = [UIImageView new];
        _rightImg.image = [UIImage imageNamed:@"icon_you"];
    }
    return _rightImg;
}



@end
