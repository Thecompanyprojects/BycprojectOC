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
#import "foodModel.h"
#import "changeinfoVC.h"


@interface ChangeViewController ()<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIView *navTitleView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,copy) NSString *serchContent;
@property (nonatomic,copy) NSString *typeStr;
@property (nonatomic,copy) NSString *titleStr;

@end

@implementation ChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self vhl_setNavBarShadowImageHidden:YES];
    // Do any additional setup after loading the view.
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
    
    NSString *url = [BaseURL stringByAppendingFormat:@"%@", @"api/byc/goods/list.do"];
    NSString *type = @"0";
    NSDictionary *para = @{@"type":type};
    [NetManager afPostRequest:url parms:para finished:^(id responseObj) {
        if ([[responseObj objectForKey:@"code"] intValue]==1000) {
            
            NSDictionary *data = [responseObj objectForKey:@"data"];
            NSArray *commodityList = [data objectForKey:@"list"];
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
    headmenuView *view5 = [headmenuView new];
    headmenuView *view6 = [headmenuView new];
    headmenuView *view7 = [headmenuView new];
   
    
    [headerView addSubview:view0];
    [headerView addSubview:view1];
    [headerView addSubview:view2];
    [headerView addSubview:view3];
    [headerView addSubview:view4];
    [headerView addSubview:view5];
    [headerView addSubview:view6];
    [headerView addSubview:view7];
    
    [view0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView);
        make.width.mas_offset(WIDTH/4);
        make.height.mas_offset(80);
        make.left.equalTo(headerView);
    }];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView);
        make.width.mas_offset(WIDTH/4);
        make.height.mas_offset(80);
        make.left.equalTo(view0.mas_right);
    }];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView);
        make.width.mas_offset(WIDTH/4);
        make.height.mas_offset(80);
        make.left.equalTo(view1.mas_right);
    }];
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView);
        make.width.mas_offset(WIDTH/4);
        make.height.mas_offset(80);
        make.left.equalTo(view2.mas_right);
    }];
    [view4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view0.mas_bottom);
        make.width.mas_offset(WIDTH/4);
        make.height.mas_offset(80);
        make.left.equalTo(headerView);
    }];
    [view5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view4);
        make.width.mas_offset(WIDTH/4);
        make.height.mas_offset(80);
        make.left.equalTo(view4.mas_right);
    }];
    [view6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view4);
        make.width.mas_offset(WIDTH/4);
        make.height.mas_offset(80);
        make.left.equalTo(view5.mas_right);
    }];
    [view7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view4);
        make.width.mas_offset(WIDTH/4);
        make.height.mas_offset(80);
        make.left.equalTo(view6.mas_right);
    }];
    
    view0.img.image = [UIImage imageNamed:@"组12"];
    view1.img.image = [UIImage imageNamed:@"组13"];
    view2.img.image = [UIImage imageNamed:@"组14"];
    view3.img.image = [UIImage imageNamed:@"组16"];
    view4.img.image = [UIImage imageNamed:@"组15"];
    view5.img.image = [UIImage imageNamed:@"组19"];
    view6.img.image = [UIImage imageNamed:@"组18"];
    view7.img.image = [UIImage imageNamed:@"组17"];
    
    view0.nameLab.text = @"办公家具";
    view1.nameLab.text = @"电器";
    view2.nameLab.text = @"机电工具";
    view3.nameLab.text = @"灯具开关";
    view4.nameLab.text = @"门窗";
    view5.nameLab.text = @"地板";
    view6.nameLab.text = @"吊顶";
    view7.nameLab.text = @"卫浴厨具";
    
    UITapGestureRecognizer * tapGesturRecognizer0 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction0)];
    [view0 addGestureRecognizer:tapGesturRecognizer0];
    UITapGestureRecognizer * tapGesturRecognizer1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction1)];
    [view1 addGestureRecognizer:tapGesturRecognizer1];
    UITapGestureRecognizer * tapGesturRecognizer2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction2)];
    [view2 addGestureRecognizer:tapGesturRecognizer2];
    UITapGestureRecognizer * tapGesturRecognizer3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction3)];
    [view3 addGestureRecognizer:tapGesturRecognizer3];
    UITapGestureRecognizer * tapGesturRecognizer4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction4)];
    [view4 addGestureRecognizer:tapGesturRecognizer4];
    UITapGestureRecognizer * tapGesturRecognizer5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction5)];
    [view5 addGestureRecognizer:tapGesturRecognizer5];
    UITapGestureRecognizer * tapGesturRecognizer6 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction6)];
    [view6 addGestureRecognizer:tapGesturRecognizer6];
    UITapGestureRecognizer * tapGesturRecognizer7 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction7)];
    [view7 addGestureRecognizer:tapGesturRecognizer7];
    
    return headerView;
}

