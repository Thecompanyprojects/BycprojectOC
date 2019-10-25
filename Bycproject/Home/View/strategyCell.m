//
//  strategyCell.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/16.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "strategyCell.h"

@interface strategyCell()
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *contentLab;
@property (nonatomic,strong) UIImageView *rightImg;
@property (nonatomic,strong) UILabel *timeLab;
@end

@implementation strategyCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.contentLab];
        [self.contentView addSubview:self.rightImg];
        [self.contentView addSubview:self.timeLab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.width.mas_offset(104);
        make.height.mas_offset(69);
        make.right.equalTo(weakSelf).with.offset(-11);
    }];
    [weakSelf.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(11);
        make.top.equalTo(weakSelf).with.offset(10);
        make.right.equalTo(weakSelf.rightImg.mas_left).with.offset(-11);
        make.height.mas_offset(15);
    }];
    [weakSelf.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.titleLab);
        make.right.equalTo(weakSelf.titleLab);
        make.top.equalTo(weakSelf.titleLab.mas_bottom).with.offset(10);
    }];
    [weakSelf.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.titleLab);
        make.top.equalTo(weakSelf.contentLab.mas_bottom).with.offset(10);
        
    }];
}

#pragma mark - getters

-(UILabel *)titleLab
{
    if(!_titleLab)
    {
        _titleLab = [UILabel new];
        _titleLab.textColor = [UIColor colorWithHexString:@"444444"];
        _titleLab.font = [UIFont systemFontOfSize:13];
        _titleLab.text = @"管道保温材料有哪些？";
    }
    return _titleLab;
}

-(UILabel *)contentLab
{
    if(!_contentLab)
    {
        _contentLab = [UILabel new];
        _contentLab.font = [UIFont systemFontOfSize:10];
        _contentLab.textColor = [UIColor colorWithHexString:@"777777"];
        _contentLab.text = @"在我们生活中，大家一定接触到保温材料吧，今天小编就给大家详细讲解一下生活中的保温材料有就看得见我我偶就考虑到数据库发哦ID是否";
        _contentLab.numberOfLines = 2;
    }
    return _contentLab;
}

-(UIImageView *)rightImg
{
    if(!_rightImg)
    {
        _rightImg = [UIImageView new];
        _rightImg.backgroundColor = [UIColor orangeColor];
        _rightImg.layer.masksToBounds = YES;
        _rightImg.layer.cornerRadius = 5;
        _rightImg.contentMode = UIViewContentModeScaleAspectFill;
        _rightImg.clipsToBounds = YES;
    }
    return _rightImg;
}

-(UILabel *)timeLab
{
    if(!_timeLab)
    {
        _timeLab = [[UILabel alloc] init];
        _timeLab.font = [UIFont systemFontOfSize:10];
        _timeLab.textColor = [UIColor colorWithHexString:@"777777"];
    }
    return _timeLab;
}



@end
