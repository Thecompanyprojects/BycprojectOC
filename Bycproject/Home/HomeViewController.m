//
//  HomeViewController.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/15.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "HomeViewController.h"
#import "MenuView.h"
#import "XXPageTabView.h"
#import "homecaseVC.h"
#import "homefoodVC.h"
#import "homecompanyVC.h"
#import "homestrategyVC.h"
#import "homeeffectVC.h"
#import "AddressViewController.h"
#import "renovationcaseVC.h"
#import "homefurnishingVC.h"
#import "designpersonVC.h"

@interface HomeViewController ()<XXPageTabViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) MenuView *menuview;
@property (nonatomic, strong) XXPageTabView *pageTabView;
@property (nonatomic,strong) UIView *navTitleView;

@property (nonatomic,strong) DKSButton *addressBtn;
@property (nonatomic,strong) UITextField *search;

@property (nonatomic,copy) NSString *provinceId;
@property (nonatomic,copy) NSString *cityId;
@property (nonatomic,copy) NSString *countyId;
@property (nonatomic,copy) NSString *addName;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self vhl_setNavBarShadowImageHidden:YES];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = self.navTitleView;
    [self createtapView];
    [self.view addSubview:self.menuview];
    
    [self getinfofromweb];
}

-(void)getinfofromweb
{
    NSString *url = [BaseURL stringByAppendingFormat:@"%@", Homeindex];
    NSString *lat = [[NSUserDefaults standardUserDefaults] objectForKey:@"lat"];
    NSString *lng = [[NSUserDefaults standardUserDefaults] objectForKey:@"lng"];
    NSDictionary *params = @{@"longitude":lat,@"longitude":lng};
    [NetManager afPostRequest:url parms:params finished:^(id responseObj) {
        
    } failed:^(NSString *errorMsg) {
        
    }];
}

-(MenuView *)menuview
{
    if(!_menuview)
    {
        _menuview = [[MenuView alloc] init];
        if (isiPhoneX) {
            _menuview.frame = CGRectMake(0, 88, WIDTH, 180);
        }
        else
        {
            _menuview.frame = CGRectMake(0, 64, WIDTH, 180);
        }
        _menuview.view0.userInteractionEnabled = YES;
        _menuview.view1.userInteractionEnabled = YES;
        _menuview.view2.userInteractionEnabled = YES;
        _menuview.view3.userInteractionEnabled = YES;
        _menuview.view4.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGesturRecognizer0 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction0:)];
        [_menuview.view0 addGestureRecognizer:tapGesturRecognizer0];
        UITapGestureRecognizer *tapGesturRecognizer1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction1:)];
        [_menuview.view1 addGestureRecognizer:tapGesturRecognizer1];
        UITapGestureRecognizer *tapGesturRecognizer2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction2:)];
        [_menuview.view2 addGestureRecognizer:tapGesturRecognizer2];
        UITapGestureRecognizer *tapGesturRecognizer3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction3:)];
        [_menuview.view3 addGestureRecognizer:tapGesturRecognizer3];
        UITapGestureRecognizer *tapGesturRecognizer4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction4:)];
        [_menuview.view4 addGestureRecognizer:tapGesturRecognizer4];
    }
    return _menuview;
}


-(UIView *)navTitleView
{
    if(!_navTitleView)
    {
        _navTitleView = [UIView new];
        _navTitleView.backgroundColor = [UIColor colorWithHexString:@"F3F3F3"];
        _navTitleView.backgroundColor = [UIColor whiteColor];
        if (@available(iOS 11.0, *)){
            _navTitleView.translatesAutoresizingMaskIntoConstraints = NO;
        }
        
        self.addressBtn = [[DKSButton alloc] init];
        [self.addressBtn setImage:[UIImage imageNamed:@"icon_xiaosanjiao"] forState:normal];
        NSString *addname = [[NSUserDefaults standardUserDefaults] objectForKey:@"addname"]?:@"未定位";
        [self.addressBtn setTitle:addname forState:normal];
        self.addressBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.addressBtn setTitleColor:[UIColor colorWithHexString:@"010101"] forState:normal];
        [_navTitleView addSubview:self.addressBtn];
        self.addressBtn.frame = CGRectMake(10, 0,60, 30);
        self.addressBtn.padding = 4;
        [self.addressBtn addTarget:self action:@selector(changeaddressClick) forControlEvents:UIControlEventTouchUpInside];
        self.addressBtn.buttonStyle = DKSButtonImageRight;
        
        UIView *bgView = [UIView new];
        bgView.backgroundColor = [UIColor colorWithHexString:@"F3F3F3"];
        [_navTitleView addSubview:bgView];
        bgView.frame = CGRectMake(70, 3, WIDTH-90, 30);
        bgView.layer.masksToBounds = YES;
        bgView.layer.cornerRadius = 5;
        
        UIImageView *leftImg = [UIImageView new];
        [bgView addSubview:leftImg];
        leftImg.image = [UIImage imageNamed:@"icon_sousuo"];
        leftImg.frame = CGRectMake(10, 6, 18, 18);
        
        UIImageView *rightimg = [[UIImageView alloc] init];
        [bgView addSubview:rightimg];
        rightimg.image = [UIImage imageNamed:@"icon_yuy"];
        rightimg.frame = CGRectMake(WIDTH-90-20, 6, 12, 18);
        
        self.search = [[UITextField alloc] init];
        self.search.delegate = self;
        self.search.returnKeyType = UIReturnKeySearch;
        self.search.backgroundColor = [UIColor colorWithHexString:@"F3F3F3"];
        [bgView addSubview:self.search];
        self.search.frame = CGRectMake(32, 2, WIDTH-92-60, 26);
        
    }
    return _navTitleView;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    NSDictionary *data = @{@"search":textField.text};
    NSNotification * notice = [NSNotification notificationWithName:@"homecaseSearch" object:nil userInfo:data];
    [[NSNotificationCenter defaultCenter]postNotification:notice];
    return YES;
}

