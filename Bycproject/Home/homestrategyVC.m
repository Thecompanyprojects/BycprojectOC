//
//  homestrategyVC.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/16.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "homestrategyVC.h"
#import "strategyCell.h"

@interface homestrategyVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;

@end

static NSString *homestrategyidendfity = @"homestrategyidendfity";


@implementation homestrategyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
}


-(UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] init];
        if (ISIPHONEX) {
            self.tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT-180-getRectNavAndStatusHight-49-170);
        }
        else
        {
            self.tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT-180-getRectNavAndStatusHight-49-80);
        }
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    strategyCell *cell = [tableView dequeueReusableCellWithIdentifier:homestrategyidendfity];
    cell = [[strategyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:homestrategyidendfity];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

@end
