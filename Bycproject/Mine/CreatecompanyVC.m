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
#import "companyListModel.h"
#import "companyManager.h"
#import "createshowView.h"

@interface CreatecompanyVC ()<UITableViewDataSource,UITableViewDelegate,myTabVdelegate,UITextFieldDelegate,UITextViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *bannerArray;
@property (nonatomic,strong) NSMutableArray *bottomArray;
@property (nonatomic,copy) NSString *logoStr;
@property (nonatomic,strong) UIButton *submitBtn;

@property (nonatomic,copy) NSString *companyTypeStr;

@property (nonatomic,copy) NSString *companyName;//公司名称
@property (nonatomic,copy) NSString *companySlogan;//公司标语
@property (nonatomic,copy) NSString *companyLogo;//公司Logo
@property (nonatomic,copy) NSString *companyType;//公司类型
@property (nonatomic,copy) NSString *createPerson;//创建人ID
@property (nonatomic,copy) NSString *headQuarters;//是否为总公司
@property (nonatomic,copy) NSString *companyAddress;//地址
@property (nonatomic,copy) NSString *companyIntroduction;//简介
@property (nonatomic,copy) NSString *companyUrl;//网站
@property (nonatomic,copy) NSString *longitude;//经度
@property (nonatomic,copy) NSString *latitude;//纬度
@property (nonatomic,copy) NSMutableString *imgList;//广告图片列表数组
@property (nonatomic,copy) NSString *companyPhone;//电话
@property (nonatomic,copy) NSString *serviceScope;//服务范围

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

    [self.view addSubview:self.tableView];
    
    if (self.isChange) {
        [self getdataFromweb];
        
    }
    else
    {
        self.bannerArray = [NSMutableArray array];
        self.bottomArray = [NSMutableArray array];
    }

}



/// 获取公司信息
-(void)getdataFromweb
{
    NSString *url = [BaseURL stringByAppendingFormat:@"%@", getNoVipYellowPage];
    NSString *companyId = self.companyId;
    NSString *agencyId = [[NSUserDefaults standardUserDefaults] objectForKey:@"agencyId"];
    NSDictionary *params = @{@"companyId":companyId,@"agencyId":agencyId};
    
    [NetManager afPostRequest:url parms:params finished:^(id responseObj) {
        if ([[responseObj objectForKey:@"code"] intValue]==1000) {
            NSDictionary *data = [responseObj objectForKey:@"data"];
            NSDictionary *company = [data objectForKey:@"company"];

            self.bannerArray = [NSMutableArray array];
            self.bottomArray = [NSMutableArray array];
            NSArray *headImgs = [NSArray yy_modelArrayWithClass:[companyListModel class] json:[data objectForKey:@"headImgs"]];
            NSArray *footImgs = [NSArray yy_modelArrayWithClass:[companyListModel class] json:[data objectForKey:@"footImgs"]];
            [self.bannerArray addObjectsFromArray:headImgs];
            [self.bottomArray addObjectsFromArray:footImgs];
            
            self.companyLogo = [company objectForKey:@"companyLogo"]?:@"";
            self.companyName = [company objectForKey:@"companyName"]?:@"";
            self.companyAddress = [company objectForKey:@"companyAddress"]?:@"";
            self.serviceScope = [company objectForKey:@"serviceScope"]?:@"";
            self.companyPhone = [company objectForKey:@"companyPhone"]?:@"";
            self.companyType = [company objectForKey:@"companyType"]?:@"";
            self.companyTypeStr = [companyManager getTypeWithTitle:self.companyType];
            
            [self.tableView reloadData];
        }
    } failed:^(NSString *errorMsg) {
        
    }];
}