#pragma mark - 跳转页面

-(void)tapAction0
{
    self.titleStr = @"办公家具";
    self.typeStr = @"1";
    [self choosetapAction];
}

-(void)tapAction1
{
    self.titleStr = @"电器";
    self.typeStr = @"2";
    [self choosetapAction];
}

-(void)tapAction2
{
    self.titleStr = @"机电工具";
    self.typeStr = @"3";
    [self choosetapAction];
}

-(void)tapAction3
{
    self.titleStr = @"灯具开关";
    self.typeStr = @"4";
    [self choosetapAction];
}

-(void)tapAction4
{
    self.titleStr = @"门窗";
    self.typeStr = @"5";
    [self choosetapAction];
}

-(void)tapAction5
{
    self.titleStr = @"地板";
    self.typeStr = @"6";
    [self choosetapAction];
}

-(void)tapAction6
{
    self.titleStr = @"吊顶";
    self.typeStr = @"7";
    [self choosetapAction];
}

-(void)tapAction7
{
    self.titleStr = @"卫浴厨具";
    self.typeStr = @"8";
    [self choosetapAction];
}

-(void)choosetapAction
{
    changeinfoVC *vc = [changeinfoVC new];
    vc.title = self.titleStr?:@"";
    vc.type = self.typeStr?:@"";
    [self.navigationController pushViewController:vc animated:YES];
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FoodinfoViewController *VC = [FoodinfoViewController new];
    foodModel *model = self.dataSource[indexPath.item];
    VC.foodId = [NSString stringWithFormat:@"%ld",model.customId];
    [self.navigationController pushViewController:VC animated:YES];
}

-(UIView *)navTitleView
{
    if(!_navTitleView)
    {
        _navTitleView = [UIView new];
        //_navTitleView.backgroundColor = [UIColor colorWithHexString:@"F3F3F3"];
        _navTitleView.backgroundColor = [UIColor whiteColor];
        if (@available(iOS 11.0, *)){
            _navTitleView.translatesAutoresizingMaskIntoConstraints = NO;
        }
        
        UIView *bgView = [UIView new];
        bgView.backgroundColor = [UIColor colorWithHexString:@"F3F3F3"];
        [_navTitleView addSubview:bgView];
        bgView.frame = CGRectMake(0, 3, WIDTH-20, 44);
        
        
        UITextField *search = [[UITextField alloc] initWithFrame:CGRectMake(40, 0, WIDTH-100, 44)];
        search.backgroundColor = [UIColor colorWithHexString:@"F3F3F3"];
        search.delegate = self;

        UIImageView *leftimg = [[UIImageView alloc] init];
        [bgView addSubview:leftimg];
        leftimg.image = [UIImage imageNamed:@"icon_sousuo"];
        [leftimg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(bgView);
            make.left.equalTo(bgView).with.offset(13);
            make.width.mas_offset(18);
            make.height.mas_offset(18);
        }];
        UIImageView *rightimg = [[UIImageView alloc] init];
        [bgView addSubview:rightimg];
        rightimg.image = [UIImage imageNamed:@"icon_yuy"];
        [rightimg mas_makeConstraints:^(MASConstraintMaker *make) {
             make.width.mas_offset(12);
             make.height.mas_offset(18);
             make.right.equalTo(bgView).with.offset(-13);
             make.centerY.equalTo(bgView);
        }];
        
        [bgView addSubview:search];
        
    }
    return _navTitleView;
}


-(void)createUI
{
    self.navigationItem.titleView = self.navTitleView;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 180);
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    self.serchContent = textField.text?:@"";
    [self.collectionView.mj_header beginRefreshing];
    return YES;
}

@end
