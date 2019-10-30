//
//  createshowView.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/31.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "createshowView.h"
#import "createshowviewCell.h"
#import "createshowModel.h"

@interface createshowView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UIView *alertView;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation createshowView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        /*下面代码的作用让视图没关闭之前只创建一次*/
        BOOL isHas = NO;
        for (UIView * view in [UIApplication sharedApplication].keyWindow.subviews) {
            if ([view isKindOfClass:[createshowView class]]) {
                isHas = YES;
                break;
            }
        }
        if (isHas) {
            return nil;
        }
        
        self.frame = [UIScreen mainScreen].bounds;
        self.alertView = [[UIView alloc]initWithFrame:CGRectMake(20, 88+60, WIDTH-40, 110)];
        self.userInteractionEnabled = YES;
        self.alertView.backgroundColor = [UIColor colorWithHexString:@"DEDEDE"];
        self.alertView.layer.cornerRadius=5.0;
        self.alertView.layer.masksToBounds=YES;
        self.alertView.userInteractionEnabled=YES;
        [self addSubview:self.alertView];
        [self showAnimationwith];
        
        [self setuplayout];
        [self.alertView addSubview:self.collectionView];
        [self getcompanytype];
    }
    return self;
}

-(void)getcompanytype
{
    self.dataSource = [NSMutableArray array];
    NSString *url = [BaseURL stringByAppendingFormat:@"%@", tplistUrl];
    [NetManager afPostRequest:url parms:[NSDictionary new] finished:^(id responseObj) {
        if ([[responseObj objectForKey:@"code"] intValue]==1000) {
            NSArray *array = [NSArray yy_modelArrayWithClass:[createshowModel class] json:responseObj[@"data"][@"list"]];
            [self.dataSource addObjectsFromArray:array];
        }
        [self.collectionView reloadData];
    } failed:^(NSString *errorMsg) {
        
    }];
}

-(void)setuplayout
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize =CGSizeMake((WIDTH-40)/3-6, 50);
    // 设置最小行间距
    layout.minimumLineSpacing = 1;
    // 设置垂直间距
    layout.minimumInteritemSpacing = 1;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 1, 0);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH-40, 130) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[createshowviewCell class] forCellWithReuseIdentifier:@"cellId"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

#pragma mark - getters

-(UIView *)alertView
{
    if(!_alertView)
    {
        _alertView = [[UIView alloc] init];
        
    }
    return _alertView;
}

-(void)showAnimationwith{
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.0f];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.alertView.alpha = 0;
    [UIView animateWithDuration:0.2 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5f];
        self.alertView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    createshowviewCell *cell = (createshowviewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithHexString:@"DEDEDE"];
    createshowModel *model = self.dataSource[indexPath.item];
    cell.titleLab.text = model.typeName?:@"";
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    createshowModel *model = self.dataSource[indexPath.item];
    NSDictionary *dic = @{@"name":model.typeName,@"typeNo":model.typeNo};
    if (self.sureClick) {
        self.sureClick(dic);
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self removeFromSuperview];
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch * touch = touches.anyObject;
    if ([touch.view isMemberOfClass:[self.collectionView class]]) {

    }
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
            [self removeFromSuperview];
        }];
    }

}


-(void)withSureClick:(sureBlock)block{
    _sureClick = block;
}


@end
