//
//  MineViewController.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/15.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "MineViewController.h"
#import "mineCell.h"
#import "mineinfoView.h"
#import "CreatecompanyVC.h"
#import "feedbackVC.h"
#import <Social/Social.h>
#import "CustomActivity.h"
#import "SetViewController.h"
#import "mineinfoVC.h"
#import "AgencyModel.h"
#import "companyViewController.h"

@interface MineViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *imageArray;
@property (nonatomic,strong) NSMutableArray *titleArray;
@property (nonatomic,strong) AgencyModel *model;
@property (nonatomic,assign) BOOL isCompany;
@property (nonatomic,copy) NSString *companyId;
@property (nonatomic,copy) NSString *companyName;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self vhl_setNavBarShadowImageHidden:YES];
    self.imageArray = [NSMutableArray arrayWithObjects:@"icon_shuom",@"icon_shoucang",@"icon_xiaoxi-1",@"icon_shezhi",@"icon_tuijian-1",@"icon_yijian",@"icon_kefu",@"icon_xiaoxi", nil];
    self.titleArray = [NSMutableArray arrayWithObjects:@"使用说明",@"我的收藏",@"系统消息",@"设置",@"推荐给朋友",@"意见反馈",@"在线客服",@"聊天消息", nil];
    [self creageUI];
    [self getdatafromweb];
    [self getmineCompanyinfo];
}

-(void)creageUI
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 200);
    layout.itemSize =CGSizeMake(WIDTH/4-20, WIDTH/4-20);
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 1, 0);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(22, 0, WIDTH-44, HEIGHT) collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[mineCell class] forCellWithReuseIdentifier:@"cellId"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
}

-(void)getdatafromweb
{
    NSString *url = [BaseURL stringByAppendingFormat:@"%@", getAgencyById];
    NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    [NetManager afPostRequest:url parms:@{@"phone":phone?:@""} finished:^(id responseObj) {
        
        if ([[responseObj objectForKey:@"code"] intValue]==1000) {
            
            NSDictionary *data = [responseObj objectForKey:@"agency"];
            self.model = [AgencyModel yy_modelWithDictionary:data];
            [self.collectionView reloadData];
        }
        
    } failed:^(NSString *errorMsg) {
        
    }];
}


-(void)getmineCompanyinfo
{
    NSString *url = [BaseURL stringByAppendingFormat:@"%@", findCompanyListUrl];
    NSString *agencyId = [[NSUserDefaults standardUserDefaults] objectForKey:@"agencyId"];
    NSDictionary *para = @{@"agencysId":agencyId};
    
    [NetManager afPostRequest:url parms:para finished:^(id responseObj) {
        if ([[responseObj objectForKey:@"code"] intValue]==1000) {
            self.isCompany = YES;
            self.companyId = [responseObj objectForKey:@"data"][@"companyId"]?:@"";
            self.companyName = [responseObj objectForKey:@"data"][@"companyName"]?:@"";
            [self.collectionView reloadData];
        }
        if ([[responseObj objectForKey:@"code"] intValue]==1002) {
            self.isCompany = NO;
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
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    mineCell *cell = (mineCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.img.image = [UIImage imageNamed:self.imageArray[indexPath.item]];
    cell.titleLab.text = self.titleArray[indexPath.item];
    if (indexPath.item==0) {
        [cell.img mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(26);
            make.height.mas_offset(27);
        }];
    }
    if (indexPath.item==1) {
          [cell.img mas_updateConstraints:^(MASConstraintMaker *make) {
              make.width.mas_offset(22);
              make.height.mas_offset(26);
          }];
    }
    if (indexPath.item==2) {
          [cell.img mas_updateConstraints:^(MASConstraintMaker *make) {
              make.width.mas_offset(22);
              make.height.mas_offset(25);
          }];
    }
    if (indexPath.item==3) {
          [cell.img mas_updateConstraints:^(MASConstraintMaker *make) {
              make.width.mas_offset(22);
              make.height.mas_offset(22);
          }];
    }
    if (indexPath.item==4) {
          [cell.img mas_updateConstraints:^(MASConstraintMaker *make) {
              make.width.mas_offset(22);
              make.height.mas_offset(24);
          }];
    }
    if (indexPath.item==5) {
          [cell.img mas_updateConstraints:^(MASConstraintMaker *make) {
              make.width.mas_offset(27);
              make.height.mas_offset(27);
          }];
    }
    if (indexPath.item==6) {
          [cell.img mas_updateConstraints:^(MASConstraintMaker *make) {
              make.width.mas_offset(21);
              make.height.mas_offset(21);
          }];
    }
    if (indexPath.item==7) {
          [cell.img mas_updateConstraints:^(MASConstraintMaker *make) {
              make.width.mas_offset(24);
              make.height.mas_offset(21);
          }];
    }
    return cell;
}


//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
    headerView.backgroundColor =[UIColor whiteColor];
    mineinfoView *info = [[mineinfoView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 130)];
    [info.iconImg sd_setImageWithURL:[NSURL URLWithString:self.model.photo] placeholderImage:[UIImage imageNamed:@"bg_TUXIANG"]];
    info.nameLab.text = self.model.trueName?:@"";
    [headerView addSubview:info];
    UIImageView *bgImg = [UIImageView new];
    [headerView addSubview:bgImg];
    bgImg.image = [UIImage imageNamed:@"bg_diban"];
    bgImg.frame = CGRectMake(0, 130, WIDTH, 80);
    
    info.userInteractionEnabled = true;
    UITapGestureRecognizer *infotap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(infoClick)];
    [info addGestureRecognizer:infotap];
    
    UILabel *companyLab = [UILabel new];
    [bgImg addSubview:companyLab];
    companyLab.textColor = [UIColor colorWithHexString:@"#2B2B2B"];
    companyLab.font = [UIFont systemFontOfSize:17];
    
    if (self.isCompany) {
        companyLab.text = self.companyName;
    }
    else
    {
        companyLab.text = @"创建我的公司";
    }
    [companyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImg).with.offset(23);
        make.top.equalTo(bgImg).with.offset(10);
        make.centerX.equalTo(bgImg);
    }];
    
    UILabel *contentLab = [UILabel new];
    [bgImg addSubview:contentLab];
    contentLab.textColor = [UIColor colorWithHexString:@"#7c7c7c"];
    contentLab.font = [UIFont systemFontOfSize:13];
