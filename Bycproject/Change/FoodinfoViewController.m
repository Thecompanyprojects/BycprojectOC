//
//  FoodinfoViewController.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/12/14.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "FoodinfoViewController.h"
#import "foodinfoModel.h"
#import "foodReusableView.h"
#import "foodinfoCell.h"

@interface FoodinfoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) foodinfoModel *modeldic;;

@end

static NSString *foodinfoidentfity = @"foodinfoidentfity";
static NSString *foodinfohead = @"foodinfohead";


@implementation FoodinfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"商品详情";
    
    [self createUI];
    [self createInfofromweb];
}

-(void)createUI
{

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize =CGSizeMake(WIDTH/2-1, 250);
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    //设置headerView的尺寸大小
    layout.headerReferenceSize = CGSizeMake(WIDTH, WIDTH+140);
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 1, 0);
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[foodinfoCell class] forCellWithReuseIdentifier:foodinfoidentfity];
    [self.collectionView registerClass:[foodReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:foodinfohead];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

-(void)createInfofromweb
{
    
    self.dataSource = [NSMutableArray array];
    
    NSString *url = [BaseURL stringByAppendingFormat:@"%@", detailUrl];
    NSDictionary *para = @{@"id":self.foodId?:@""};
    [NetManager afPostRequest:url parms:para finished:^(id responseObj) {
        if ([[responseObj objectForKey:@"code"] intValue]==1000) {
            
            NSDictionary *data = [responseObj objectForKey:@"data"];
            NSArray *commodityList = [data objectForKey:@"list"];
            NSArray *array = [NSArray yy_modelArrayWithClass:[foodinfoModel class] json:commodityList];
            [self.dataSource addObjectsFromArray:array];
            self.modeldic = [foodinfoModel new];
            self.modeldic = [foodinfoModel yy_modelWithDictionary:responseObj[@"data"][@"model"]];
            [self.collectionView reloadData];
            
        }
        
    } failed:^(NSString *errorMsg) {
        
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
    foodinfoCell *cell = (foodinfoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:foodinfoidentfity forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    [cell setModel:self.dataSource[indexPath.item]];
    return cell;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FoodinfoViewController *vc = [FoodinfoViewController new];
    foodinfoModel *model = self.dataSource[indexPath.item];
    vc.foodId = [NSString stringWithFormat:@"%ld",model.Newid];
    [self.navigationController pushViewController:vc animated:YES];
}

//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    foodReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:foodinfohead forIndexPath:indexPath];
    headerView.model = self.modeldic;
    return headerView;
}

@end
