//
//  companyCell0.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/18.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "companyCell0.h"

@interface companyCell0()<SDCycleScrollViewDelegate>
@property (nonatomic,strong) SDCycleScrollView *scrollView;
@end

@implementation companyCell0

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.scrollView];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [weakSelf.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(17);
        make.top.equalTo(weakSelf).with.offset(12);
        make.height.mas_offset(187);
        make.centerX.equalTo(weakSelf);
    }];
}

-(SDCycleScrollView *)scrollView
{
    if(!_scrollView)
    {
        _scrollView  = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(17, 12, WIDTH-34, 187) imageNamesGroup:[NSArray new]];
        _scrollView.delegate = self;
        _scrollView.layer.masksToBounds = YES;
        _scrollView.layer.cornerRadius = 9;
        _scrollView.backgroundColor = [UIColor orangeColor];
    }
    return _scrollView;
}

@end
