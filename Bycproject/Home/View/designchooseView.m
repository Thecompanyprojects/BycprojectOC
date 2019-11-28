//
//  designchooseView.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/11/24.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "designchooseView.h"

@interface designchooseView()
@property (nonatomic,strong) UIButton *btn0;
@property (nonatomic,strong) UIButton *btn1;
@property (nonatomic,strong) UIButton *btn2;
@property (nonatomic,strong) UIButton *btn3;
@property (nonatomic,strong) UIButton *btn4;
@property (nonatomic,strong) UIButton *btn5;

@property (nonatomic,copy) NSString *typeStr;
 
@end

@implementation designchooseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.btn0];
        [self addSubview:self.btn1];
        [self addSubview:self.btn2];
        [self addSubview:self.btn3];
        [self addSubview:self.btn4];
        [self addSubview:self.btn5];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.width.mas_offset(WIDTH/3-2);
        make.top.equalTo(weakSelf).with.offset(20);
        make.height.mas_offset(34);
    }];
    [weakSelf.btn0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(20);
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf.btn1.mas_left);
        make.height.mas_offset(34);
    }];
    [weakSelf.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(20);
        make.right.equalTo(weakSelf);
        make.height.mas_offset(34);
        make.left.equalTo(weakSelf.btn1.mas_right);
    }];
    
    [weakSelf.btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.btn0.mas_bottom).with.offset(10);
        make.centerX.equalTo(weakSelf);
        make.height.mas_offset(34);
        make.width.mas_offset(WIDTH/3-2);
    }];
    
    [weakSelf.btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.btn0.mas_bottom).with.offset(10);
        make.left.equalTo(weakSelf);
        make.height.mas_offset(34);
        make.right.equalTo(weakSelf.btn4.mas_left);
    }];
    
    [weakSelf.btn5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.btn3);
        make.left.equalTo(weakSelf.btn4.mas_right);
        make.height.mas_offset(34);
        make.width.mas_offset(WIDTH/3-2);
    }];
}

-(UIButton *)btn0
{
    if(!_btn0)
    {
        _btn0 = [UIButton new];
        [_btn0 setTitleColor:[UIColor darkGrayColor] forState:normal];
        _btn0.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btn0 setTitle:@"设计师" forState:normal];
        [_btn0 addTarget:self action:@selector(btn0click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn0;
}

-(UIButton *)btn1
{
    if(!_btn1)
    {
        _btn1 = [UIButton new];
        [_btn1 setTitleColor:[UIColor darkGrayColor] forState:normal];
        _btn1.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btn1 setTitle:@"建筑师" forState:normal];
        [_btn1 addTarget:self action:@selector(btn1click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn1;
}

-(UIButton *)btn2
{
    if(!_btn2)
    {
        _btn2 = [UIButton new];
        [_btn2 setTitleColor:[UIColor darkGrayColor] forState:normal];
        _btn2.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btn2 setTitle:@"水工" forState:normal];
        [_btn2 addTarget:self action:@selector(btn2click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn2;
}

-(UIButton *)btn3
{
    if(!_btn3)
    {
        _btn3 = [UIButton new];
        [_btn3 setTitleColor:[UIColor darkGrayColor] forState:normal];
        _btn3.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btn3 setTitle:@"木工" forState:normal];
        [_btn3 addTarget:self action:@selector(btn3click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn3;
}
-(UIButton *)btn4
{
    if(!_btn4)
    {
        _btn4 = [UIButton new];
        [_btn4 setTitleColor:[UIColor darkGrayColor] forState:normal];
        _btn4.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btn4 setTitle:@"装修" forState:normal];
        [_btn4 addTarget:self action:@selector(btn4click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn4;
}

-(UIButton *)btn5
{
    if(!_btn5)
    {
        _btn5 = [UIButton new];
        [_btn5 setTitleColor:[UIColor darkGrayColor] forState:normal];
        _btn5.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btn5 setTitle:@"工人" forState:normal];
        [_btn5 addTarget:self action:@selector(btn5click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn5;
}

-(void)btn0click
{
    self.typeStr = @"0";
    [self choosebtnClick];
}

-(void)btn1click
{
    self.typeStr = @"1";
    [self choosebtnClick];
}

-(void)btn2click
{
    self.typeStr = @"2";
    [self choosebtnClick];
}

-(void)btn3click
{
    self.typeStr = @"3";
    [self choosebtnClick];
}

-(void)btn4click
{
    self.typeStr = @"4";
    [self choosebtnClick];
}

-(void)btn5click
{
    self.typeStr = @"5";
    [self choosebtnClick];
}


-(void)choosebtnClick
{
    
    if (self.delegate) {
        [self.delegate myMenuClick:self.typeStr];
    }
}

@end
