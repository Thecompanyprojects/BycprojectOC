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

@interface HomeViewController ()<XXPageTabViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) MenuView *menuview;
@property (nonatomic, strong) XXPageTabView *pageTabView;
@property (nonatomic,strong) UIView *navTitleView;
@property (nonatomic,copy) NSString *cityId;
@property (nonatomic,copy) NSString *countyId;
@property (nonatomic,copy) NSString *addName;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = self.navTitleView;
    [self createtapView];
    self.menuview = [[MenuView alloc] init];
    if (isiPhoneX) {
        self.menuview.frame = CGRectMake(0, 88, WIDTH, 180);
    }
    else
    {
        self.menuview.frame = CGRectMake(0, 64, WIDTH, 180);
    }
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

-(UIView *)navTitleView
{
    if(!_navTitleView)
    {
        _navTitleView = [UIView new];
        _navTitleView.backgroundColor = [UIColor colorWithHexString:@"F3F3F3"];
        if (@available(iOS 11.0, *)){
            _navTitleView.translatesAutoresizingMaskIntoConstraints = NO;
        }
        DKSButton *addressBtn = [[DKSButton alloc] init];
        [addressBtn setImage:[UIImage imageNamed:@"icon_xiaosanjiao"] forState:normal];
        [addressBtn setTitle:@"北京市" forState:normal];
        addressBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [addressBtn setTitleColor:[UIColor colorWithHexString:@"010101"] forState:normal];
        [_navTitleView addSubview:addressBtn];
        addressBtn.frame = CGRectMake(10, 0,60, 30);
        addressBtn.padding = 4;
        [addressBtn addTarget:self action:@selector(changeaddressClick) forControlEvents:UIControlEventTouchUpInside];
        addressBtn.buttonStyle = DKSButtonImageRight;
        
        UIImageView *leftImg = [UIImageView new];
        [_navTitleView addSubview:leftImg];
        leftImg.image = [UIImage imageNamed:@"icon_sousuo"];
        leftImg.frame = CGRectMake(70, 6, 18, 18);
        
        UIImageView *rightimg = [[UIImageView alloc] init];
        [_navTitleView addSubview:rightimg];
        rightimg.image = [UIImage imageNamed:@"icon_yuy"];
        rightimg.frame = CGRectMake(WIDTH-18-40, 6, 12, 18);
        
        UITextField *search = [[UITextField alloc] init];
        search.delegate = self;
        search.returnKeyType = UIReturnKeySearch;
        search.backgroundColor = [UIColor colorWithHexString:@"F3F3F3"];
        [_navTitleView addSubview:search];
        search.frame = CGRectMake(92, 2, WIDTH-92-60, 30);
        
    }
    return _navTitleView;
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
    };
    [self.navigationController pushViewController:vc animated:YES];
}

@end
