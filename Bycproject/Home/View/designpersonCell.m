//
//  designpersonCell.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/11/24.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "designpersonCell.h"

@interface designpersonCell()
@property (nonatomic,strong) UIImageView *leftImg;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UILabel *contentLab;
@end

@implementation designpersonCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftImg];
        [self.contentView addSubview:self.nameLab];
        [self.contentView addSubview:self.contentLab];
        [self setuplayout];
        
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(50);
        make.height.mas_offset(50);
        make.left.equalTo(weakSelf).with.offset(15);
        make.centerY.equalTo(weakSelf);
    }];
    [weakSelf.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.leftImg);
        make.left.equalTo(weakSelf.leftImg.mas_right).with.offset(20);
        make.right.equalTo(weakSelf).with.offset(-15);
    }];
    [weakSelf.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLab.mas_bottom).with.offset(18);
        make.left.equalTo(weakSelf.leftImg.mas_right).with.offset(20);
        make.right.equalTo(weakSelf).with.offset(-15);
    }];
}

- (void)setModel:(designModel *)model
{
    [self.leftImg sd_setImageWithURL:[NSURL URLWithString:model.photo]];
    self.nameLab.text = model.name?:@"";
    self.contentLab.text = model.Newdescription?:@"";
}

#pragma mark - getters

-(UIImageView *)leftImg
{
    if(!_leftImg)
    {
        _leftImg = [UIImageView new];
        _leftImg.layer.masksToBounds = YES;
        _leftImg.layer.cornerRadius = 4;
        
    }
    return _leftImg;
}

-(UILabel *)nameLab
{
    if(!_nameLab)
    {
        _nameLab = [UILabel new];
        _nameLab.textColor = [UIColor darkGrayColor];
        _nameLab.font = [UIFont systemFontOfSize:15];
    }
    return _nameLab;
}

-(UILabel *)contentLab
{
    if(!_contentLab)
    {
        _contentLab = [UILabel new];
        _contentLab.font = [UIFont systemFontOfSize:13];
        _contentLab.textColor = [UIColor lightGrayColor];
    }
    return _contentLab;
}




@end
