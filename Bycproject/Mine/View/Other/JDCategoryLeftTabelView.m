//
//  JDCategoryLeftTabelView.m
//  分类列表联动
//
//  Created by yifo on 2018/8/3.
//  Copyright © 2018年 yanhaiqiang. All rights reserved.
//

#import "JDCategoryLeftTabelView.h"
#import "JDCategoryLeftTableCell.h"

@interface JDCategoryLeftTabelView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *titleArray;
@end

static NSString *leftCell = @"leftCell";

@implementation JDCategoryLeftTabelView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.titleArray = [NSMutableArray arrayWithObjects:@"硬装软装",@"主材辅材",@"家居电器",@"配套/服务",@"家居生活", nil];
        self.rowHeight = 70;
        self.selectedRow = 0;
        [self registerClass:JDCategoryLeftTableCell.class forCellReuseIdentifier:leftCell];
    }
    return self;
}

#pragma mark -------UITabelViewdataSource-------
- (NSInteger)numberOfSections {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JDCategoryLeftTableCell *cell = [JDCategoryLeftTableCell cellWithTableView:tableView];
    tableView.tableFooterView = [UIView new];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.selectedRow == indexPath.row) {
        cell.leftLine.hidden = NO;
    }else {
        cell.leftLine.hidden = YES;
    }
    cell.titleLabel.text = self.titleArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedRow = indexPath.row;
    [tableView reloadData];
    if (self.CellSelectedBlock) {
        self.CellSelectedBlock(indexPath);
    }
}
- (void)setSelectedRow:(NSInteger)selectedRow {
    _selectedRow = selectedRow;
    [self reloadData];
}


@end
