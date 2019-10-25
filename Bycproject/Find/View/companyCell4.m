//
//  companyCell4.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/18.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "companyCell4.h"

@implementation companyCell4

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftImg];
        [self.contentView addSubview:self.titleLab];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    
    weakSelf.leftImg.sd_layout
    .widthIs(16)
    .heightIs(17)
    .topSpaceToView(weakSelf.contentView, 16)
    .leftSpaceToView(weakSelf.contentView, 17);
    
    weakSelf.titleLab.sd_layout
    .leftEqualToView(weakSelf.leftImg).offset(20)
    .topEqualToView(weakSelf.leftImg)
    .heightIs(17)
    .rightSpaceToView(weakSelf.contentView, 17);

    [weakSelf setupAutoHeightWithBottomView:weakSelf.titleLab bottomMargin:16];
}

#pragma mark - getters

-(UIImageView *)leftImg
{
    if(!_leftImg)
    {
        _leftImg = [[UIImageView alloc] init];
        
    }
    return _leftImg;
}

-(UILabel *)titleLab
{
    if(!_titleLab)
    {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont systemFontOfSize:16];
        _titleLab.textColor = [UIColor colorWithHexString:@"333333"];
    }
    return _titleLab;
}



@end
