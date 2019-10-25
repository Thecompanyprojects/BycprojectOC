//
//  changemineVC.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/24.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "changemineVC.h"
#import "AgencyModel.h"
#import "GYDateSimpleSheetView.h"
#import "changenameVC.h"


@interface changemineVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) AgencyModel *model;

@end

@implementation changemineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改个人资料";
    [self.view addSubview:self.tableView];
    [self getdatafromweb];
    [self createButton];
}

-(void)createButton{
    UIButton * areaButton = [[UIButton alloc] initWithFrame:CGRectMake(16, 36, 10, 14)];
    [areaButton setImage:[UIImage imageNamed:@"icon_zuo"] forState:UIControlStateNormal];
    [areaButton addTarget:self action:@selector(backButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:areaButton];
    if (@available(iOS 11.0, *)) {
        leftBarButtonItem.customView.frame = CGRectMake(0, 0, 30, 44);
    }
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UIButton *submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(16, 36, 50, 40)];
    [submitBtn setTitle:@"确定" forState:normal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [submitBtn setTitleColor:[UIColor blackColor] forState:normal];
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:submitBtn];
    if (@available(iOS 11.0, *)) {
        rightBarButtonItem.customView.frame = CGRectMake(0, 0, 30, 44);
    }
    [submitBtn addTarget:self action:@selector(submitbtnclick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

-(void)backButtonOnClick
{
    [self.navigationController popViewControllerAnimated:YES];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        [self chooseImgs];
    }
    if (indexPath.row==1) {
        changenameVC *VC = [changenameVC new];
        VC.nameStr = self.model.trueName?:@"";
        VC.refreshBlock = ^(NSString * _Nonnull name) {
            self.model.trueName = name.copy;
            [self.tableView reloadData];
        };
        [self.navigationController pushViewController:VC animated:YES];
    }
    if (indexPath.row==2) {
        UIAlertController *control = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.model.gender = @"1";
            [self.tableView reloadData];
        }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.model.gender = @"2";
            [self.tableView reloadData];
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [control addAction:action0];
        [control addAction:action1];
        [control addAction:action2];
        [self presentViewController:control animated:YES completion:^{
            
        }];
    }
    if (indexPath.row==3) {
        NSDate *chooseDate = [NSDate dateByStr:self.model.agencyBirthday format:kSKDateFormatTypeYYYYMMDD] ;
        NSDate *defaultDate = [NSDate dateByStr:@"1990-01-01" format:kSKDateFormatTypeYYYYMMDD]; //[NSDate date];//默认为当前时间。
        NSDate * selectDate = chooseDate?:defaultDate;
        NSDate *dateNow = [NSDate date];
        NSString* nowStr = [NSString stringWithFormat:@"%04lu-%02lu-%02lu 00:00:00",(unsigned long)[dateNow year], (unsigned long)[dateNow month], (unsigned long)[dateNow day]];
        NSDate *maxDate = [NSDate dateByStr:nowStr format:kSKDateFormatTypeYYYYMMDDHHMMSS];
        NSDate *minDate = [NSDate dateByStr:@"1980-01-01" format:kSKDateFormatTypeYYYYMMDD];
        NSString *endDate = nil;
        __weak typeof(self) weakSelf = self;
        GYDateSimpleSheetView *datePicker =  [[GYDateSimpleSheetView alloc]initDatePickerMode:UIDatePickerModeDate title:@"出生日期" selectedDate:selectDate  orignSelectedEndDateStr:endDate  minimumDate:minDate maximumDate:maxDate actionBlock:^(id selectedDate) {
            if(selectedDate){
                NSString *selectDateStr =  [NSDate stringFromDate:selectedDate format:kSKDateFormatTypeYYYYMMDD];
                weakSelf.model.agencyBirthday = selectDateStr.copy;
                NSLog(@"选择的生日是%@",selectDateStr);
                [weakSelf.tableView reloadData];
            }
        }];
        [datePicker showInView];
    }
}

#pragma mark - submitbtnclick

-(void)chooseImgs
{

    [ZZQAvatarPicker startSelected:^(UIImage * _Nonnull image) {
        if (image) {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [UploadImageApi requestimagedata:image success:^(NSString * _Nonnull response) {
                [self.tableView reloadData];
                [MBProgressHUD hideHUDForView:self.view];
                self.model.photo = response.copy;
                [self.tableView reloadData];
            } failure:^(NSError * _Nonnull error) {
                [MBProgressHUD hideHUDForView:self.view];
            }];
        }
    }];
}

-(void)submitbtnclick
{
    NSString *url = [BaseURL stringByAppendingFormat:@"%@", updateInfoUrl];
    NSString *agencyId = [[NSUserDefaults standardUserDefaults] objectForKey:@"agencyId"];
    NSString *photo = self.model.photo?:@"";
    NSString *roleTypeId = self.model.roleTypeId?:@"";
    NSString *trueName = self.model.trueName?:@"";
    NSString *gender = self.model.gender?:@"1";
    NSString *workingDateStr = self.model.workingDateStr?:@"1990-01-01";
    NSString *agencyBirthdayStr = self.model.agencyBirthday?:@"";
    
    NSDictionary *params = @{@"agencyId":agencyId,@"photo":photo,@"roleTypeId":roleTypeId,@"trueName":trueName,@"gender":gender,@"workingDateStr":workingDateStr,@"agencyBirthdayStr":agencyBirthdayStr,@"hometownProvinceId":self.model.hometownProvinceId,@"hometownCityId":self.model.hometownCityId,@"hometownCountyId":self.model.hometownCountyId};
    
    [NetManager afPostRequest:url parms:params finished:^(id responseObj) {
        NSString *msg = [responseObj objectForKey:@"msg"];
        [MBProgressHUD showMessage:msg];
        [self getdatafromweb];
    } failed:^(NSString *errorMsg) {
        
    }];
}

@end
