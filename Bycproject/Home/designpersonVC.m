//
//  designpersonVC.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/11/24.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "designpersonVC.h"
#import "designchooseView.h"
#import "designpersonCell.h"

@interface designpersonVC ()<UITableViewDataSource,UITableViewDelegate,myMenudelegate>
@property (nonatomic,copy) NSString *typeStr;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) designchooseView *chooseView;

@end

static NSString *designidentfity = @"designidentfity";

@implementation designpersonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找设计";
    self.typeStr = @"0";
    self.dataSource = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.chooseView];
    [self createrightButton];
    [self createData];
}

-(void)createrightButton{
    UIButton * areaButton = [[UIButton alloc] initWithFrame:CGRectMake(16, 36, 44, 30)];
    [areaButton setTitle:@"类别" forState:normal];
    [areaButton setTitleColor:[UIColor darkGrayColor] forState:normal];
    areaButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [areaButton addTarget:self action:@selector(rightButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* BarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:areaButton];
    if (@available(iOS 11.0, *)) {
        BarButtonItem.customView.frame = CGRectMake(0, 0, 44, 30);
    }
    self.navigationItem.rightBarButtonItem = BarButtonItem;
}

-(void)rightButtonOnClick
{
    [UIView animateWithDuration:0.3 animations:^{
        self.chooseView.transform = CGAffineTransformMakeTranslation(0, 140+getRectNavAndStatusHight);
    }];
}

-(void)createData
{
    [self.dataSource removeAllObjects];
    NSString *url = [BaseURL stringByAppendingFormat:@"%@", designerUrl];
    NSDictionary *params = @{@"type":self.typeStr?:@"0"};
    [NetManager afPostRequest:url parms:params finished:^(id responseObj) {
        if ([[responseObj objectForKey:@"code"] intValue]==1000) {
            NSDictionary *data = [responseObj objectForKey:@"data"];
            NSArray *List = [data objectForKey:@"list"];
            NSArray *array = [NSArray yy_modelArrayWithClass:[designModel class] json:List];
            [self.dataSource addObjectsFromArray:array];
            [self.tableView reloadData];
        }
    } failed:^(NSString *errorMsg) {
        
    }];
}

#pragma mark - getters

-(UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] init];
        if (ISIPHONEX) {
            self.tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
        }
        else
        {
            self.tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
        }
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

-(designchooseView *)chooseView
{
    if(!_chooseView)
    {
        _chooseView = [designchooseView new];
        _chooseView.frame = CGRectMake(0, -140, WIDTH, 100);
        _chooseView.backgroundColor = [UIColor whiteColor];
        _chooseView.delegate = self;
    }
    return _chooseView;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count?:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    designpersonCell *cell = [tableView dequeueReusableCellWithIdentifier:designidentfity];
    cell = [[designpersonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:designidentfity];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataSource.count!=0) {
        [cell setModel:self.dataSource[indexPath.row]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

#pragma mark - MenuDelegate

-(void)myMenuClick:(NSString *)btnStr
{
    if ([btnStr intValue]==0) {
        self.title = @"设计师";
        self.typeStr = @"1";
    }
    if ([btnStr intValue]==1) {
        self.title = @"建筑师";
        self.typeStr = @"2";
    }
    if ([btnStr intValue]==2) {
        self.title = @"水工";
        self.typeStr = @"3";
    }
    if ([btnStr intValue]==3) {
        self.title = @"木工";
        self.typeStr = @"4";
    }
    if ([btnStr intValue]==4) {
        self.title = @"装修";
        self.typeStr = @"5";
    }
    if ([btnStr intValue]==5) {
        self.title = @"工人";
        self.typeStr = @"6";
    }
    
    [self createData];
    
    [UIView animateWithDuration:0.3 animations:^{
            self.chooseView.transform = CGAffineTransformIdentity;
    }completion:^(BOOL finished) {
    
    }];
}
@end
