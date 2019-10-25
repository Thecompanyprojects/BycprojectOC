//
//  companyCell1.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/18.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "companyCell1.h"

@interface companyCell1()
@property (nonatomic,strong) UIImageView *leftImg;
@property (nonatomic,strong) UILabel *nameLab;
@end
 
@implementation companyCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftImg];
        [self.contentView addSubview:self.nameLab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(17);
        make.top.equalTo(weakSelf).with.offset(20);
        make.width.mas_offset(74);
        make.height.mas_offset(55);
    }];
    [weakSelf.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.leftImg);
        make.left.equalTo(weakSelf.leftImg.mas_right).with.offset(20);
        make.right.equalTo(weakSelf).with.offset(-17);
    }];
}

#pragma mark - getters

-(UIImageView *)leftImg
{
    if(!_leftImg)
    {
        _leftImg = [UIImageView new];
        _leftImg.backgroundColor = [UIColor orangeColor];
        _leftImg.contentMode = UIViewContentModeScaleAspectFill;
        _leftImg.clipsToBounds = YES;
    }
    return _leftImg;
}

-(UILabel *)nameLab
{
    if(!_nameLab)
    {
        _nameLab = [[UILabel alloc] init];
        _nameLab.font = [UIFont systemFontOfSize:21];
        _nameLab.text = @"北京深度空间";
        _nameLab.textColor = [UIColor colorWithHexString:@"333333"];
    }
    return _nameLab;
}



@end