-(void)createtapView
{
    homecaseVC *test1 = [homecaseVC new];
    homefoodVC *test2 = [homefoodVC new];
    homecompanyVC *test3 = [homecompanyVC new];
    homestrategyVC *test4 = [homestrategyVC new];
    homeeffectVC *test5 = [homeeffectVC new];

    [self addChildViewController:test1];
    [self addChildViewController:test2];
    [self addChildViewController:test3];
    [self addChildViewController:test4];
    [self addChildViewController:test5];
    
    self.pageTabView = [[XXPageTabView alloc] initWithChildControllers:self.childViewControllers childTitles:@[@"找案例", @"找商品", @"找公司", @"找攻略", @"效果图"]];
    self.pageTabView.frame = CGRectMake(0, 180+getRectNavAndStatusHight, self.view.frame.size.width, self.view.frame.size.height-180-getRectNavAndStatusHight);
    self.pageTabView.delegate = self;
    self.pageTabView.maxNumberOfPageItems = 5;
    self.pageTabView.titleStyle = XXPageTabTitleStyleDefault;
    self.pageTabView.indicatorStyle = XXPageTabIndicatorStyleDefault;
    self.pageTabView.separatorColor = [UIColor whiteColor];
    self.pageTabView.minScale = 1.0;
    self.pageTabView.selectedTabIndex = 0;
    self.pageTabView.indicatorWidth = 20;
    self.pageTabView.selectedColor = [UIColor colorWithHexString:@"444444"];
    self.pageTabView.unSelectedColor = [UIColor colorWithHexString:@"666666"];
    [self.view addSubview:self.pageTabView];
}


#pragma mark - XXPageTabViewDelegate
- (void)pageTabViewDidEndChange {
    NSLog(@"#####%d", (int)self.pageTabView.selectedTabIndex);
    
}

#pragma mark - Event response
- (void)scrollToLast:(id)sender {
    [self.pageTabView setSelectedTabIndexWithAnimation:self.pageTabView.selectedTabIndex-1];
}

- (void)scrollToNext:(id)sender {
    [self.pageTabView setSelectedTabIndexWithAnimation:self.pageTabView.selectedTabIndex+1];
}

-(void)changeaddressClick
{
    AddressViewController *vc = [[AddressViewController alloc] init];
    vc.refreshBlock = ^(NSDictionary * _Nonnull modelDic) {
        self.cityId = [modelDic objectForKey:@"cityId"];
        self.countyId = [modelDic objectForKey:@"countyId"];
        self.addName = [modelDic objectForKey:@"name"];
        self.provinceId = [modelDic objectForKey:@"provinceId"];
        [self.addressBtn setTitle:self.addName?:@"" forState:normal];
        
        
        
        NSNotification * notice = [NSNotification notificationWithName:@"homeaddress" object:nil userInfo:modelDic];
        [[NSNotificationCenter defaultCenter]postNotification:notice];
        
    };
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 页面跳转

-(void)tapAction0:(id)tap
{

}

-(void)tapAction1:(id)tap
{

}

/// 建材家居
/// @param tap 建材家居
-(void)tapAction2:(id)tap
{
    homefurnishingVC *vc = [homefurnishingVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

/// 装修案例
/// @param tap 装修案例
-(void)tapAction3:(id)tap
{
    renovationcaseVC *vc = [renovationcaseVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)tapAction4:(id)tap
{
    designpersonVC *vc = [designpersonVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
