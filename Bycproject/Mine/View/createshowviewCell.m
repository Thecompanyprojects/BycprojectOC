//
//  createshowviewCell.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/31.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "createshowviewCell.h"

@implementation createshowviewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.titleLab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf);
    }];
}

#pragma mark - getters

-(UILabel *)titleLab
{
    if(!_titleLab)
    {
        _titleLab = [UILabel new];
        _titleLab.textColor = [UIColor darkGrayColor];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont systemFontOfSize:12];
    }
    return _titleLab;
}


@end
