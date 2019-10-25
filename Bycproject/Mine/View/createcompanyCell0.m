//
//  createcompanyCell0.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/18.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "createcompanyCell0.h"

@interface createcompanyCell0()
@property (nonatomic,strong) UILabel *titleLab;

@end

@implementation createcompanyCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.logoImg];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(16);
        make.left.equalTo(weakSelf);
        make.centerX.equalTo(weakSelf);
    }];
    [weakSelf.logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(70);
        make.height.mas_offset(70);
        make.top.equalTo(weakSelf.titleLab.mas_bottom).with.offset(6);
        make.centerX.equalTo(weakSelf);
    }];
}

#pragma mark - getters

-(UILabel *)titleLab
{
    if(!_titleLab)
    {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont systemFontOfSize:14];
        _titleLab.textColor = [UIColor colorWithHexString:@"131313"];
        _titleLab.text = @"品牌LOGO";
    }
    return _titleLab;
}

-(UIImageView *)logoImg
{
    if(!_logoImg)
    {
        _logoImg = [[UIImageView alloc] init];
        _logoImg.userInteractionEnabled = YES;
        
    }
    return _logoImg;
}


@end
