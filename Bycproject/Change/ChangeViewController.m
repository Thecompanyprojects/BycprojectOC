//
//  ChangeViewController.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/15.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "ChangeViewController.h"
#import "changeCell.h"
#import "headmenuView.h"

@interface ChangeViewController ()<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *collectionView;
@end

@implementation ChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
    
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
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    changeCell *cell = (changeCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
}

//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
    headerView.backgroundColor =[UIColor whiteColor];
    
    headmenuView *view0 = [headmenuView new];
    headmenuView *view1 = [headmenuView new];
    headmenuView *view2 = [headmenuView new];
    headmenuView *view3 = [headmenuView new];
    headmenuView *view4 = [headmenuView new];
    [headerView addSubview:view0];
    [headerView addSubview:view1];
    [headerView addSubview:view2];
    [headerView addSubview:view3];
    [headerView addSubview:view4];
    
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView);
        make.width.mas_offset(WIDTH/5-2);
        make.height.mas_offset(80);
        make.centerX.equalTo(headerView);
    }];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view2);
        make.width.mas_offset(WIDTH/5-2);
        make.height.mas_offset(80);
        make.right.equalTo(view2.mas_left);
    }];
    [view0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view2);
        make.width.mas_offset(WIDTH/5-2);
        make.height.mas_offset(80);
        make.right.equalTo(view1.mas_left);
    }];
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view2);
        make.width.mas_offset(WIDTH/5-2);
        make.height.mas_offset(80);
        make.left.equalTo(view2.mas_right);
    }];
    [view4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view2);
        make.width.mas_offset(WIDTH/5-2);
        make.height.mas_offset(80);
        make.left.equalTo(view3.mas_right);
    }];

    view0.img.image = [UIImage imageNamed:@"change1"];
    view1.img.image = [UIImage imageNamed:@"change2"];
    view2.img.image = [UIImage imageNamed:@"change3"];
    view3.img.image = [UIImage imageNamed:@"change4"];
    view4.img.image = [UIImage imageNamed:@"change5"];
    view0.nameLab.text = @"软装硬装";
    view1.nameLab.text = @"主材辅材";
    view2.nameLab.text = @"家具电器";
    view3.nameLab.text = @"配套服务";
    view4.nameLab.text = @"家具生活";
    return headerView;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}


-(void)createUI
{
    UIView *navTitleView = [[UIView alloc] init];
    navTitleView.backgroundColor = [UIColor colorWithHexString:@"F3F3F3"];

    UITextField *search = [[UITextField alloc] initWithFrame:CGRectMake(40, 0, WIDTH-80, 44)];
    search.backgroundColor = [UIColor colorWithHexString:@"F3F3F3"];
    search.delegate = self;
    
    UIImageView *leftimg = [[UIImageView alloc] init];
    [navTitleView addSubview:leftimg];
    leftimg.image = [UIImage imageNamed:@"icon_sousuo"];
    [leftimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(navTitleView);
        make.left.equalTo(navTitleView).with.offset(13);
        make.width.mas_offset(18);
        make.height.mas_offset(18);
    }];
    UIImageView *rightimg = [[UIImageView alloc] init];
    [navTitleView addSubview:rightimg];
    rightimg.image = [UIImage imageNamed:@"icon_yuy"];
    [rightimg mas_makeConstraints:^(MASConstraintMaker *make) {
         make.width.mas_offset(12);
         make.height.mas_offset(18);
         make.right.equalTo(navTitleView).with.offset(-13);
         make.centerY.equalTo(navTitleView);
    }];
    
    [navTitleView addSubview:search];
    self.navigationItem.titleView = navTitleView;
    if (@available(iOS 11.0, *)) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [navTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.bottom.right.mas_equalTo(0);
            }];
        });
    }
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 100);
    layout.itemSize =CGSizeMake(WIDTH/2-1, 250);
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 1, 0);
        //2.初始化collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[changeCell class] forCellWithReuseIdentifier:@"cellId"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}


@end
