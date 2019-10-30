//
//  homecompanyVC.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/16.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "homecompanyVC.h"
#import "companyCell.h"
#import "companyModel.h"

@interface homecompanyVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,assign) NSInteger page;
@end

static NSString *homecompanyidendfity = @"homecompanyidendfity";


@implementation homecompanyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
      
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(notice:) name:@"homecaseSearch" object:nil];
      
    NSNotificationCenter * addcenter = [NSNotificationCenter defaultCenter];
    [addcenter addObserver:self selector:@selector(addressnotice:) name:@"homeaddress" object:nil];
    
}


-(void)addressnotice:(NSNotification *)sender
{
    NSDictionary *modelDic = sender.userInfo;
    self.cityId = [modelDic objectForKey:@"cityId"];
    self.countyId = [modelDic objectForKey:@"countyId"];
    self.provinceId = [modelDic objectForKey:@"provinceId"];
    [self.tableView.mj_header beginRefreshing];
}

-(void)notice:(NSNotification *)sender{
    NSLog(@"%@",sender);
    self.serchContent = [sender.userInfo objectForKey:@"search"];
    [self.tableView.mj_header beginRefreshing];
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



-(UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] init];
        if (ISIPHONEX) {
            self.tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT-180-getRectNavAndStatusHight-49-170);
        }
        else
        {
            self.tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT-180-getRectNavAndStatusHight-49-80);
        }
        _tableView.dataSource = self;
        _tableView.delegate = self;
         _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    companyCell *cell = [tableView dequeueReusableCellWithIdentifier:homecompanyidendfity];
    cell = [[companyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:homecompanyidendfity];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    companyViewController *vc = [companyViewController new];
//    companyModel *model = self.dataSource[indexPath.row];
//    vc.companyId = [NSString stringWithFormat:@"%ld",(long)model.customId];
//    [self.navigationController pushViewController:vc animated:true];
}

@end
