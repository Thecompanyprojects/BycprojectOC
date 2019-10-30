//
//  companyCell0.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/18.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "companyCell0.h"
#import "headImgModel.h"
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
        [self setscrolldata];
    }
    return self;
}

-(void)setscrolldata
{

    
    NSMutableArray *array = [NSMutableArray new];
    for (int i = 0; i<self.headImgs.count; i++) {
        headImgModel *model = [self.headImgs objectAtIndex:i];
        [array addObject:model.picUrl];
    }
    
    //采用网络图片
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.scrollView.imageURLStringsGroup = array;
    });
    
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
    }
    return _scrollView;
}

@end
