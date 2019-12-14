//
//  homeeffectVC.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/16.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "homeeffectVC.h"
#import "effectCell.h"
#import "effectModel.h"

@interface homeeffectVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *mainCollectionView;
}
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,assign) NSInteger page;
@end

@implementation homeeffectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"商品";

    [self createUI];
    
    mainCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
         self.page = 0;
         [self getdataFromwebWith:@"1"];
     }];
     [mainCollectionView.mj_header beginRefreshing];
     
     mainCollectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
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
    [mainCollectionView.mj_header beginRefreshing];
}

-(void)notice:(NSNotification *)sender{
    NSLog(@"%@",sender);
    self.serchContent = [sender.userInfo objectForKey:@"search"];
    [mainCollectionView.mj_header beginRefreshing];
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
    NSString *type = @"4";
    NSString *merchantType = @"";
    NSString *provinceId = self.provinceId.copy?:@"";
    NSString *cityId = self.cityId.copy?:@"";
    NSString *countyId = self.countyId.copy?:@"";
    
    NSDictionary *params = @{@"longitude":longitude,@"latitude":latitude,@"serchContent":serchContent,@"page":page,@"pageSize":pageSize,@"needLocation":needLocation,@"type":type,@"merchantType":merchantType,@"provinceId":provinceId,@"cityId":cityId,@"countyId":countyId};
    [NetManager afPostRequest:url parms:params finished:^(id responseObj) {
        if ([[responseObj objectForKey:@"code"] intValue]==1000) {
            
            NSDictionary *data = [responseObj objectForKey:@"data"];
            NSArray *commodityList = [data objectForKey:@"commodityList"];
            NSArray *array = [NSArray yy_modelArrayWithClass:[effectModel class] json:commodityList];
            [self.dataSource addObjectsFromArray:array];
            [self->mainCollectionView reloadData];
        }
        [self->mainCollectionView.mj_header endRefreshing];
        [self->mainCollectionView.mj_footer endRefreshing];
    } failed:^(NSString *errorMsg) {
        [self->mainCollectionView.mj_header endRefreshing];
        [self->mainCollectionView.mj_footer endRefreshing];
    }];
}



-(void)createUI
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize =CGSizeMake(WIDTH/2-2, 240);
    // 设置最小行间距
    layout.minimumLineSpacing = 1;
    // 设置垂直间距
    layout.minimumInteritemSpacing = 1;
    mainCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 1, 0);
    CGRect rect;
    if (ISIPHONEX) {
        rect = CGRectMake(0, 0, WIDTH, HEIGHT-180-getRectNavAndStatusHight-49-170);
    }
    else
    {
        rect = CGRectMake(0, 0, WIDTH, HEIGHT-180-getRectNavAndStatusHight-49-80);
    }
    mainCollectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
    [self.view addSubview:mainCollectionView];
    mainCollectionView.backgroundColor = [UIColor clearColor];
    [mainCollectionView registerClass:[effectCell class] forCellWithReuseIdentifier:@"cellId"];
    mainCollectionView.delegate = self;
    mainCollectionView.dataSource = self;
}

#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count?:0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    effectCell *cell = (effectCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.model = self.dataSource[indexPath.item];
    return cell;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
