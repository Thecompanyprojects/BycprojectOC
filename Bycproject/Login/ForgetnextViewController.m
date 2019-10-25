//
//  ForgetnextViewController.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/19.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "ForgetnextViewController.h"
#import "JKCountDownButton.h"

@interface ForgetnextViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) loginView *logview0;
@property (nonatomic,strong) loginView *logview1;
@property (nonatomic,strong) loginView *logview2;
@property (nonatomic,strong) UIButton *submitBtn;

@end

@implementation ForgetnextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"重新登录密码";
    [self createUI];
}

#pragma mark - 获取验证码

-(void)getsmsCode
{
    NSString *url = [BaseURL stringByAppendingFormat:@"%@", getSms];
    NSString *phone = self.phone.copy?:@"";
    NSDictionary *params = @{@"phone":phone,@"smsType":@"1"};
 
    [NetManager afPostRequest:url parms:params finished:^(id responseObj) {
        NSString *msg = [responseObj objectForKey:@"msg"];
        [MBProgressHUD showMessage:msg];
    } failed:^(NSString *errorMsg) {
        
    }];
}

-(void)createUI
{
    UILabel *messageLab = [[UILabel alloc] init];
    [self.view addSubview:messageLab];
    messageLab.frame = CGRectMake(22, getRectNavAndStatusHight+30, WIDTH-44, 40);
    messageLab.textColor = [UIColor blackColor];
    messageLab.font = [UIFont systemFontOfSize:14];
    messageLab.text = [NSString stringWithFormat:@"%@%@",@"验证码已发送至",self.phone];
    
    self.logview0 = [[loginView alloc] init];
    [self.view addSubview:self.logview0];
    self.logview0.titleLab.text = @"验证码";
    self.logview0.contentText.delegate = self;
    self.logview0.contentText.placeholder = @"请输入验证码";
    self.logview0.contentText.keyboardType = UIKeyboardTypePhonePad;
    [self.logview0.titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(66);
    }];
    [self.logview0.contentText addDoneOnKeyboardWithTarget:self action:@selector(btnSearchClick)];
    [self.logview0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(messageLab);
        make.top.equalTo(messageLab.mas_bottom).with.offset(10);
        make.centerX.equalTo(self.view);
        make.height.mas_offset(50);
    }];
        
    UIView *line0 = [[UIView alloc] init];
    [self.view addSubview:line0];
    line0.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    [line0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logview0);
        make.right.equalTo(self.logview0);
        make.top.equalTo(self.logview0.mas_bottom);
        make.height.mas_offset(1);
    }];

    
    JKCountDownButton *_countDownCode;
    _countDownCode = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
    [_countDownCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    _countDownCode.backgroundColor = [UIColor whiteColor];
    _countDownCode.titleLabel.font = [UIFont systemFontOfSize:14];
    [_countDownCode setTitleColor:[UIColor colorWithHexString:@"#F30C0C"] forState:normal];
    [self.view addSubview:_countDownCode];
    
    [_countDownCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.logview0);
        make.top.equalTo(self.logview0);
        make.bottom.equalTo(self.logview0);
        make.width.mas_offset(77);
    }];
    
    [_countDownCode countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
 
        sender.enabled = NO;
        
        [self getsmsCode];
        
        [sender startCountDownWithSecond:60];
        [sender countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
            NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
            return title;
        }];
        [sender countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
            countDownButton.enabled = YES;
            return @"获取验证码";
        }];
    }];
    
    self.logview1 = [[loginView alloc] init];
    [self.view addSubview:self.logview1];
    self.logview1.titleLab.text = @"设置密码";
    self.logview1.contentText.delegate = self;
    self.logview1.contentText.placeholder = @"请输入密码";
    self.logview1.contentText.secureTextEntry = YES;
    [self.logview1.titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(66);
    }];
    [self.logview1.contentText addDoneOnKeyboardWithTarget:self action:@selector(btnSearchClick)];
    [self.logview1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(messageLab);
        make.top.equalTo(line0.mas_bottom).with.offset(2);
        make.centerX.equalTo(self.view);
        make.height.mas_offset(50);
    }];
    
    UIView *line1 = [[UIView alloc] init];
    [self.view addSubview:line1];
    line1.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logview0);
        make.right.equalTo(self.logview0);
        make.top.equalTo(self.logview1.mas_bottom);
        make.height.mas_offset(1);
    }];
    
    self.logview2 = [[loginView alloc] init];
    [self.view addSubview:self.logview2];
    self.logview2.titleLab.text = @"确认密码";
    self.logview2.contentText.delegate = self;
    self.logview2.contentText.placeholder = @"请确认密码";
    self.logview2.contentText.secureTextEntry = YES;
    [self.logview2.titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(66);
    }];
    [self.logview2.contentText addDoneOnKeyboardWithTarget:self action:@selector(btnSearchClick)];
    [self.logview2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(messageLab);
        make.top.equalTo(line1.mas_bottom).with.offset(2);
        make.centerX.equalTo(self.view);
        make.height.mas_offset(50);
    }];
    
    UIView *line2 = [[UIView alloc] init];
    [self.view addSubview:line2];
    line1.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logview0);
        make.right.equalTo(self.logview0);
        make.top.equalTo(self.logview2.mas_bottom);
        make.height.mas_offset(1);
    }];

    
    self.submitBtn = [[UIButton alloc] init];
    [self.view addSubview:self.submitBtn];
    self.submitBtn.userInteractionEnabled = NO;
    [self.submitBtn setTitle:@"登录" forState:normal];
    [self.submitBtn setTitleColor:[UIColor whiteColor] forState:normal];
    self.submitBtn.backgroundColor = [UIColor colorWithHexString:@"FFCCCC"];
    self.submitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logview0);
        make.right.equalTo(self.logview0);
        make.top.equalTo(self.logview2.mas_bottom).with.offset(22);
        make.height.mas_offset(45);
    }];
    self.submitBtn.layer.masksToBounds = YES;
    self.submitBtn.layer.cornerRadius = 22;
    [self.submitBtn addTarget:self action:@selector(submitbtnClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)submitbtnClick
{
    
    NSString *pwd0 = self.logview1.contentText.text?:@"";
    NSString *pwd1 = self.logview2.contentText.text?:@"";
    NSString *code = self.logview0.contentText.text?:@"";
    if (code.length==0) {
        [MBProgressHUD showMessage:@"请输入验证码"];
        return;
    }
    if (pwd0.length==0) {
        [MBProgressHUD showMessage:@"请输入新密码"];
        return;
    }
    if (pwd1.length==0) {
        [MBProgressHUD showMessage:@"请确认新密码"];
        return;
    }
    if (![pwd0 isEqualToString:pwd1]) {
        [MBProgressHUD showMessage:@"两次密码不一致"];
        return;
    }
 
    NSString *phone = self.phone.copy?:@"";
    NSString *newPwd = self.logview1.contentText.text?:@"";
    
    NSDictionary *params = @{@"phone":phone,@"newPwd":newPwd,@"code":code};
    NSString *url = [BaseURL stringByAppendingFormat:@"%@", resetNewPwdUrl];
    [NetManager afPostRequest:url parms:params finished:^(id responseObj) {
        NSString *msg = [responseObj objectForKey:@"msg"];
        [MBProgressHUD showMessage:msg];
    } failed:^(NSString *errorMsg) {
        
    }];
}

-(void)btnSearchClick
{
    [self.logview0.contentText resignFirstResponder];
    [self.logview1.contentText resignFirstResponder];
    [self.logview2.contentText resignFirstResponder];
    [self status];
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
    if (self.logview1.contentText.text.length != 0 &&self.logview0.contentText.text.length != 0&&self.logview2.contentText.text.length != 0) {
        self.submitBtn.userInteractionEnabled = YES;
        self.submitBtn.backgroundColor = MainColor;
    }else{
        self.submitBtn.backgroundColor = [UIColor colorWithHexString:@"FFCCCC"];
        self.submitBtn.userInteractionEnabled = NO;
    }
}

@end
