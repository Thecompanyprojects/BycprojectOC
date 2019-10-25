//
//  LoginViewController.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/19.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "LoginViewController.h"
#import "ForgetViewController.h"
#import "LogupViewController.h"


@interface LoginViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) loginView *logview0;
@property (nonatomic,strong) loginView *logview1;
@property (nonatomic,strong) UIButton *submitBtn;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
}

-(void)createUI
{
    UILabel *titleLab = [[UILabel alloc] init];
    [self.view addSubview:titleLab];
    titleLab.text = @"账号密码登录";
    titleLab.textColor = [UIColor blackColor];
    titleLab.font = [UIFont systemFontOfSize:21];
    titleLab.frame = CGRectMake(22, 30+getRectNavAndStatusHight, WIDTH-44, 23);

    UILabel *messageLab = [[UILabel alloc] init];
    [self.view addSubview:messageLab];
    messageLab.frame = CGRectMake(22, 30+getRectNavAndStatusHight+23+12, WIDTH-44, 12);
    messageLab.font = [UIFont systemFontOfSize:11];
    messageLab.text = @"验证通过即可登录";
    messageLab.textColor = [UIColor colorWithHexString:@"666666"];
    
    self.logview0 = [[loginView alloc] init];
    [self.view addSubview:self.logview0];
    self.logview0.titleLab.text = @"手机号";
    self.logview0.contentText.keyboardType = UIKeyboardTypePhonePad;
    self.logview0.contentText.delegate = self;
    self.logview0.contentText.placeholder = @"请输入手机号";
    self.logview0.contentText.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"]?:@"";
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
    self.logview1.titleLab.text = @"密码";
    self.logview1.contentText.delegate = self;
    self.logview1.contentText.secureTextEntry = YES;
    self.logview1.contentText.placeholder = @"请输入密码";
    self.logview1.contentText.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"]?:@"";
    [self.logview1.contentText addDoneOnKeyboardWithTarget:self action:@selector(btnSearchClick)];
    [self.logview1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLab);
        make.top.equalTo(self.logview0.mas_bottom).with.offset(3);
        make.centerX.equalTo(self.view);
        make.height.mas_offset(50);
    }];
    
    self.submitBtn = [[UIButton alloc] init];
    [self.view addSubview:self.submitBtn];
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
    self.submitBtn.userInteractionEnabled = NO;
    self.submitBtn.layer.masksToBounds = YES;
    self.submitBtn.layer.cornerRadius = 22;
    [self.submitBtn addTarget:self action:@selector(submitbtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *leftBtn = [[UIButton alloc] init];
    [self.view addSubview:leftBtn];
    [leftBtn setTitle:@"验证码登录" forState:normal];
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
    
    UIButton *rightBtn = [[UIButton alloc] init];
    [self.view addSubview:rightBtn];
    [rightBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:normal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBtn setTitle:@"忘记密码" forState:normal];
    [rightBtn addTarget:self action:@selector(rightbtnClick) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftBtn);
        make.right.equalTo(self.submitBtn);
        make.width.mas_offset(100);
        make.height.mas_offset(20);
    }];
}

-(void)submitbtnClick
{
    NSString *phone = self.logview0.contentText.text?:@"";
    NSString *password = self.logview1.contentText.text?:@"";
    NSString *url = [BaseURL stringByAppendingFormat:@"%@", loginUrl];
    NSDictionary *params = @{@"phone":phone,@"password":password};
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [NetManager afPostRequest:url parms:params finished:^(id responseObj) {
        if ([[responseObj objectForKey:@"code"] intValue]==1000) {
            NSDictionary *data = [responseObj objectForKey:@"data"];
            NSDictionary *agency = [data objectForKey:@"agency"];
            AgencyModel *model = [AgencyModel yy_modelWithDictionary:agency];
            NSLog(@"%@",model.agencyId);
                    
            [[NSUserDefaults standardUserDefaults] setObject:phone forKey:@"phone"];
            [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];
            [[NSUserDefaults standardUserDefaults] setObject:model.trueName forKey:@"trueName"];
            [[NSUserDefaults standardUserDefaults] setObject:model.photo forKey:@"headurl"];
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
    LogupViewController *vc = [LogupViewController new];
    [self.navigationController pushViewController:vc animated:true];
}

-(void)rightbtnClick
{
    ForgetViewController *vc = [ForgetViewController new];
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

@end
