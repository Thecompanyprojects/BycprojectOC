//
//  FindViewController.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/15.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "FindViewController.h"
#import "findmenuView.h"
#import "AddressViewController.h"
#import "companyCell.h"


@interface FindViewController ()<UITextFieldDelegate,SDCycleScrollViewDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray *imageArray;
@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic,strong) findmenuView *menuView;
@property (nonatomic,strong) UIView *navTitleView;
@property (nonatomic,strong) DKSButton *addressBtn;
@property (nonatomic,strong) UITextField *search;

@property (nonatomic,copy) NSString *provinceId;
@property (nonatomic,copy) NSString *cityId;
@property (nonatomic,copy) NSString *countyId;
@property (nonatomic,copy) NSString *addName;

@property (nonatomic,strong) UIButton *chooseBtn0;
@property (nonatomic,strong) UIButton *chooseBtn1;
@property (nonatomic,strong) UIButton *chooseBtn2;

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,assign) NSInteger page;
@property (nonatomic,copy) NSString *serchContent;
@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self vhl_setNavBarShadowImageHidden:YES];
    self.navigationItem.titleView = self.navTitleView;
    [self creageSdcycle];
    [self createchooseView];
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 0;
        [self getdataFromwebWith:@"1"];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self getdataFromwebWith:@"2"];
        self.page++;
    }];
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

-(void)createchooseView
{
    self.chooseBtn0 = [[UIButton alloc] init];
    self.chooseBtn1 = [[UIButton alloc] init];
    self.chooseBtn2 = [[UIButton alloc] init];
    [self.view addSubview:self.chooseBtn0];
    [self.view addSubview:self.chooseBtn1];
    [self.view addSubview:self.chooseBtn2];

    self.chooseBtn0.titleLabel.font = [UIFont systemFontOfSize:12];
    self.chooseBtn1.titleLabel.font = [UIFont systemFontOfSize:12];
    self.chooseBtn2.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.chooseBtn0 setTitle:@"距离" forState:normal];
    [self.chooseBtn1 setTitle:@"排序" forState:normal];
    [self.chooseBtn2 setTitle:@"筛选" forState:normal];
    [self.chooseBtn0 setTitleColor:[UIColor colorWithHexString:@"262626"] forState:normal];
    [self.chooseBtn1 setTitleColor:[UIColor colorWithHexString:@"262626"] forState:normal];
    [self.chooseBtn2 setTitleColor:[UIColor colorWithHexString:@"262626"] forState:normal];
    [self.chooseBtn0 setImage:[UIImage imageNamed:@"icon_xiaosanjiao"] forState:normal];
    [self.chooseBtn1 setImage:[UIImage imageNamed:@"icon_xiaosanjiao"] forState:normal];
    [self.chooseBtn2 setImage:[UIImage imageNamed:@"icon_xiaosanjiao"] forState:normal];
    [self.chooseBtn0 setRightIamegWithSpacing:20];
    [self.chooseBtn1 setRightIamegWithSpacing:20];
    [self.chooseBtn2 setRightIamegWithSpacing:20];
    self.chooseBtn0.frame = CGRectMake(0, getRectNavAndStatusHight+250, WIDTH/3, 44);
    self.chooseBtn1.frame = CGRectMake(WIDTH/3, getRectNavAndStatusHight+250, WIDTH/3, 44);
    self.chooseBtn2.frame = CGRectMake(WIDTH/3*2, getRectNavAndStatusHight+250, WIDTH/3, 44);
    
}

/// 选择地址
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


-(UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] init];
        if (ISIPHONEX) {
            self.tableView.frame = CGRectMake(0, 400, WIDTH, HEIGHT-350);
        }
        else
        {
            self.tableView.frame = CGRectMake(0, 400, WIDTH, HEIGHT-350);
        }
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}


-(void)getdataFromwebWith:(NSString *)str
{
    
    if ([str intValue]==1) {
        self.dataSource = [NSMutableArray array];
    }
    
    NSString *url = [BaseURL stringByAppendingFormat:@"%@", Homeindex];
    NSString *longitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"lng"]?:@"";
    NSString *latitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"lat"]?:@"";
    NSString *serchContent = self.serchContent?:@"";
    NSString *page = [NSString stringWithFormat:@"%ld",self.page];
    NSString *pageSize = @"30";
    NSString *needLocation = @"1";
    NSString *type = @"2";
    NSString *merchantType = @"";
    NSString *provinceId = self.provinceId.copy?:@"";
    NSString *cityId = self.cityId.copy?:@"";
    NSString *countyId = self.countyId.copy?:@"";
    
    NSDictionary *params = @{@"longitude":longitude,@"latitude":latitude,@"serchContent":serchContent,@"page":page,@"pageSize":pageSize,@"needLocation":needLocation,@"type":type,@"merchantType":merchantType,@"provinceId":provinceId,@"cityId":cityId,@"countyId":countyId};
    [NetManager afPostRequest:url parms:params finished:^(id responseObj) {
        if ([[responseObj objectForKey:@"code"] intValue]==1000) {
            
            NSDictionary *data = [responseObj objectForKey:@"data"];
            NSArray *commodityList = [data objectForKey:@"commodityList"];
            NSArray *array = [NSArray yy_modelArrayWithClass:[companyModel class] json:commodityList];
            [self.dataSource addObjectsFromArray:array];
            [self.tableView reloadData];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failed:^(NSString *errorMsg) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count?:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    companyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"companycell"];
    cell = [[companyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"companycell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    self.serchContent = textField.text?:@"";
    [self.tableView.mj_header beginRefreshing];
    return YES;
}

@end
