//
//  caseCell.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/16.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "caseCell.h"

@interface caseCell()
@property (nonatomic,strong) UIImageView *bgImg;
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *contentLab;
@property (nonatomic,strong) DKSButton *starBtn;
@property (nonatomic,strong) DKSButton *broseBtn;
@end

@implementation caseCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.bgImg];
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.contentLab];
        [self.contentView addSubview:self.starBtn];
        [self.contentView addSubview:self.broseBtn];
        [self setuplayout];
    }
    return self;
}

- (void)setModel:(caseModel *)model
{

    [self.bgImg sd_setImageWithURL:[NSURL URLWithString:model.demoLogo] placeholderImage:[UIImage imageNamed:@""]];
    self.titleLab.text = model.title?:@"";
    self.contentLab.text = model.subTitle?:@"";
    [self.starBtn setTitle:model.starNum?:@"0" forState:normal];
    [self.broseBtn setTitle:model.broseNum?:@"0" forState:normal];
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.left.equalTo(weakSelf).with.offset(11);
        make.top.equalTo(weakSelf).with.offset(20);
        make.height.mas_offset(156);
    }];
    [weakSelf.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bgImg.mas_bottom).with.offset(13);
        make.left.equalTo(weakSelf.bgImg);
        make.right.equalTo(weakSelf.bgImg);
    }];
    [weakSelf.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLab.mas_bottom).with.offset(6);
        make.left.equalTo(weakSelf.bgImg);
        make.height.mas_offset(13);
    }];
    [weakSelf.starBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentLab);
        make.right.equalTo(weakSelf.bgImg);
        make.height.mas_offset(12);
        make.width.mas_offset(40);
    }];
    [weakSelf.broseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentLab);
        make.right.equalTo(weakSelf.starBtn.mas_left).with.offset(-16);
        make.height.mas_offset(12);
        make.width.mas_offset(40);
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

-(UILabel *)titleLab
{
    if(!_titleLab)
    {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = [UIColor colorWithHexString:@"#363636"];
        _titleLab.font = [UIFont systemFontOfSize:13];
    }
    return _titleLab;
}

-(UILabel *)contentLab
{
    if(!_contentLab)
    {
        _contentLab = [[UILabel alloc] init];
        _contentLab.textColor = [UIColor colorWithHexString:@"#666666"];
        _contentLab.font = [UIFont systemFontOfSize:10];
    }
    return _contentLab;
}

-(DKSButton *)starBtn
{
    if(!_starBtn)
    {
        _starBtn = [[DKSButton alloc] init];
        [_starBtn setImage:[UIImage imageNamed:@"icon_xx"] forState:normal];
        _starBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [_starBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:normal];
        _starBtn.buttonStyle = DKSButtonImageLeft;
        _starBtn.padding = 12;
    }
    return _starBtn;
}

-(DKSButton *)broseBtn
{
    if(!_broseBtn)
    {
        _broseBtn = [[DKSButton alloc] init];
        [_broseBtn setImage:[UIImage imageNamed:@"icon_yanj"] forState:normal];
        _broseBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [_broseBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:normal];
        _broseBtn.buttonStyle = DKSButtonImageLeft;
        _broseBtn.padding = 12;
    }
    return _broseBtn;
}



@end
