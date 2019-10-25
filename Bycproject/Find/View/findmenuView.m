//
//  findmenuView.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/18.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "findmenuView.h"

@interface findmenuView()
@property (nonatomic,strong) UILabel *title0;
@property (nonatomic,strong) UILabel *title1;
@property (nonatomic,strong) UILabel *title2;
@property (nonatomic,strong) UILabel *title3;
@property (nonatomic,strong) UILabel *title4;
@property (nonatomic,strong) UIImageView *img0;
@property (nonatomic,strong) UIImageView *img1;
@property (nonatomic,strong) UIImageView *img2;
@property (nonatomic,strong) UIImageView *img3;
@property (nonatomic,strong) UIImageView *img4;
@end

@implementation findmenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.view0];
        [self addSubview:self.view1];
        [self addSubview:self.view2];
        [self addSubview:self.view3];
        [self addSubview:self.view4];
        
        [self.view0 addSubview:self.title0];
        [self.view0 addSubview:self.img0];
        [self.view1 addSubview:self.title1];
        [self.view1 addSubview:self.img1];
        [self.view2 addSubview:self.title2];
        [self.view2 addSubview:self.img2];
        [self.view3 addSubview:self.title3];
        [self.view3 addSubview:self.img3];
        [self.view4 addSubview:self.title4];
        [self.view4 addSubview:self.img4];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf).with.offset(0);
        make.width.mas_offset(WIDTH/5);
        make.height.mas_offset(60);
    }];
    [weakSelf.view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view2);
        make.right.equalTo(weakSelf.view2.mas_left);
        make.width.mas_offset(WIDTH/5);
        make.height.mas_offset(60);
    }];
    [weakSelf.view0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view2);
        make.right.equalTo(weakSelf.view1.mas_left);
        make.width.mas_offset(WIDTH/5);
        make.height.mas_offset(60);
    }];
    [weakSelf.view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view2);
        make.left.equalTo(weakSelf.view2.mas_right);
        make.width.mas_offset(WIDTH/5);
        make.height.mas_offset(60);
    }];
    [weakSelf.view4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view2);
        make.left.equalTo(weakSelf.view3.mas_right);
        make.width.mas_offset(WIDTH/5);
        make.height.mas_offset(60);
    }];
    
    [weakSelf.img0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view0);
        make.width.mas_offset(23);
        make.height.mas_offset(25);
        make.top.equalTo(weakSelf.view0).offset(20);
    }];
    [weakSelf.title0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view0);
        make.top.equalTo(weakSelf.img0.mas_bottom).with.offset(13);
        make.height.mas_offset(13);
        make.left.equalTo(weakSelf.view0);
    }];
    
    [weakSelf.img1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(27);
        make.height.mas_offset(27);
        make.centerX.equalTo(weakSelf.view1);
        make.bottom.equalTo(weakSelf.img0);
    }];
    
    [weakSelf.title1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.img1.mas_bottom).with.offset(13);
        make.left.equalTo(weakSelf.view1);
        make.centerX.equalTo(weakSelf.view1);
        make.height.mas_offset(13);
    }];
    
    [weakSelf.img2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(27);
        make.height.mas_offset(24);
        make.centerX.equalTo(weakSelf.view2);
        make.bottom.equalTo(weakSelf.img0);
    }];
    [weakSelf.title2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.img2.mas_bottom).with.offset(13);
        make.left.equalTo(weakSelf.view2);
        make.centerX.equalTo(weakSelf.view2);
        make.height.mas_offset(13);
    }];
    
    [weakSelf.img3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(24);
        make.height.mas_offset(25);
        make.centerX.equalTo(weakSelf.view3);
        make.bottom.equalTo(weakSelf.img0);
    }];
    
    [weakSelf.title3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.img3.mas_bottom).with.offset(13);
        make.left.equalTo(weakSelf.view3);
        make.centerX.equalTo(weakSelf.view3);
        make.height.mas_offset(13);
    }];
    
    [weakSelf.img4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(23);
        make.height.mas_offset(23);
        make.centerX.equalTo(weakSelf.view4);
        make.bottom.equalTo(weakSelf.img0);
    }];
    [weakSelf.title4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.img4.mas_bottom).with.offset(13);
        make.left.equalTo(weakSelf.view4);
        make.centerX.equalTo(weakSelf.view4);
        make.height.mas_offset(13);
    }];
    
}


