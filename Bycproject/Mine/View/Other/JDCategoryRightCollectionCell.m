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
    cell.titleLab.text = @"公司类别";
    return cell;
}

- (void)setSectionTitle:(NSString *)sectionTitle {
    self.titleStr = sectionTitle;
    [self.collectionView reloadData];
}

- (void)setCount:(NSInteger)count {
    _count = count;
    [self.collectionView reloadData];
}

@end
