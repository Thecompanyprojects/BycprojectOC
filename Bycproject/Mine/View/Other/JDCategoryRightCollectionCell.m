//
//  JDCategoryRightCollectionCell.m
//  分类列表联动
//
//  Created by yifo on 2018/8/3.
//  Copyright © 2018年 yanhaiqiang. All rights reserved.
//

#import "JDCategoryRightCollectionCell.h"

@interface JDCategoryRightCell : UICollectionViewCell
@property (nonatomic,strong) UILabel *titleLab;
@end

@implementation JDCategoryRightCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.titleLab];
        [self setuplayout];
    }
    return self;
}

-(UILabel *)titleLab
{
    if(!_titleLab)
    {
        _titleLab = [UILabel new];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont systemFontOfSize:14];
        _titleLab.textColor = [UIColor darkGrayColor];
        _titleLab.layer.masksToBounds = YES;
        _titleLab.layer.cornerRadius = 10;
        _titleLab.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _titleLab.layer.borderWidth = 1;
    }
    return _titleLab;
}


-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(10);
        make.bottom.equalTo(weakSelf).with.offset(-10);
        make.left.equalTo(weakSelf).with.offset(10);
        make.right.equalTo(weakSelf).with.offset(-10);
    }];
}
@end


@interface JDCategoryRightCollectionCell ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UIButton *allBtn;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSString *titleStr;

@end

@implementation JDCategoryRightCollectionCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}
- (void)creatSubViews {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 5;
    flowLayout.minimumInteritemSpacing = 5;
    CGFloat width = WIDTH - 100;
    CGFloat height;
    if (isiPhoneX) {
        height = HEIGHT-88;
    }
    else
    {
        height = HEIGHT-64;
    }
    flowLayout.itemSize = CGSizeMake(width/2-4, width/4);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, width, height) collectionViewLayout:flowLayout];
    self.collectionView = collectionView;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:NSClassFromString(@"JDCategoryRightCell") forCellWithReuseIdentifier:@"JDCategoryRightCell"];
    [self addSubview:collectionView];
}

#pragma mark -UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JDCategoryRightCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JDCategoryRightCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.titleLab.text = self.sectionArray[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *titleStr = self.sectionArray[indexPath.item];
    NSInteger integer = [self getTypeWithTitle:titleStr];
    NSString *idstr = [NSString stringWithFormat:@"%ld",integer];
    NSDictionary *data = @{@"idstr":idstr,@"titleStr":titleStr};

    NSNotification * notice = [NSNotification notificationWithName:@"chooseDetal" object:nil userInfo:data];
    //发送消息
    [[NSNotificationCenter defaultCenter]postNotification:notice];
    
}



-(NSInteger)getTypeWithTitle:(NSString *)title {
    NSArray *titleArr = @[@"装修公司", @"成品定制", @"门窗",
                          @"瓷砖", @"品牌橱柜", @"油漆涂料",
                          @"墙布墙纸", @"暖通管道", @"地板",
                          @"软装馆", @"卫浴洁具", @"电器",
                          @"品牌衣柜", @"房屋中介", @"设计工作室",
                          @"家具沙发", @"石材", @"吊顶",
                          @"隔断背景墙", @"环保材料", @"装饰辅材",
                          @"五金日杂", @"冷暖净水", @"灯具开关",
                          @"监理公司", @"家纺布艺", @"智能家居",
                          @"软包纱窗", @"家政保洁", @"搬家运输",
                          @"瓷砖美缝", @"家居风水", @"绿植花卉",
                          @"艺术玻璃", @"机电工具", @"家居用品",
                          @"竹木材料", @"金属材料", @"消防器材",
                          @"办公家具", @"广告传媒", @"橡胶材料",
                          @"楼梯", @"空气治理", @"整装公司", @"新型装修", @"新型材料", @"新风系统", @"艺术字画", @"名人名画", @"钟表摆件", @"机器人", @"晾衣架"];
    NSArray *typeArr = @[@"1018", @"1035", @"1049",
                         @"1003", @"1004", @"1008",
                         @"1053", @"1037", @"1051",
                         @"1001", @"1002", @"1056",
                         @"1024", @"1020", @"1022",
                         @"1025", @"1050", @"1054",
                         @"1026", @"1041", @"1055",
                         @"1027", @"1042", @"1052",
                         @"1063", @"1062", @"1019",
                         @"1017", @"1013", @"1014",
                         @"1016", @"1044", @"1059",
                         @"1031", @"1045", @"1060",
                         @"1032", @"1046", @"1033",
                         @"1047", @"1034", @"1048",
                         @"1043", @"1015", @"1064", @"1065", @"1068", @"1075", @"1076", @"1077", @"1078", @"1079", @"1082"];
    NSInteger type = 0;
    for (int i = 0; i < titleArr.count; i++) {
        NSString *titleArrTitle = titleArr[i];
        if ([title isEqualToString:titleArrTitle]) {
            type = [typeArr[i] integerValue];
            return type;
        }
    }
    return 0;
}


- (void)setSectionTitle:(NSString *)sectionTitle {
    [self.collectionView reloadData];
}

- (void)setCount:(NSInteger)count {
    _count = count;
    [self.collectionView reloadData];
}

@end
