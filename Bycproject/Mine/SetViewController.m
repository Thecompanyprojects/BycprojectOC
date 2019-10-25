//
//  SetViewController.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/20.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "SetViewController.h"
#import "MineManager.h"
#import "changemineVC.h"
#import "LoginViewController.h"
#import "ForgetViewController.h"

@interface SetViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
    [self.view addSubview:self.tableView];
}

- (void)didMoveToParentViewController:(UIViewController*)parent{
    [super didMoveToParentViewController:parent];
    if(!parent){
        NSLog(@"页面pop成功了");
        if (self.refreshBlock) {
            self.refreshBlock(@"");
        }
    }
}

#pragma mark - getters

-(UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

#pragma mark -UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 4;
    }
    if (section==1) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setcell"];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"setcell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"898989"];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"898989"];
        if (indexPath.row==0) {
            cell.textLabel.text = @"个人信息";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.row==1) {
            cell.textLabel.text = @"账号安全";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.row==2) {
            cell.textLabel.text = @"清理缓存";
            cell.detailTextLabel.text = [MineManager getCachesSize];
        }
        if (indexPath.row==3) {
            cell.textLabel.text = @"版本更新";
            cell.detailTextLabel.text = @"1.0";
        }
        return cell;
    }
    if (indexPath.section==1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setcell2"];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"setcell2"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"898989"];
        cell.textLabel.text = @"退出登录";
        return cell;
    }
    return [UITableViewCell new];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 46*H_SCREEN;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==0) {
        UIView *foot = [UIView new];
        foot.frame = CGRectMake(0, 0, WIDTH, 12);
        foot.backgroundColor = [UIColor colorWithHexString:@"F2F2F2"];
        return foot;
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return 12;
    }
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            changemineVC *vc = [[changemineVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row==1) {
            ForgetViewController *VC =[[ForgetViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
        if (indexPath.row==2) {
            [MineManager removeCache];
            [self.tableView reloadData];
        }
        if (indexPath.row==3) {
            
        }
    }
    if (indexPath.section==1) {

        UIAlertController *control = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要退出登录吗" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"agencyId"];
            
            LoginViewController *lvc = [[LoginViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:lvc];
            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
            app.window.rootViewController = nav;
            
        }];
        [control addAction:action0];
        [control addAction:action1];
        [self presentViewController:control animated:YES completion:^{
            
        }];
        
    }

    
}


@end

