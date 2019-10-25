//
//  companyCell.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/16.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "companyCell.h"

@interface companyCell()
@property (nonatomic,strong) UIImageView *bgImg;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UILabel *contentLab;
@property (nonatomic,strong) UILabel *addressLab;
@end

@implementation companyCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.bgImg];
        [self.contentView addSubview:self.nameLab];
        [self.contentView addSubview:self.contentLab];
        [self.contentView addSubview:self.addressLab];
        [self setuplayout];
    }
    return self;
}

- (void)setModel:(companyModel *)model
{
    [self.bgImg sd_setImageWithURL:[NSURL URLWithString:model.companyLogo] placeholderImage:[UIImage imageNamed:@""]];
    self.nameLab.text = model.companyName?:@"";
    self.contentLab.text = [NSString stringWithFormat:@"%@%ld%@%ld",@"案例: ",model.demoTotal,@"工地: ",model.constructionTotal];
    self.addressLab.text = model.distance;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(11);
        make.width.mas_offset(91);
        make.height.mas_offset(91);
        make.centerY.equalTo(weakSelf);
    }];
    [weakSelf.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.bgImg.mas_right).with.offset(12);
        make.top.equalTo(weakSelf.bgImg).with.offset(5);
        make.height.mas_offset(16);
        make.right.equalTo(weakSelf).with.offset(-11);
    }];
    [weakSelf.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.left.equalTo(weakSelf.nameLab);
        make.height.mas_offset(14);
    }];
    [weakSelf.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.right.equalTo(weakSelf.contentView).with.offset(-11);
        make.height.mas_offset(14);
    }];
}

#pragma mark - getters

-(UIImageView *)bgImg
{
    if(!_bgImg)
    {
        _bgImg = [[UIImageView alloc] init];
        _bgImg.contentMode = UIViewContentModeScaleAspectFill;
        _bgImg.clipsToBounds = YES;
        _bgImg.layer.masksToBounds = YES;
        _bgImg.layer.cornerRadius = 5;
    }
    return _bgImg;
}

-(UILabel *)nameLab
{
    if(!_nameLab)
    {
        _nameLab = [[UILabel alloc] init];
        _nameLab.textColor = [UIColor colorWithHexString:@"#262626"];
        _nameLab.font = [UIFont systemFontOfSize:15];
    }
    return _nameLab;
}

-(UILabel *)contentLab
{
    if(!_contentLab)
    {
        _contentLab = [[UILabel alloc] init];
        _contentLab.textColor = [UIColor colorWithHexString:@"#666666"];
        _contentLab.font = [UIFont systemFontOfSize:11];
        
    }
    return _contentLab;
}


-(UILabel *)addressLab
{
    if(!_addressLab)
    {
        _addressLab = [[UILabel alloc] init];
        _addressLab.textAlignment = NSTextAlignmentRight;
        _addressLab.font = [UIFont systemFontOfSize:11];
        _addressLab.textColor = [UIColor colorWithHexString:@"#666666"];
    }
    return _addressLab;
}




@end
