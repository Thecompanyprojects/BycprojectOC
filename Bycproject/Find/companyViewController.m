//
//  companyViewController.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/18.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "companyViewController.h"
#import "companyCell0.h"
#import "companyCell1.h"
#import "companyCell2.h"
#import "companyCell4.h"


@interface companyViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@end

static NSString *companyident0 = @"companyident0";
static NSString *companyident1 = @"companyident1";
static NSString *companyident2 = @"companyident2";
static NSString *companyident3 = @"companyident3";
static NSString *companyident4 = @"companyident4";

@implementation companyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"黄页";
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
}

-(UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
        _tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 5;
    }
    if (section==1) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            companyCell0 *cell = [tableView dequeueReusableCellWithIdentifier:companyident0];
            cell = [[companyCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:companyident0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        if (indexPath.row==1) {
            companyCell1 *cell = [tableView dequeueReusableCellWithIdentifier:companyident1];
            cell = [[companyCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:companyident1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        if (indexPath.row==2) {
            companyCell2 *cell = [tableView dequeueReusableCellWithIdentifier:companyident2];
            cell = [[companyCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:companyident2];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLab.text = @"服务范围";
            cell.leftImg.image = [UIImage imageNamed:@"fuwu2"];
            cell.contentLab.text = @"商业住宅 别墅 酒店 KTV会所等高中抵挡装修 免费设计商业住宅 别墅 酒店 KTV会所等高中抵挡装修 免费设计商业住宅 别墅 酒店 KTV会所等高中抵挡装修 免费设计";
            return cell;
         }
        if (indexPath.row==3) {
            companyCell4 *cell = [tableView dequeueReusableCellWithIdentifier:companyident3];
            cell = [[companyCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:companyident3];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.leftImg.image = [UIImage imageNamed:@"fuwu2"];
            cell.titleLab.text = @"companyident3";
            return cell;
        }
        if (indexPath.row==4) {
             companyCell4 *cell = [tableView dequeueReusableCellWithIdentifier:companyident3];
             cell = [[companyCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:companyident3];
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
             cell.leftImg.image = [UIImage imageNamed:@"tel"];
             cell.titleLab.text = @"155109228737";
             return cell;
        }
    }
    if (indexPath.section==1) {
        companyCell2 *cell = [tableView dequeueReusableCellWithIdentifier:companyident4];
        cell = [[companyCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:companyident4];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLab.text = @"公司简介";
        cell.leftImg.image = [UIImage imageNamed:@"gongsiguanli"];
        cell.contentLab.text = @"商业住宅 别墅 酒店 KTV会所等高中抵挡装修 免费设计商业住宅 别墅 酒店 KTV会所等高中抵挡装修 免费设计商业住宅 别墅 酒店 KTV会所等高中抵挡装修 免费设计";
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 187+24;
        }
        if (indexPath.row==1) {
            return 90;
        }
        if (indexPath.row==2||indexPath.row==3||indexPath.row==4) {
            return [self cellHeightForIndexPath:indexPath cellContentViewWidth:WIDTH tableView:tableView];
        }

    }
    if (indexPath.section==1) {
        return [self cellHeightForIndexPath:indexPath cellContentViewWidth:WIDTH tableView:tableView];
    }
    return 0.01f;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return 12;
    }
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section==0) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 12)];
        line.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
        return line;
    }
    return nil;
};

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==4) {
        NSMutableString  *str = [[NSMutableString alloc] initWithFormat:@"tel:%@",@"15510922836"];
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:nil];
        } else {
            // Fallback on earlier versions
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
    }
}

@end
