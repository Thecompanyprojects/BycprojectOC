//
//  changeCell.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/16.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "changeCell.h"

@interface changeCell()
@property (nonatomic,strong) UIImageView *bgImg;
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *priceLab;
@end

@implementation changeCell

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

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(10);
        make.centerX.equalTo(weakSelf);
        make.left.equalTo(weakSelf).with.offset(12);
        make.height.mas_offset(170);
    }];
    [weakSelf.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bgImg.mas_bottom).with.offset(20);
        make.left.equalTo(weakSelf.bgImg);
        make.right.equalTo(weakSelf.bgImg);
    }];
    [weakSelf.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLab.mas_bottom).with.offset(20);
        make.left.equalTo(weakSelf.bgImg);
        make.right.equalTo(weakSelf.bgImg);
    }];
}

- (void)setModel:(foodModel *)model
{
    [self.bgImg sd_setImageWithURL:[NSURL URLWithString:model.demoLogo] placeholderImage:[UIImage imageNamed:@""]];
    self.titleLab.text = model.title?:@"";
    self.priceLab.text = model.price?:@"";
}


#pragma mark - getters

-(UIImageView *)bgImg
{
    if(!_bgImg)
    {
        _bgImg = [UIImageView new];
        _bgImg.backgroundColor = [UIColor clearColor];
        _bgImg.contentMode = UIViewContentModeScaleAspectFill;
        _bgImg.clipsToBounds = YES;
    }
    return _bgImg;
}

-(UILabel *)titleLab
{
    if(!_titleLab)
    {
        _titleLab = [UILabel new];
        _titleLab.numberOfLines = 2;
        _titleLab.textColor = [UIColor blackColor];
        
        _titleLab.font = [UIFont systemFontOfSize:12];
    }
    return _titleLab;
}

-(UILabel *)priceLab
{
    if(!_priceLab)
    {
        _priceLab = [UILabel new];
      
        _priceLab.font = [UIFont systemFontOfSize:12];
        _priceLab.textColor = [UIColor colorWithHexString:@"757575"];
    }
    return _priceLab;
}




@end
