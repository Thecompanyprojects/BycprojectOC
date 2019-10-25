//
//  createcompanyCell1.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/18.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "createcompanyCell1.h"

@implementation createcompanyCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.contentText];
        [self setuplayout];
    }
    return self;
}


-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(16);
        make.centerY.equalTo(weakSelf);
        make.width.mas_offset(72);
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
