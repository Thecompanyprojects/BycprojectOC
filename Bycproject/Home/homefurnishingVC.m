//
//  homefurnishingVC.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/11/20.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "homefurnishingVC.h"
#import "changeCell.h"
#import "foodModel.h"

@interface homefurnishingVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,assign) NSInteger page;

@end

@implementation homefurnishingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"建材家居";
    
    [self createUI];
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 0;
        [self getdataFromwebWith:@"1"];
    }];
    [self.collectionView.mj_header beginRefreshing];
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self getdataFromwebWith:@"2"];
        self.page++;
    }];
}

-(void)getdataFromwebWith:(NSString *)str
{
    
    if ([str intValue]==1) {
        self.dataSource = [NSMutableArray array];
    }
    
    NSString *url = [BaseURL stringByAppendingFormat:@"%@", Homeindex];
    NSString *longitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"lng"]?:@"";
    NSString *latitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"lat"]?:@"";
    NSString *serchContent = @"";
    NSString *page = [NSString stringWithFormat:@"%ld",self.page];
    NSString *pageSize = @"30";
    NSString *needLocation = @"1";
    NSString *type = @"1";
    NSString *merchantType = @"";
    NSString *provinceId = @"";
    NSString *cityId = @"";
    NSString *countyId = @"";
    
    NSDictionary *params = @{@"longitude":longitude,@"latitude":latitude,@"serchContent":serchContent,@"page":page,@"pageSize":pageSize,@"needLocation":needLocation,@"type":type,@"merchantType":merchantType,@"provinceId":provinceId,@"cityId":cityId,@"countyId":countyId};
    [NetManager afPostRequest:url parms:params finished:^(id responseObj) {
        if ([[responseObj objectForKey:@"code"] intValue]==1000) {
            
            NSDictionary *data = [responseObj objectForKey:@"data"];
            NSArray *commodityList = [data objectForKey:@"commodityList"];
            NSArray *array = [NSArray yy_modelArrayWithClass:[foodModel class] json:commodityList];
            [self.dataSource addObjectsFromArray:array];
            [self.collectionView reloadData];
        }
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    } failed:^(NSString *errorMsg) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    }];
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
    changeCell *cell = (changeCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.model = self.dataSource[indexPath.item];
    return cell;
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    foodModel *model = self.dataSource[indexPath.item];
    if (model.customId==0) {
        return;
    }
    FoodinfoViewController *VC = [FoodinfoViewController new];
    VC.foodId = [NSString stringWithFormat:@"%ld",model.customId];
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)createUI
{

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize =CGSizeMake(WIDTH/2-1, 250);
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 1, 0);
        //2.初始化collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[changeCell class] forCellWithReuseIdentifier:@"cellId"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}


@end
