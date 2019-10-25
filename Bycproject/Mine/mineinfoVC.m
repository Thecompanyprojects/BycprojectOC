//
//  mineinfoVC.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/21.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "mineinfoVC.h"
#import "AgencyModel.h"

@interface mineinfoVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) AgencyModel *model;
@end

@implementation mineinfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人资料";
    [self.view addSubview:self.tableView];
    [self getdatafromweb];
}

-(void)getdatafromweb
{
    NSString *url = [BaseURL stringByAppendingFormat:@"%@", getAgencyById];
    NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    [NetManager afPostRequest:url parms:@{@"phone":phone?:@""} finished:^(id responseObj) {
        if ([[responseObj objectForKey:@"code"] intValue]==1000) {
            NSDictionary *data = [responseObj objectForKey:@"agency"];
            self.model = [AgencyModel yy_modelWithDictionary:data];
            self.model.agencyBirthday = [self getTimeFromTimestampwith:self.model.agencyBirthday];
            [self.tableView reloadData];
        }
    } failed:^(NSString *errorMsg) {
        
    }];
}

#pragma mark ---- 将时间戳转换成时间

- (NSString *)getTimeFromTimestampwith:(NSString *)timeStr{
    //将对象类型的时间转换为NSDate类型
    double time = [timeStr doubleValue]/1000;
    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:time];
    //设置时间格式
    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    //将时间转换为字符串
    NSString *timetr = [formatter stringFromDate:myDate];
    return timetr;
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"minecell0"];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"minecell0"];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"333333"];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"898989"];
        cell.textLabel.text = @"头像";
        UIImageView *headImg = [UIImageView new];
        [cell addSubview:headImg];
        headImg.frame = CGRectMake(WIDTH-15-48, 70*H_SCREEN/2-24, 48, 48);
        headImg.layer.masksToBounds = YES;
        headImg.layer.cornerRadius =24;
//        NSString *headImgs = [[NSUserDefaults standardUserDefaults] objectForKey:@"headurl"];
//        [headImg sd_setImageWithURL:[NSURL URLWithString:headImgs] placeholderImage:[UIImage imageNamed:@"bg_TUXIANG"]];
        [headImg sd_setImageWithURL:[NSURL URLWithString:self.model.photo] placeholderImage:[UIImage imageNamed:@"bg_TUXIANG"]];
        return cell;
    }
    if (indexPath.row==1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"minecell1"];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"minecell1"];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"333333"];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"898989"];
        cell.textLabel.text = @"昵称";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.text = self.model.trueName?:@"";
        return cell;

    }
    if (indexPath.row==2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"minecell2"];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"minecell2"];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"333333"];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"898989"];
        cell.textLabel.text = @"性别";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if ([self.model.gender intValue]==1) {
            cell.detailTextLabel.text = @"男";
        }
        else
        {
            cell.detailTextLabel.text = @"女";
        }
        return cell;
    }
    if (indexPath.row==3) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"minecell3"];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"minecell3"];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"333333"];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"898989"];
        cell.textLabel.text = @"生日";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.text = self.model.agencyBirthday?:@"";
        return cell;

    }
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 70*H_SCREEN;
    }
    if (indexPath.row==1||indexPath.row==2||indexPath.row==3) {
        return 46*H_SCREEN;
        
    }
    return 0.01f;
}

@end
