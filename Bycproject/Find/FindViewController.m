//
//  FindViewController.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/15.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "FindViewController.h"
#import "findmenuView.h"

@interface FindViewController ()<UITextFieldDelegate,SDCycleScrollViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) NSMutableArray *imageArray;
@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic,strong) findmenuView *menuView;
@property (nonatomic,strong) UIView *navTitleView;
@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self vhl_setNavBarShadowImageHidden:YES];
    self.navigationItem.titleView = self.navTitleView;
    [self creageSdcycle];
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


-(void)creageSdcycle
{
    self.imageArray = [NSMutableArray arrayWithObjects:@"http://pic39.nipic.com/20140307/13928177_195158772185_2.jpg",@"http://pic39.nipic.com/20140307/13928177_195158772185_2.jpg",@"http://photocdn.sohu.com/20120213/Img334502666.jpg", nil];
    
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(11, getRectNavAndStatusHight+20,  WIDTH-22, 130)  delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.cycleScrollView.layer.masksToBounds = YES;
    self.cycleScrollView.layer.cornerRadius = 8;
    self.cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    [self.view addSubview:self.cycleScrollView];

    //采用网络图片
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.cycleScrollView.imageURLStringsGroup = self.imageArray;
    });
    
    self.menuView  = [[findmenuView alloc] initWithFrame:CGRectMake(0, getRectNavAndStatusHight+170, WIDTH, 80)];
    [self.view addSubview:self.menuView];
    
}

@end
