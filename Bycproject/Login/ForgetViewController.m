//
//  ForgetViewController.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/19.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "ForgetViewController.h"
#import "ForgetnextViewController.h"


@interface ForgetViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) loginView *logView;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UIButton *submitBtn;
@end

@implementation ForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"重新登录密码";
    [self.view addSubview:self.logView];
    [self.view addSubview:self.line];
    [self.view addSubview:self.submitBtn];
}

-(loginView *)logView
{
    if(!_logView)
    {
        _logView = [[loginView alloc] init];
        _logView.frame = CGRectMake(22, getRectNavAndStatusHight+23, WIDTH-44, 50);
        _logView.titleLab.text = @"手机号";
        _logView.contentText.placeholder = @"请输入手机号";
        _logView.contentText.delegate = self;
        _logView.contentText.keyboardType = UIKeyboardTypePhonePad;
        [_logView.contentText addDoneOnKeyboardWithTarget:self action:@selector(btnSearchClick)];
    }
    return _logView;
}


-(UIView *)line
{
    if(!_line)
    {
        _line = [[UIView alloc] init];
        _line.frame = CGRectMake(22, 23+50+getRectNavAndStatusHight, WIDTH-44, 1);
        _line.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    }
    return _line;
}

-(UIButton *)submitBtn
{
    if(!_submitBtn)
    {
        _submitBtn = [[UIButton alloc] init];
        _submitBtn.frame = CGRectMake(22, 23+50+getRectNavAndStatusHight+30, WIDTH-44, 45);
        [_submitBtn setTitle:@"登录" forState:normal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:normal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 22;
        _submitBtn.userInteractionEnabled = NO;
        [_submitBtn addTarget:self action:@selector(submitbtnClick) forControlEvents:UIControlEventTouchUpInside];
        _submitBtn.backgroundColor = [UIColor colorWithHexString:@"FFCCCC"];
    }
    return _submitBtn;
}

-(void)submitbtnClick
{
    ForgetnextViewController *vc = [ForgetnextViewController new];
    vc.phone = self.logView.contentText.text;
    [self.navigationController pushViewController:vc animated:true];
}

//textField代理方法
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self status];
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self status];
    [self.view endEditing:YES];
}

-(void)status{
    
    if (self.logView.contentText.text.length != 0) {
        self.submitBtn.userInteractionEnabled = YES;
        self.submitBtn.backgroundColor = MainColor;
    }else{
        self.submitBtn.backgroundColor = [UIColor colorWithHexString:@"FFCCCC"];
        self.submitBtn.userInteractionEnabled = NO;
    }
}

-(void)btnSearchClick
{
    [self.logView.contentText resignFirstResponder];
    [self status];
}


@end
