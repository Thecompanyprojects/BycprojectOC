//
//  LogupViewController.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/19.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "LogupViewController.h"
#import "JKCountDownButton.h"
#import "LoginViewController.h"
#import "AgencyModel.h"

@interface LogupViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) loginView *logview0;
@property (nonatomic,strong) loginView *logview1;
@property (nonatomic,strong) UIButton *submitBtn;

@end

@implementation LogupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
    
}

-(void)createUI
{
    UILabel *titleLab = [[UILabel alloc] init];
    [self.view addSubview:titleLab];
    titleLab.text = @"手机号登录/注册";
    titleLab.textColor = [UIColor blackColor];
    titleLab.font = [UIFont systemFontOfSize:21];
    titleLab.frame = CGRectMake(22, 30+getRectNavAndStatusHight, WIDTH-44, 23);

    UILabel *messageLab = [[UILabel alloc] init];
    [self.view addSubview:messageLab];
    messageLab.frame = CGRectMake(22, 30+getRectNavAndStatusHight+23+12, WIDTH-44, 12);
    messageLab.font = [UIFont systemFontOfSize:11];
    messageLab.text = @"未注册手机号验证后自动注册";
    messageLab.textColor = [UIColor colorWithHexString:@"666666"];
 
    self.logview0 = [[loginView alloc] init];
    [self.view addSubview:self.logview0];
    self.logview0.titleLab.text = @"手机号";
    self.logview0.contentText.delegate = self;
    self.logview0.contentText.keyboardType = UIKeyboardTypePhonePad;
    self.logview0.contentText.placeholder = @"请输入手机号";
    [self.logview0.contentText addDoneOnKeyboardWithTarget:self action:@selector(btnSearchClick)];
    [self.logview0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLab);
        make.top.equalTo(messageLab.mas_bottom).with.offset(70);
        make.centerX.equalTo(self.view);
        make.height.mas_offset(50);
    }];
       
    UIView *line = [[UIView alloc] init];
    [self.view addSubview:line];
    line.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logview0);
        make.right.equalTo(self.logview0);
        make.top.equalTo(self.logview0.mas_bottom);
        make.height.mas_offset(1);
    }];
       
    self.logview1 = [[loginView alloc] init];
    [self.view addSubview:self.logview1];
    self.logview1.titleLab.text = @"验证码";
    self.logview1.contentText.delegate = self;
    self.logview1.contentText.keyboardType = UIKeyboardTypePhonePad;
    self.logview1.contentText.placeholder = @"请输入验证码";
    [self.logview1.contentText addDoneOnKeyboardWithTarget:self action:@selector(btnSearchClick)];
    [self.logview1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLab);
        make.top.equalTo(self.logview0.mas_bottom).with.offset(3);
        make.centerX.equalTo(self.view);
        make.height.mas_offset(50);
    }];
       
    
    JKCountDownButton *_countDownCode;
    _countDownCode = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
    [_countDownCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    _countDownCode.backgroundColor = [UIColor whiteColor];
    _countDownCode.titleLabel.font = [UIFont systemFontOfSize:14];
    [_countDownCode setTitleColor:[UIColor colorWithHexString:@"#F30C0C"] forState:normal];
    [self.view addSubview:_countDownCode];
    
    [_countDownCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.logview1);
        make.top.equalTo(self.logview1);
        make.bottom.equalTo(self.logview1);
        make.width.mas_offset(77);
    }];
    
    [_countDownCode countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
        
        NSString *phone = self.logview0.contentText.text?:@"";
        if (phone.length==0) {
            [MBProgressHUD showMessage:@"请输入手机号"];
            return ;
        }
        
        [self getsmsCode];
        
        sender.enabled = NO;
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
        make.top.equalTo(self.logview1.mas_bottom).with.offset(22);
        make.height.mas_offset(45);
    }];
    self.submitBtn.layer.masksToBounds = YES;
    self.submitBtn.layer.cornerRadius = 22;
    [self.submitBtn addTarget:self action:@selector(submitbtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *leftBtn = [[UIButton alloc] init];
    [self.view addSubview:leftBtn];
    [leftBtn setTitle:@"账号密码登录" forState:normal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [leftBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:normal];
    [leftBtn addTarget:self action:@selector(leftbtnClick) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.submitBtn.mas_bottom).with.offset(18);
        make.left.equalTo(self.submitBtn);
        make.width.mas_offset(100);
        make.height.mas_offset(20);
    }];
}


-(void)submitbtnClick
{
    NSString *phone = self.logview0.contentText.text?:@"";
    NSString *phoneCode = self.logview1.contentText.text?:@"";
    NSDictionary *params = @{@"phone":phone,@"phoneCode":phoneCode};
    NSString *url = [BaseURL stringByAppendingFormat:@"%@", loginUrl];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [NetManager afPostRequest:url parms:params finished:^(id responseObj) {
        if ([[responseObj objectForKey:@"code"] intValue]==1000) {
            
            NSDictionary *data = [responseObj objectForKey:@"data"];
            NSDictionary *agency = [data objectForKey:@"agency"];
            AgencyModel *model = [AgencyModel yy_modelWithDictionary:agency];
            NSLog(@"%@",model.phone);
            [[NSUserDefaults standardUserDefaults] setObject:phone forKey:@"phone"];
            [[NSUserDefaults standardUserDefaults] setObject:model.trueName forKey:@"trueName"];
            [[NSUserDefaults standardUserDefaults] setObject:model.photo forKey:@"headUrl"];
            [[NSUserDefaults standardUserDefaults] setObject:model.agencyId forKey:@"agencyId"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[NSUserDefaults standardUserDefaults] setObject:model.agencyId forKey:@"agencyId"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [MBProgressHUD hideHUDForView:self.view];
            MainViewController *mvc = [[MainViewController alloc] init];
            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
            app.window.rootViewController = mvc;
            
        }
        else
        {
            NSString *msg = [responseObj objectForKey:@"msg"];
            [MBProgressHUD showMessage:msg];
            [MBProgressHUD hideHUDForView:self.view];
        }
        
    } failed:^(NSString *errorMsg) {
         [MBProgressHUD hideHUDForView:self.view];
    }];
}

-(void)leftbtnClick
{
    LoginViewController *vc = [LoginViewController new];
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
    
    if (self.logview1.contentText.text.length != 0 &&self.logview0.contentText.text.length != 0) {
        self.submitBtn.userInteractionEnabled = YES;
        self.submitBtn.backgroundColor = MainColor;
    }else{
        self.submitBtn.backgroundColor = [UIColor colorWithHexString:@"FFCCCC"];
        self.submitBtn.userInteractionEnabled = NO;
    }
}

-(void)btnSearchClick
{
    [self.logview0.contentText resignFirstResponder];
    [self.logview1.contentText resignFirstResponder];
    [self status];
}

#pragma mark - 获取验证码

-(void)getsmsCode
{
    NSString *url = [BaseURL stringByAppendingFormat:@"%@", getSms];
    NSString *phone = self.logview0.contentText.text?:@"";
    NSDictionary *params = @{@"phone":phone,@"smsType":@"1"};
 
    [NetManager afPostRequest:url parms:params finished:^(id responseObj) {
        NSString *msg = [responseObj objectForKey:@"msg"];
        [MBProgressHUD showMessage:msg];
    } failed:^(NSString *errorMsg) {
        
    }];
}

@end