-(UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-88-65) style:UITableViewStyleGrouped];
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
        [_submitBtn setTitle:@"确定" forState:normal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:normal];
        _submitBtn.backgroundColor = MainColor;
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 22;
        if (self.isChange) {
            [_submitBtn addTarget:self action:@selector(changesubmitBtnclick) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            [_submitBtn addTarget:self action:@selector(submitBtnclick) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return _submitBtn;
}

- (NSMutableString *)imgList {
    if (!_imgList) {
        _imgList = [[NSMutableString alloc] init];
    }
    return _imgList;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

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
        return self.bannerArray.count?:0;
    }
    if (section==2) {
        return self.bottomArray.count?:0;
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
            }
            [cell.logoImg sd_setImageWithURL:[NSURL URLWithString:self.companyLogo] placeholderImage:[UIImage imageNamed:@"jiajia2"]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseImgs)];
            [cell.logoImg addGestureRecognizer:tapGesturRecognizer];
            return cell;
        }
        if (indexPath.row==1) {
            createcompanyCell1 *cell = [tableView dequeueReusableCellWithIdentifier:createidentfi1];
            if (!cell) {
                cell = [[createcompanyCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:createidentfi1];
                cell.contentText.tag = 102;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentText.delegate = self;
            cell.titleLab.text = @"店铺名称";
            cell.contentText.placeholder = @"请输入店铺名称";
            cell.contentText.text = self.companyName?:@"";
            
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
            cell.messageLab.hidden = NO;
            cell.messageLab.text = self.companyTypeStr?:@"";
            return cell;
        }
        if (indexPath.row==3) {
            createcompanyCell2 *cell = [tableView dequeueReusableCellWithIdentifier:createidentfi3];
            if (!cell) {
                cell = [[createcompanyCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:createidentfi3];
                cell.messageText.tag = 103;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLab.text = @"服务范围";
            cell.messageText.delegate = self;
            cell.messageText.text = self.serviceScope?:@"";
            return cell;
        }
        if (indexPath.row==4) {
            createcompanyCell1 *cell = [tableView dequeueReusableCellWithIdentifier:createidentfi2];
            if (!cell) {
                cell = [[createcompanyCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:createidentfi2];
                cell.contentText.tag = 104;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentText.delegate = self;
            cell.titleLab.text = @"电话";
            cell.contentText.placeholder = @"请输入电话";
            cell.contentText.text = self.companyPhone;
            return cell;
        }
        if (indexPath.row==5) {
            createcompanyCell1 *cell = [tableView dequeueReusableCellWithIdentifier:createidentfi2];
            if (!cell) {
                cell = [[createcompanyCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:createidentfi2];
                cell.contentText.tag = 105;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentText.delegate = self;
            cell.titleLab.text = @"地址";
            cell.contentText.placeholder = @"请输入地址";
            cell.contentText.text = self.companyAddress;
            return cell;
        }
        if (indexPath.row==6) {
            createcompanyCell2 *cell = [tableView dequeueReusableCellWithIdentifier:createidentfi3];
            if (!cell) {
                cell = [[createcompanyCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:createidentfi3];
                cell.messageText.tag = 106;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLab.text = @"店铺简介";
            cell.messageText.delegate = self;
            cell.messageText.text = self.companyIntroduction?:@"";
            return cell;
        }
    }
    if (indexPath.section==1) {
        createcompanyCell3 *cell = [tableView dequeueReusableCellWithIdentifier:createidentfi4];
        if (!cell) {
            cell = [[createcompanyCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:createidentfi4];
            cell.delegate = self;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.messageText.placeholder = @"请输入网址链接";
        cell.model = self.bannerArray[indexPath.row];
        return cell;
    }
    if (indexPath.section==2) {
        createcompanyCell3 *cell = [tableView dequeueReusableCellWithIdentifier:createidentfi5];
        if (!cell) {
            cell = [[createcompanyCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:createidentfi5];
            cell.delegate = self;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.messageText.placeholder = @"请输入网址链接";
        cell.model = self.bottomArray[indexPath.row];
        return cell;
    }
    return [UITableViewCell new];
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
    if (section==1||section==2) {
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
    return [UIView new];
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
    if (section==2) {
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
        UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addbannerClick2)];
        [titleLab addGestureRecognizer:tapGesturRecognizer];
        
        return bgView;
    }
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==2) {
//            DetailViewController *vc = [DetailViewController new];
//            vc.refreshBlock = ^(NSDictionary * _Nonnull dic) {
//                self.companyType = [NSString new];
//                self.companyTypeStr = [NSString new];
//                self.companyType = [dic objectForKey:@"idstr"]?:@"";
//                self.companyTypeStr = [dic objectForKey:@"titleStr"]?:@"";
//                self.tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT-88);
//                [self.tableView reloadData];
//            };
//            [self.navigationController pushViewController:vc animated:YES];
            createshowView *show = [[createshowView alloc] init];
            show.sureClick = ^(NSDictionary * _Nonnull dic) {
                self.companyType = [dic objectForKey:@"typeNo"]?:@"";
                self.companyTypeStr = [dic objectForKey:@"name"]?:@"";
                [self.tableView reloadData];
            };
        }
    }
}

#pragma mark - 继续添加

-(void)addbannerClick
{
    companyListModel *model = [companyListModel new];
    [self.bannerArray addObject:model];
    [self.tableView reloadData];
}

-(void)addbannerClick2
{
    companyListModel *model = [companyListModel new];
    [self.bottomArray addObject:model];
    [self.tableView reloadData];
}

#pragma mark - 公司logo

-(void)chooseImgs
{
    [ZZQAvatarPicker startSelected:^(UIImage * _Nonnull image) {
        if (image) {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [UploadImageApi requestimagedata:image success:^(NSString * _Nonnull response) {
                [MBProgressHUD hideHUDForView:self.view];
                self.companyLogo = response.copy?:@"";
                [self.tableView reloadData];
            } failure:^(NSError * _Nonnull error) {
                [MBProgressHUD hideHUDForView:self.view];
            }];
        }
    }];
}

#pragma mark - 实现方法

-(void)submitBtnclick
{

    if (self.imgList.length > 5) {
        NSRange deleteRange = {([self.imgList length] - 2), 1};
        [self.imgList deleteCharactersInRange:deleteRange];
    }
    
    UITextField *nameText = [self.tableView viewWithTag:102];
    self.companyName = nameText.text?:@"";
    UITextField *serviceScopeText = [self.tableView viewWithTag:103];
    self.serviceScope = serviceScopeText.text?:@"";
    UITextField *phoneText = [self.tableView viewWithTag:104];
    self.companyPhone = phoneText.text?:@"";
    UITextField *addressText = [self.tableView viewWithTag:105];
    self.companyAddress = addressText.text?:@"";
    UITextField *infoText = [self.tableView viewWithTag:106];
    self.companyIntroduction = infoText.text?:@"";
    NSString *type = @"1";
    self.longitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"lng"];
    self.latitude  = [[NSUserDefaults standardUserDefaults] objectForKey:@"lat"];
    
    self.createPerson = [[NSUserDefaults standardUserDefaults] objectForKey:@"agencyId"];

    NSMutableArray *array = [NSMutableArray new];
    for (int i = 0; i<self.bannerArray.count; i++) {
        companyListModel *model = [self.bannerArray objectAtIndex:i];
        model.type = @"8";
        model.sort = @"0";
        model.companyId = @"";
        model.picTitle = @"";
        model.picId = @"";

    }
    for (int i = 0; i<self.bottomArray.count; i++) {
        companyListModel *model = [self.bottomArray objectAtIndex:i];
        model.type = @"22";
        model.sort = @"0";
        model.companyId = @"";
        model.picTitle = @"";
        model.picId = @"";
    }
    [array addObjectsFromArray:self.bottomArray];
    [array addObjectsFromArray:self.bannerArray];
 
    NSMutableDictionary *multiDict = [NSMutableDictionary dictionary];
    [self.imgList appendString:@"["];
    for (int i = 0; i < array.count; i ++) {
        companyListModel *model = array[i];
        [multiDict setObject:model.companyId forKey:@"companyId"];
        [multiDict setObject:model.picUrl?:@"" forKey:@"picUrl"];
        [multiDict setObject:model.picId?:@"0" forKey:@"picId"];
        [multiDict setObject:[NSString stringWithFormat:@"%d", i + 1] forKey:@"sort"];
        [multiDict setObject:model.type forKey:@"type"];
        [multiDict setObject:model.picTitle?:@"" forKey:@"picTitle"];//文字
        [multiDict setObject:model.picHref?:@"" forKey:@"picHref"];//连接
        
        NSLog(@"%@ ===== %@",model.picTitle, model.picHref);
        NSString *dictStr = [model yy_modelToJSONString];
        [self.imgList appendString:dictStr];
        [self.imgList appendString:@","];
    }
    [self.imgList appendString:@"]"];
    
    NSDictionary *params = @{@"type":type,@"imgList":self.imgList?:@"",@"createPerson":self.createPerson,@"latitude":self.latitude,@"longitude":self.longitude,@"companyIntroduction":self.companyIntroduction?:@"",@"companyPhone":self.companyPhone?:@"",@"serviceScope":self.serviceScope?:@"",@"companyName":self.companyName?:@"",@"dealImgs":@(1),@"headQuarters":@(0)};
    
    NSString *url = [BaseURL stringByAppendingFormat:@"%@", saveHeadquartersUrl];
    
    [NetManager afPostRequest:url parms:params finished:^(id responseObj) {
        NSString *msg = [responseObj objectForKey:@"msg"];
        [MBProgressHUD showMessage:msg];
        if ([[responseObj objectForKey:@"code"] intValue]==1000) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failed:^(NSString *errorMsg) {
        
    }];
}

-(void)changesubmitBtnclick
{
    if (self.imgList.length > 5) {
        NSRange deleteRange = {([self.imgList length] - 2), 1};
        [self.imgList deleteCharactersInRange:deleteRange];
    }
    NSString *url = [BaseURL stringByAppendingFormat:@"%@", saveAreaUrl];
    NSInteger companyId = [self.companyId intValue];
    NSString *companyName = self.companyName?:@"";
    NSString *companyLogo = self.companyLogo?:@"";
    
    NSInteger companyProvince = 0;
    NSInteger companyCity = 0;
    NSInteger companyCounty = 0;
    
    NSString *companyLandline = @"";
    NSString *companyPhone = self.companyPhone;
    NSString *companyIntroduction = self.companyIntroduction?:@"";
    NSString *companyWx = @"";
    NSString *companyType = self.companyType?:@"";
    NSString *serviceScope = self.serviceScope?:@"";
    NSString *latitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"lat"];
    NSString *longitude = [[NSUserDefaults standardUserDefaults] objectForKey:@"lng"];

    NSMutableArray *array = [NSMutableArray new];
    for (int i = 0; i<self.bannerArray.count; i++) {
        companyListModel *model = [self.bannerArray objectAtIndex:i];
        model.type = @"8";
        model.sort = @"0";
        model.companyId = self.companyId;
        model.picTitle = @"";
        model.picId = @"";

    }
    for (int i = 0; i<self.bottomArray.count; i++) {
        companyListModel *model = [self.bottomArray objectAtIndex:i];
        model.type = @"22";
        model.sort = @"0";
        model.companyId = self.companyId;
        model.picTitle = @"";
        model.picId = @"";
    }
    [array addObjectsFromArray:self.bottomArray];
    [array addObjectsFromArray:self.bannerArray];
    
    
    NSMutableDictionary *multiDict = [NSMutableDictionary dictionary];
    [self.imgList appendString:@"["];
    for (int i = 0; i < array.count; i ++) {
        companyListModel *model = array[i];
        [multiDict setObject:self.companyId forKey:@"companyId"];
        [multiDict setObject:model.picUrl?:@"" forKey:@"picUrl"];
        [multiDict setObject:model.picId?:@"0" forKey:@"picId"];
        [multiDict setObject:[NSString stringWithFormat:@"%d", i + 1] forKey:@"sort"];
        [multiDict setObject:model.type forKey:@"type"];
        [multiDict setObject:model.picTitle?:@"" forKey:@"picTitle"];//文字
        [multiDict setObject:model.picHref?:@"" forKey:@"picHref"];//连接

        NSLog(@"%@ ===== %@",model.picTitle, model.picHref);
        NSString *dictStr = [model yy_modelToJSONString];
        [self.imgList appendString:dictStr];
//        [self.imgList appendString:@","];
    }
    [self.imgList appendString:@"]"];
    
    NSInteger lngint = [longitude integerValue];
    NSInteger latint = [latitude intValue];
    NSInteger typeint = [companyType intValue];
    
    NSDictionary *params = @{@"companyId":@(companyId),@"companyName":companyName,@"companyLogo":companyLogo,@"companyProvince":@(companyProvince),@"companyCity":@(companyCity),@"companyCounty":@(companyCounty),@"companyLandline":companyLandline,@"companyPhone":companyPhone,@"companyIntroduction":companyIntroduction,@"companyWx":companyWx,@"companyType":@(typeint),@"serviceScope":serviceScope,@"latitude":@(latint),@"longitude":@(lngint),@"imgList":self.imgList?:@"",@"seeFlag":@(0),@"areaList":@"[]"};

    
    [NetManager afPostRequest:url parms:params finished:^(id responseObj) {
        NSString *msg = [responseObj objectForKey:@"msg"];
        [MBProgressHUD showMessage:msg];
        if ([[responseObj objectForKey:@"code"] intValue]==1000) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failed:^(NSString *errorMsg) {
        
    }];
}

-(void)myTabVClick:(UITableViewCell *)cell
{
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    
    [ZZQAvatarPicker startSelected:^(UIImage * _Nonnull image) {
        if (image) {
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [UploadImageApi requestimagedata:image success:^(NSString * _Nonnull response) {
                [MBProgressHUD hideHUDForView:self.view];
                if (index.section==1) {
                    companyListModel *model = [self.bannerArray objectAtIndex:index.row];
                    model.picUrl = response.copy?:@"";
                    
                    [self.tableView reloadData];
                }
                if (index.section==2) {
                    companyListModel *model = [self.bottomArray objectAtIndex:index.row];
                    model.picUrl = response.copy?:@"";
                    
                    [self.tableView reloadData];
                }
            } failure:^(NSError * _Nonnull error) {
                [MBProgressHUD hideHUDForView:self.view];
            }];
        }
    }];
}

-(void)myTabwithstr:(NSString *)str with:(UITableViewCell *)cell
{
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    if (index.section==1) {
        companyListModel *model = [self.bannerArray objectAtIndex:index.row];
        model.picHref = str?:@"";
        [self.tableView reloadData];
    }
    if (index.section==2) {
        companyListModel *model = [self.bottomArray objectAtIndex:index.row];
        model.picHref = str?:@"";
        [self.tableView reloadData];
    }
}


-(NSString *)gs_jsonStringCompactFormatForNSArray:(NSArray *)arrJson {
    if (![arrJson isKindOfClass:[NSArray class]] || ![NSJSONSerialization isValidJSONObject:arrJson]) {
        return nil;
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arrJson options:0 error:nil];
    NSString *strJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return strJson;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    UITextField *nameText = [self.tableView viewWithTag:102];
    self.companyName = nameText.text?:@"";
    UITextField *phoneText = [self.tableView viewWithTag:104];
    self.companyPhone = phoneText.text?:@"";
    UITextField *addressText = [self.tableView viewWithTag:105];
    self.companyAddress = addressText.text?:@"";
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    UITextField *serviceScopeText = [self.tableView viewWithTag:103];
    self.serviceScope = serviceScopeText.text?:@"";
    UITextField *infoText = [self.tableView viewWithTag:106];
    self.companyIntroduction = infoText.text?:@"";
}

@end
