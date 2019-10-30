//
//  DetailViewController.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/24.
//  Copyright © 2019 wangjungang. All rights reserved.
//


#import "DetailViewController.h"
#import "JDCategoryLeftTabelView.h"
#import "JDCategoryRightCollectionView.h"

/** 屏幕宽高 */
#define KScreenWidth [[UIScreen mainScreen]bounds].size.width
#define KScreenHeight [[UIScreen mainScreen]bounds].size.height


/**屏幕适配*/
#define iPhone6Adaptive_width(a) (CGFloat)a * KScreenWidth / 375.0

#define NavigateHeight (KScreenHeight == 812.0 ? 88 : 64)


@interface DetailViewController ()<UIScrollViewDelegate, UICollectionViewDelegate>
@property (nonatomic, strong) JDCategoryLeftTabelView *leftView;
@property (nonatomic, strong) JDCategoryRightCollectionView *rightView;
@property (nonatomic, assign) CGFloat lastContentOffset;
@property (nonatomic, assign) BOOL didEndDecelerating;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店铺类别";
    [self setupSubViews];
    
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(notice:) name:@"chooseDetal" object:nil];
}

-(void)notice:(NSNotification *)sender{
    NSLog(@"%@",sender);
    NSDictionary *dic = sender.userInfo;
    if (self.refreshBlock) {
        self.refreshBlock(dic);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


/**
 *思路1
 *使用CollectionView,每个cell添加一个collectionView
 */
#pragma mark -------UI设置-------
- (void)setupSubViews {
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    JDCategoryLeftTabelView *leftView = [[JDCategoryLeftTabelView alloc] initWithFrame:CGRectMake(0, 0, 100, self.view.bounds.size.height) style:UITableViewStylePlain];
    self.leftView = leftView;
    [self.view addSubview:leftView];
    __weak typeof(self) weakSelf = self;
    [leftView setCellSelectedBlock:^(NSIndexPath *indexPath) {
        [weakSelf.rightView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
    }];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake(KScreenWidth - 100, KScreenHeight - NavigateHeight);
    
    JDCategoryRightCollectionView *rightView = [[JDCategoryRightCollectionView alloc] initWithFrame:CGRectMake(101, 0, KScreenWidth - 101, KScreenHeight - NavigateHeight) collectionViewLayout:flowLayout];
    self.rightView = rightView;
    rightView.delegate = self;
    rightView.pagingEnabled = YES;
    [self.view addSubview:rightView];
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.lastContentOffset = scrollView.contentOffset.y;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.didEndDecelerating = YES;
    // 调用方法A，传scrollView.contentOffset
    [self scrollViewWithScrollView:scrollView];
    NSLog(@"停止滑动");
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"%f", offsetY);
    CGFloat height = self.rightView.height;
    NSLog(@"高度%f", height);
    NSInteger index = offsetY/height;
    self.leftView.selectedRow = index;
}
- (void)scrollViewWithScrollView:(UIScrollView *)scrollView {
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
//    NSLog(@"%f", offsetY);
    if (offsetY < _lastContentOffset) {
//        NSLog(@"上");
        
    }else {
//        NSLog(@"下");
    }
}
@end
