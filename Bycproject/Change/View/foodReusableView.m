//
//  foodReusableView.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/12/14.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "foodReusableView.h"

@interface foodReusableView()<SDCycleScrollViewDelegate>
@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UILabel *priceLab;
@property (nonatomic,strong) UILabel *contentLab;
@end

@implementation foodReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.cycleScrollView];
        [self addSubview:self.nameLab];
        [self addSubview:self.priceLab];
        [self addSubview:self.contentLab];
        [self setuplayout];
    }
    return self;
}

- (void)setModel:(foodinfoModel *)model
{
    if (model.price.length!=0) {
        NSMutableArray *array = [NSMutableArray arrayWithObject:model.picture];
        if (array.count!=0) {
            //采用网络图片
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 self.cycleScrollView.imageURLStringsGroup = array;
             });
        }
        self.nameLab.text = model.name?:@"";
        self.priceLab.text = model.price?:@"";
    }
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.left.equalTo(weakSelf).with.offset(20);
        make.top.equalTo(weakSelf.cycleScrollView.mas_bottom).with.offset(10);
        
    }];
    [weakSelf.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.left.equalTo(weakSelf.nameLab);
        make.top.equalTo(weakSelf.nameLab.mas_bottom).with.offset(6);
    }];
    [weakSelf.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf).with.offset(-10);
        make.left.equalTo(weakSelf.priceLab);
    }];
}

#pragma mark - getters

-(SDCycleScrollView *)cycleScrollView
{
    if(!_cycleScrollView)
    {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, WIDTH, WIDTH) delegate:self placeholderImage:[UIImage imageNamed:@""]];
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _cycleScrollView.layer.masksToBounds = YES;
        _cycleScrollView.layer.cornerRadius = 2;
        _cycleScrollView.currentPageDotColor = [UIColor whiteColor];
        _cycleScrollView.backgroundColor = [UIColor whiteColor];
    }
    return _cycleScrollView;
}

-(UILabel *)nameLab
{
    if(!_nameLab)
    {
        _nameLab = [[UILabel alloc] init];
        _nameLab.font = [UIFont systemFontOfSize:20];
        _nameLab.textColor = [UIColor darkGrayColor];
        _nameLab.numberOfLines = 2;
        [_nameLab sizeToFit];
    }
    return _nameLab;
}

-(UILabel *)priceLab
{
    if(!_priceLab)
    {
        _priceLab = [[UILabel alloc] init];
        _priceLab.font = [UIFont systemFontOfSize:20];
        _priceLab.textColor = [UIColor lightGrayColor];
        
    }
    return _priceLab;
}

-(UILabel *)contentLab
{
    if(!_contentLab)
    {
        _contentLab = [[UILabel alloc] init];
        _contentLab.font = [UIFont systemFontOfSize:20];
        _contentLab.textColor = [UIColor darkGrayColor];
        _contentLab.text = @"推荐商品";
    }
    return _contentLab;
}




@end
