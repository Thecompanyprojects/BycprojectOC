//
//  CreatecompanyVC.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/17.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "CreatecompanyVC.h"
#import "createcompanyCell0.h"
#import "createcompanyCell1.h"
#import "createcompanyCell2.h"
#import "createcompanyCell3.h"
#import "DetailViewController.h"

@interface CreatecompanyVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *bannerArray;
@property (nonatomic,copy) NSString *logoStr;
@property (nonatomic,strong) UIButton *submitBtn;
@end

static NSString *createidentfi0 = @"createidentfi0";
static NSString *createidentfi1 = @"createidentfi1";
static NSString *createidentfi2 = @"createidentfi2";
static NSString *createidentfi3 = @"createidentfi3";
static NSString *createidentfi4 = @"createidentfi4";
static NSString *createidentfi5 = @"createidentfi5";

@implementation CreatecompanyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"创建公司";
    self.bannerArray = [NSMutableArray arrayWithObjects:@"", nil];
    
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
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 60)];
        _tableView.tableFooterView = footView;
        [footView addSubview:self.submitBtn];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return _tableView;
}

-(UIButton *)submitBtn
{
    if(!_submitBtn)
    {
        _submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 20, WIDTH-30, 44)];
        [_submitBtn setTitle:@"创建" forState:normal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:normal];
        _submitBtn.backgroundColor = MainColor;
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 22;
    }
    return _submitBtn;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 7;
    }
    if (section==1) {
        return self.bannerArray.count;
    }
    if (section==2) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            createcompanyCell0 *cell = [tableView dequeueReusableCellWithIdentifier:createidentfi0];
            if (!cell) {
                cell = [[createcompanyCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:createidentfi0];
                cell.logoImg.image = [UIImage imageNamed:@"jiajia2"];
                cell.logoImg.tag = 101;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseImgs)];
            [cell.logoImg addGestureRecognizer:tapGesturRecognizer];
            return cell;
        }
        if (indexPath.row==1) {
            createcompanyCell1 *cell = [tableView dequeueReusableCellWithIdentifier:createidentfi1];
            if (!cell) {
                cell = [[createcompanyCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:createidentfi1];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLab.text = @"店铺名称";
            cell.contentText.placeholder = @"请输入店铺名称";
            return cell;
        }
        if (indexPath.row==2) {
            createcompanyCell1 *cell = [tableView dequeueReusableCellWithIdentifier:createidentfi2];
            if (!cell) {
                cell = [[createcompanyCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:createidentfi2];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLab.text = @"类别";
            cell.contentText.hidden = YES;
            
            return cell;
        }
        if (indexPath.row==3) {
            createcompanyCell2 *cell = [tableView dequeueReusableCellWithIdentifier:createidentfi3];
            if (!cell) {
                cell = [[createcompanyCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:createidentfi3];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLab.text = @"服务范围";
            return cell;
        }
        if (indexPath.row==4) {
            createcompanyCell1 *cell = [tableView dequeueReusableCellWithIdentifier:createidentfi2];
            if (!cell) {
                cell = [[createcompanyCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:createidentfi2];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLab.text = @"电话";
            cell.contentText.placeholder = @"请输入电话";
            return cell;
        }
        if (indexPath.row==5) {
            createcompanyCell1 *cell = [tableView dequeueReusableCellWithIdentifier:createidentfi2];
            if (!cell) {
                cell = [[createcompanyCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:createidentfi2];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLab.text = @"地址";
            cell.contentText.placeholder = @"请输入地址";
            return cell;
        }
        if (indexPath.row==6) {
            createcompanyCell2 *cell = [tableView dequeueReusableCellWithIdentifier:createidentfi3];
            if (!cell) {
                cell = [[createcompanyCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:createidentfi3];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLab.text = @"店铺简介";
            return cell;
        }
    }
    if (indexPath.section==1) {
        createcompanyCell3 *cell = [tableView dequeueReusableCellWithIdentifier:createidentfi4];
        if (!cell) {
            cell = [[createcompanyCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:createidentfi4];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.messageText.placeholder = @"请输入网址链接";
        return cell;
    }
    if (indexPath.section==2) {
        createcompanyCell3 *cell = [tableView dequeueReusableCellWithIdentifier:createidentfi5];
        if (!cell) {
            cell = [[createcompanyCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:createidentfi5];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.messageText.placeholder = @"请输入网址链接";
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 130;
        }
        if (indexPath.row==1||indexPath.row==2||indexPath.row==4||indexPath.row==5) {
            return 60;
        }
        if (indexPath.row==3) {
            return 130;
        }
        if (indexPath.row==6) {
            return 150;
        }
    }
    if (indexPath.section==1) {
        return 130;
    }
    if (indexPath.section==2) {
        return 130;
    }

    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0.01f;
    }
    if (section==1||section==2) {
        return 50;
    }
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==1) {
        return 30;
    }
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return [UIView new];
    }
    if (section==1) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 14)];
        bgView.backgroundColor = [UIColor whiteColor];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
        [bgView addSubview:lineView];
        UILabel *titleLab = [UILabel new];
        titleLab.frame = CGRectMake(16, 32, WIDTH-32, 18);
        [bgView addSubview:titleLab];
        titleLab.font = [UIFont systemFontOfSize:16];
        titleLab.textColor = [UIColor blackColor];
        titleLab.text = @"店铺首页banner";
        return bgView;
    }
    if (section==2) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 14)];
        [bgView addSubview:lineView];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
        bgView.backgroundColor = [UIColor whiteColor];
        UILabel *titleLab = [UILabel new];
        titleLab.frame = CGRectMake(16, 32, WIDTH-32, 18);
        [bgView addSubview:titleLab];
        titleLab.font = [UIFont systemFontOfSize:16];
        titleLab.text = @"店铺广告位(下)";
        titleLab.textColor = [UIColor blackColor];
        return bgView;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section==1) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
        bgView.backgroundColor = [UIColor whiteColor];
        UILabel *titleLab = [UILabel new];
        titleLab.frame = CGRectMake(16, 0, WIDTH-32, 18);
        [bgView addSubview:titleLab];
        titleLab.font = [UIFont systemFontOfSize:16];
        titleLab.text = @"继续添加";
        titleLab.textAlignment = NSTextAlignmentRight;
        titleLab.textColor = [UIColor blackColor];
        
        titleLab.userInteractionEnabled = true;
        UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addbannerClick)];
        [titleLab addGestureRecognizer:tapGesturRecognizer];
        
        return bgView;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==2) {
            DetailViewController *vc = [DetailViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark - 继续添加

-(void)addbannerClick
{
    [self.bannerArray addObject:@""];
    [self.tableView reloadData];
}

#pragma mark - 公司logo

-(void)chooseImgs
{
    UIImageView *logoimg = [self.tableView viewWithTag:101];
    [ZZQAvatarPicker startSelected:^(UIImage * _Nonnull image) {
        if (image) {
            logoimg.image = image;
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [UploadImageApi requestimagedata:image success:^(NSString * _Nonnull response) {
                [self.tableView reloadData];
                [MBProgressHUD hideHUDForView:self.view];
                self.logoStr = response.copy;
            } failure:^(NSError * _Nonnull error) {
                [MBProgressHUD hideHUDForView:self.view];
            }];
        }
    }];
}

@end
