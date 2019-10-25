//
//  changenameVC.m
//  Bycproject
//
//  Created by 王俊钢 on 2019/10/24.
//  Copyright © 2019 wangjungang. All rights reserved.
//

#import "changenameVC.h"

@interface changenameVC ()
@property (nonatomic,strong) UITextField *nameText;
@end

@implementation changenameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改昵称";
    [self.view addSubview:self.nameText];
    self.nameText.text = self.nameStr;
}

-(UITextField *)nameText
{
    if(!_nameText)
    {
        _nameText = [[UITextField alloc] initWithFrame:CGRectMake(15, getRectNavAndStatusHight+20, WIDTH-30, 44)];
        _nameText.placeholder = @"请输入昵称";
        
    }
    return _nameText;
}

- (void)didMoveToParentViewController:(UIViewController*)parent{
    [super didMoveToParentViewController:parent];
    if(!parent){
        NSLog(@"页面pop成功了");
        if (self.refreshBlock) {
            self.refreshBlock(self.nameText.text?:@"");
        }
    }
}

@end
