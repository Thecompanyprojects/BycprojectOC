//
//  effectCell.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/16.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "effectCell.h"

@interface effectCell()
@property (nonatomic,strong) UIImageView *bgImg;
@property (nonatomic,strong) UILabel *messageLab;
@end

@implementation effectCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.bgImg];
        [self.contentView addSubview:self.messageLab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(15);
        make.centerX.equalTo(weakSelf);
        make.left.equalTo(weakSelf).with.offset(11);
        make.height.mas_offset(170);
    }];
    [weakSelf.messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgImg);
        make.right.equalTo(weakSelf.bgImg);
        make.top.equalTo(weakSelf.bgImg.mas_bottom).with.offset(20);
    }];
}

#pragma mark - getters

-(UIImageView *)bgImg
{
    if(!_bgImg)
    {
        _bgImg = [UIImageView new];
        _bgImg.backgroundColor = [UIColor orangeColor];
        _bgImg.contentMode = UIViewContentModeScaleAspectFill;
        _bgImg.clipsToBounds = YES;
        _bgImg.layer.masksToBounds = YES;
        _bgImg.layer.cornerRadius = 5;
    }
    return _bgImg;
}

-(UILabel *)messageLab
{
    if(!_messageLab)
    {
        _messageLab = [UILabel new];
        _messageLab.textColor = [UIColor colorWithHexString:@"000000"];
        _messageLab.numberOfLines = 2;
        _messageLab.text = @"这个地方是介绍这个地方是介绍这个地方是介绍这个地方是介绍";
        _messageLab.font = [UIFont systemFontOfSize:12];
    }
    return _messageLab;
}




@end
