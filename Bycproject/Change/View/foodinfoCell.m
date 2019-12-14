//
//  foodinfoCell.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/12/14.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "foodinfoCell.h"

@interface foodinfoCell()
@property (nonatomic,strong) UIImageView *bgImg;
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *priceLab;
@end

@implementation foodinfoCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.bgImg];
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.priceLab];
        [self setuplayout];
    }
    return self;
}

- (void)setModel:(foodinfoModel *)model
{
    self.titleLab.text = model.name?:@"";
    self.priceLab.text = model.price?:@"";
    [self.bgImg sd_setImageWithURL:[NSURL URLWithString:model.picture] placeholderImage:[UIImage imageNamed:@""]];
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(15);
        make.centerX.equalTo(weakSelf);
        make.left.equalTo(weakSelf).with.offset(12);
        make.height.mas_offset(172);
    }];
    [weakSelf.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgImg);
        make.right.equalTo(weakSelf.bgImg);
        make.top.equalTo(weakSelf.bgImg.mas_bottom).with.offset(15);
    }];
    [weakSelf.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgImg);
        make.right.equalTo(weakSelf.bgImg);
        make.top.equalTo(weakSelf.titleLab.mas_bottom).with.offset(20);
    }];
}

#pragma mark - getters

-(UIImageView *)bgImg
{
    if(!_bgImg)
    {
        _bgImg = [[UIImageView alloc] init];
        _bgImg.contentMode = UIViewContentModeScaleAspectFill;
        _bgImg.clipsToBounds = YES;
        _bgImg.layer.masksToBounds = YES;
        _bgImg.layer.cornerRadius = 5;
    }
    return _bgImg;
}

-(UILabel *)titleLab
{
    if(!_titleLab)
    {
        _titleLab = [[UILabel alloc] init];
        _titleLab.numberOfLines = 2;
        _titleLab.textColor = [UIColor colorWithHexString:@"000000"];
        _titleLab.font = [UIFont systemFontOfSize:12];

    }
    return _titleLab;
}


-(UILabel *)priceLab
{
    if(!_priceLab)
    {
        _priceLab = [[UILabel alloc] init];
        _priceLab.textColor = [UIColor colorWithHexString:@"757575"];
        _priceLab.font = [UIFont systemFontOfSize:10];

    }
    return _priceLab;
}



@end
