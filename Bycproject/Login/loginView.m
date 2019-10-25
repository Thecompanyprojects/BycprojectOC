//
//  loginView.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/19.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "loginView.h"

@implementation loginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLab];
        [self addSubview:self.contentText];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(0);
        make.centerY.equalTo(weakSelf);
        make.width.mas_offset(62);
    }];
    [weakSelf.contentText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-14);
        make.centerY.equalTo(weakSelf);
        make.left.equalTo(weakSelf.titleLab.mas_right).with.offset(6);
        make.height.mas_offset(27);
    }];
}

#pragma mark - getters

-(UILabel *)titleLab
{
    if(!_titleLab)
    {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont systemFontOfSize:16];
        _titleLab.textColor = [UIColor blackColor];
    }
    return _titleLab;
}

-(UITextField *)contentText
{
    if(!_contentText)
    {
        _contentText = [[UITextField alloc] init];
        
    }
    return _contentText;
}
@end
