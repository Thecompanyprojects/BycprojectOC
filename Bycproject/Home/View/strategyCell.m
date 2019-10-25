//
//  strategyCell.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/16.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "strategyCell.h"

@interface strategyCell()
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *contentLab;
@property (nonatomic,strong) UIImageView *rightImg;
@property (nonatomic,strong) UILabel *timeLab;
@property (nonatomic,strong) DKSButton *starBtn;
@end

@implementation strategyCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.contentLab];
        [self.contentView addSubview:self.rightImg];
        [self.contentView addSubview:self.timeLab];
        [self.contentView addSubview:self.starBtn];
        [self setuplayout];
    }
    return self;
}

- (void)setModel:(strategyModel *)model
{
    [self.rightImg sd_setImageWithURL:[NSURL URLWithString:model.demoLogo] placeholderImage:[UIImage imageNamed:@""]];
    self.titleLab.text = model.title?:@"";
    self.contentLab.text = model.subTitle?:@"";
    self.timeLab.text = model.time?:@"";
    [self.starBtn setTitle:[NSString stringWithFormat:@"%ld",model.starNum] forState:normal];
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.width.mas_offset(104);
        make.height.mas_offset(69);
        make.right.equalTo(weakSelf).with.offset(-11);
    }];
    [weakSelf.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(11);
        make.top.equalTo(weakSelf).with.offset(10);
        make.right.equalTo(weakSelf.rightImg.mas_left).with.offset(-11);
        make.height.mas_offset(15);
    }];
    [weakSelf.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.titleLab);
        make.right.equalTo(weakSelf.titleLab);
        make.top.equalTo(weakSelf.titleLab.mas_bottom).with.offset(10);
    }];
    [weakSelf.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.titleLab);
        make.top.equalTo(weakSelf.contentLab.mas_bottom).with.offset(10);
        
    }];
    
    [weakSelf.starBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.timeLab);
        make.right.equalTo(weakSelf.contentLab);
        make.width.mas_offset(40);
        make.height.mas_offset(12);
    }];
}

#pragma mark - getters

-(UILabel *)titleLab
{
    if(!_titleLab)
    {
        _titleLab = [UILabel new];
        _titleLab.textColor = [UIColor colorWithHexString:@"444444"];
        _titleLab.font = [UIFont systemFontOfSize:13];
     
    }
    return _titleLab;
}

-(UILabel *)contentLab
{
    if(!_contentLab)
    {
        _contentLab = [UILabel new];
        _contentLab.font = [UIFont systemFontOfSize:10];
        _contentLab.textColor = [UIColor colorWithHexString:@"777777"];
        _contentLab.numberOfLines = 2;
    }
    return _contentLab;
}

-(UIImageView *)rightImg
{
    if(!_rightImg)
    {
        _rightImg = [UIImageView new];
        _rightImg.layer.masksToBounds = YES;
        _rightImg.layer.cornerRadius = 5;
        _rightImg.contentMode = UIViewContentModeScaleAspectFill;
        _rightImg.clipsToBounds = YES;
    }
    return _rightImg;
}

-(UILabel *)timeLab
{
    if(!_timeLab)
    {
        _timeLab = [[UILabel alloc] init];
        _timeLab.font = [UIFont systemFontOfSize:10];
        _timeLab.textColor = [UIColor colorWithHexString:@"777777"];
    }
    return _timeLab;
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

@end
