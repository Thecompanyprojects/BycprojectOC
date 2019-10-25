//
//  JDCategoryRightCollectionView.m
//  分类列表联动
//
//  Created by yifo on 2018/8/3.
//  Copyright © 2018年 yanhaiqiang. All rights reserved.
//

#import "JDCategoryRightCollectionView.h"
#import "JDCategoryRightCollectionCell.h"

@interface JDCategoryRightCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic,strong) NSArray *arrayDetailShop;
@end


@implementation JDCategoryRightCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self == [super initWithFrame:frame collectionViewLayout:layout]) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[JDCategoryRightCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return self;
}


-(NSArray *)arrayDetailShop {
    if (!_arrayDetailShop) {
        _arrayDetailShop = @[@[@"软装馆", @"设计工作室", @"家纺布艺", @"互联网+", @"其他"], @[@"瓷砖", @"卫浴洁具", @"品牌橱柜", @"品牌衣柜", @"五金日杂", @"墙布墙纸", @"门窗", @"地板", @"灯具开关", @"石材", @"吊顶", @"成品定制", @"环保材料", @"装饰辅材", @"隔断背景墙", @"橡胶材料", @"竹木材料", @"楼梯", @"冷暖净水", @"暖通管道", @"金属材料", @"艺术玻璃", @"油漆涂料", @"新型材料", @"互联网+", @"其他"], @[@"办公家具", @"电器", @"家具沙发", @"智能家居", @"机电工具", @"灯具开关", @"互联网+", @"其他"], @[@"监理公司", @"空气治理", @"广告传媒", @"搬家运输", @"家政保洁", @"软包纱窗", @"家居风水", @"瓷砖美缝", @"房屋中介", @"消防器材", @"互联网+", @"其他"], @[@"家居用品", @"晾衣架", @"绿植花卉", @"新风系统", @"家纺布艺", @"名人名画", @"艺术字画", @"机器人", @"钟表摆件", @"互联网+", @"其他"]];
    }
    return _arrayDetailShop;
}


#pragma mark -UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JDCategoryRightCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
   
    if (indexPath.row == 0) {
        NSArray *array = [self.arrayDetailShop objectAtIndex:0];
        cell.count = array.count;
        cell.sectionArray = [NSMutableArray array];
        cell.sectionArray = array.mutableCopy;
    }else if (indexPath.row == 1) {
        NSArray *array = [self.arrayDetailShop objectAtIndex:1];
        cell.count = array.count;
        cell.sectionArray = [NSMutableArray array];
        cell.sectionArray = array.mutableCopy;
    }else if (indexPath.row == 2) {
        NSArray *array = [self.arrayDetailShop objectAtIndex:2];
        cell.count = array.count;
        cell.sectionArray = [NSMutableArray array];
        cell.sectionArray = array.mutableCopy;
    }else if (indexPath.row == 3) {
        NSArray *array = [self.arrayDetailShop objectAtIndex:3];
        cell.count = array.count;
        cell.sectionArray = [NSMutableArray array];
        cell.sectionArray = array.mutableCopy;
    }else if (indexPath.row == 4) {
        NSArray *array = [self.arrayDetailShop objectAtIndex:4];
        cell.count = array.count;
        cell.sectionArray = [NSMutableArray array];
        cell.sectionArray = array.mutableCopy;
    }
    return cell;
}


@end
