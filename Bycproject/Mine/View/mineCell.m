//
//  mineCell.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/16.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "mineCell.h"

@interface mineCell()

@end

@implementation mineCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.img];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
   
    [weakSelf.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf).with.offset(-5);
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
    }];
    
    [weakSelf.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.width.mas_offset(24);
        make.height.mas_offset(24);
        make.bottom.equalTo(weakSelf.titleLab.mas_top).with.offset(-10);
    }];
}

-(UILabel *)titleLab
{
    if(!_titleLab)
    {
        _titleLab = [UILabel new];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.textColor = [UIColor colorWithHexString:@"666666"];
        _titleLab.font = [UIFont systemFontOfSize:10];
    }
    return _titleLab;
}

-(UIImageView *)img
{
    if(!_img)
    {
        _img = [UIImageView new];
//        _img.contentMode = UIViewContentModeScaleAspectFill;
//        _img.clipsToBounds = YES;
    }
    return _img;
}

@end