//
    if (!self.isCompany) {
        contentLab.text = @"请创建您的公司";
    }
    [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImg).with.offset(23);
        make.top.equalTo(companyLab.mas_bottom).with.offset(7);
        make.centerX.equalTo(bgImg);
    }];
    bgImg.userInteractionEnabled = true;
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [bgImg addGestureRecognizer:tapGesturRecognizer];
    return headerView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        [MBProgressHUD showMessage:@"敬请期待"];
    }
    if (indexPath.row==3) {
        SetViewController *vc = [SetViewController new];
        vc.refreshBlock = ^(NSString * _Nonnull name) {
            [self getdatafromweb];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row==4) {
        
        NSString *appid = @"1484186100";
        NSString *url = [NSString stringWithFormat:@"https://apps.apple.com/cn/app/qq/id%@",appid];
        
        NSString *shareText = @"帮一程";
        UIImage *shareImage = [UIImage imageNamed:@"AppIcon"];
        
        NSURL *shareUrl = [NSURL URLWithString:url];
        NSArray *activityItemsArray = @[shareText,shareImage,shareUrl];

        CustomActivity *customActivity = [[CustomActivity alloc]initWithTitle:shareText ActivityImage:[UIImage imageNamed:@"custom.png"] URL:shareUrl ActivityType:@"Custom"];
        NSArray *activityArray = @[customActivity];
        
        UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItemsArray applicationActivities:activityArray];
        activityVC.modalInPopover = YES;
        
        UIActivityViewControllerCompletionWithItemsHandler itemsBlock = ^(UIActivityType __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
                 NSLog(@"activityType == %@",activityType);
                 if (completed == YES) {
                     NSLog(@"completed");
                 }else{
                     NSLog(@"cancel");
                 }
             };
        activityVC.completionWithItemsHandler = itemsBlock;
        [self presentViewController:activityVC animated:YES completion:nil];
        
    }
    if (indexPath.item==5) {
        feedbackVC *vc = [feedbackVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)tapAction:(id)tap
{
    if (self.isCompany) {
        companyViewController *vc = [companyViewController new];
        vc.companyId = self.companyId;
        vc.isChange = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        CreatecompanyVC *vc = [CreatecompanyVC new];
        vc.successBlock = ^{
            [self getmineCompanyinfo];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)infoClick
{
    mineinfoVC *vc = [mineinfoVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
