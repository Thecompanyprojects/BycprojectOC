//
//  feedbackVC.m
//  iDecoration
//
//  Created by 王俊钢 on 2018/4/21.
//  Copyright © 2018年 RealSeven. All rights reserved.
//

#import "feedbackVC.h"
#import "WJGtextView.h"

@interface feedbackVC ()<UITextViewDelegate>
@property (nonatomic, strong) IQKeyboardReturnKeyHandler *returnKeyHandler;
@property (nonatomic,strong) WJGtextView *FeedTextView;
@end

@implementation feedbackVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)createUI {
    
    self.title = @"意见反馈";
    
    // 设置导航栏最右侧的按钮
    UIButton *editBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    editBtn.frame = CGRectMake(0, 0, 44, 44);
    [editBtn setTitle:@"提交" forState:UIControlStateNormal];
    [editBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    editBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    editBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    editBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
    [editBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:editBtn];
    
    self.returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
    self.returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyDone;
    
    [self.view addSubview:self.FeedTextView];
    
    if (isiPhoneX) {
        [self.FeedTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).with.offset(10);
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.view).with.offset(98);
            make.height.mas_offset(240);
        }];
    }
    else
    {
        [self.FeedTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).with.offset(10);
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.view).with.offset(74);
            make.height.mas_offset(240);
        }];
    }

}

-(WJGtextView *)FeedTextView
{
    if(!_FeedTextView)
    {
        _FeedTextView = [[WJGtextView alloc] init];
        _FeedTextView.delegate = self;
        _FeedTextView.numberlabel.text = @"0/150";
        _FeedTextView.backgroundColor = [UIColor whiteColor];
        _FeedTextView.customPlaceholder = @"输入您宝贵的意见";
        _FeedTextView.customPlaceholderColor = [UIColor colorWithHexString:@"C7C7CD"];
    }
    return _FeedTextView;
}

- (void)textViewDidChange:(UITextView *)textView {

    if ([textView.text length] > 150) {
        
        textView.text = [textView.text substringToIndex:150];
        [textView resignFirstResponder];
//        [self.view hudShowWithText:@"字数长度不要超过150字哦！"];
        
    } else {
        
        NSString *textContent = textView.text;
        NSUInteger existText = textContent.length;
        self.FeedTextView.numberlabel.text = [NSString stringWithFormat:@"%ld/150",existText];
    }
}

//提交按钮
- (void)submit:(UIBarButtonItem*)sender {
    
    NSString *upFeedback = self.FeedTextView.text?:@"";
    NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
    NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    NSString *source = @"iOS-1.0";
    NSDictionary *params = @{@"upFeedback":upFeedback,@"name":name?:@"",@"phone":phone?:@"",@"":source};
    NSString *url = [BaseURL stringByAppendingFormat:@"%@", upFeedback];
    [NetManager afPostRequest:url parms:params finished:^(id responseObj) {
        
    } failed:^(NSString *errorMsg) {
        
    }];
}

- (void)popBack {
    
    [self.navigationController popViewControllerAnimated:YES];
}

//销毁
- (void)dealloc {
    
    self.returnKeyHandler = nil;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}




@end
