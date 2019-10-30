//
//  createcompanyCell3.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/18.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "createcompanyCell3.h"

@interface createcompanyCell3()<UITextFieldDelegate>

@end

@implementation createcompanyCell3

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftImg];
        [self.contentView addSubview:self.messageText];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(16);
        make.centerY.equalTo(weakSelf);
        make.width.mas_offset(80);
        make.height.mas_offset(80);
    }];
    [weakSelf.messageText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(22);
        make.bottom.equalTo(weakSelf.leftImg);
        make.right.equalTo(weakSelf).with.offset(-16);
        make.left.equalTo(weakSelf.leftImg.mas_right).with.offset(12);
    }];
}

#pragma mark - getters

-(UIImageView *)leftImg
{
    if(!_leftImg)
    {
        _leftImg = [[UIImageView alloc] init];
//        _leftImg.image = [UIImage imageNamed:@"jiajia1"];
        _leftImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage)];
        [_leftImg addGestureRecognizer:tapGesture];
    }
    return _leftImg;
}

-(UITextField *)messageText
{
    if(!_messageText)
    {
        _messageText = [[UITextField alloc] init];
        _messageText.delegate = self;
    }
    return _messageText;
}

-(void)clickImage
{
    [self.delegate myTabVClick:self];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.delegate myTabwithstr:textField.text?:@"" with:self];
}

- (void)setModel:(companyListModel *)model
{
    [self.leftImg sd_setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:[UIImage imageNamed:@"jiajia1"]];
    self.messageText.text = model.picHref?:@"";
}

@end