#pragma makr - getters

-(UIView *)view0
{
    if(!_view0)
    {
        _view0 = [[UIView alloc] init];
       
    }
    return _view0;
}

-(UIView *)view1
{
    if(!_view1)
    {
        _view1 = [[UIView alloc] init];
        
    }
    return _view1;
}

-(UIView *)view2
{
    if(!_view2)
    {
        _view2 = [[UIView alloc] init];
        
    }
    return _view2;
}

-(UIView *)view3
{
    if(!_view3)
    {
        _view3 = [[UIView alloc] init];
        
    }
    return _view3;
}

-(UIView *)view4
{
    if(!_view4)
    {
        _view4 = [[UIView alloc] init];
        
    }
    return _view4;
}


-(UIImageView *)img0
{
    if(!_img0)
    {
        _img0 = [[UIImageView alloc] init];
        _img0.image = [UIImage imageNamed:@"zhuangxiu(1)"];
    }
    return _img0;
}

-(UIImageView *)img1
{
    if(!_img1)
    {
        _img1 = [[UIImageView alloc] init];
        _img1.image = [UIImage imageNamed:@"jianzhucailiao"];
    }
    return _img1;
}

-(UIImageView *)img2
{
    if(!_img2)
    {
        _img2 = [[UIImageView alloc] init];
        _img2.image = [UIImage imageNamed:@"chenggonganli"];
    }
    return _img2;
}

-(UIImageView *)img3
{
    if(!_img3)
    {
        _img3 = [[UIImageView alloc] init];
        _img3.image = [UIImage imageNamed:@"jichugaizao"];

    }
    return _img3;
}

-(UIImageView *)img4
{
    if(!_img4)
    {
        _img4 = [[UIImageView alloc] init];
        _img4.image = [UIImage imageNamed:@"gongsi_"];
    }
    return _img4;
}

-(UILabel *)title0
{
    if(!_title0)
    {
        _title0 = [[UILabel alloc] init];
        _title0.textAlignment = NSTextAlignmentCenter;
        _title0.font = [UIFont systemFontOfSize:13];
        _title0.textColor = [UIColor colorWithHexString:@"333333"];
        _title0.text = @"硬装软装";
    }
    return _title0;
}


-(UILabel *)title1
{
    if(!_title1)
    {
        _title1 = [[UILabel alloc] init];
        _title1.textAlignment = NSTextAlignmentCenter;
        _title1.font = [UIFont systemFontOfSize:13];
        _title1.textColor = [UIColor colorWithHexString:@"333333"];
        _title1.text = @"主材辅材";
    }
    return _title1;
}

-(UILabel *)title2
{
    if(!_title2)
    {
        _title2 = [[UILabel alloc] init];
        _title2.textAlignment = NSTextAlignmentCenter;
        _title2.font = [UIFont systemFontOfSize:13];
        _title2.textColor = [UIColor colorWithHexString:@"333333"];
        _title2.text = @"全屋定制";
    }
    return _title2;
}

-(UILabel *)title3
{
    if(!_title3)
    {
        _title3 = [[UILabel alloc] init];
        _title3.textAlignment = NSTextAlignmentCenter;
        _title3.font = [UIFont systemFontOfSize:13];
        _title3.textColor = [UIColor colorWithHexString:@"333333"];
        _title3.text = @"局部改造";
    }
    return _title3;
}

-(UILabel *)title4
{
    if(!_title4)
    {
        _title4 = [[UILabel alloc] init];
        _title4.textAlignment = NSTextAlignmentCenter;
        _title4.font = [UIFont systemFontOfSize:13];
        _title4.textColor = [UIColor colorWithHexString:@"333333"];
        _title4.text = @"别墅大宅";
    }
    return _title4;
}


@end
