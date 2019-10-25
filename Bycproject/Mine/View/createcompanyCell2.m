//
//  createcompanyCell2.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/18.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "createcompanyCell2.h"

@interface createcompanyCell2()

@end

@implementation createcompanyCell2

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.messageText];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.left.equalTo(weakSelf).with.offset(16);
        make.top.equalTo(weakSelf).with.offset(16);
        make.width.mas_offset(72);
    }];
    [weakSelf.messageText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(16);
        make.top.equalTo(weakSelf.titleLab.mas_bottom).with.offset(18);
        make.bottom.equalTo(weakSelf).with.offset(-16);
        make.right.equalTo(weakSelf).with.offset(-16);
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

-(UITextView *)messageText
{
    if(!_messageText)
    {
        _messageText = [[UITextView alloc] init];
        _messageText.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
    }
    return _messageText;
}




@end
