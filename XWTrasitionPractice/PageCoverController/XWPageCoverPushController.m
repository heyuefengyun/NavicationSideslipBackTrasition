//
//  XWPageCoverPushController.m
//  XWTrasitionPractice
//
//  Created by YouLoft_MacMini on 15/11/24.
//  Copyright © 2015年 YouLoft_MacMini. All rights reserved.
//

#import "XWPageCoverPushController.h"
#import "XWInteractiveTransition.h"
#import "XWPageCoverTransition.h"
#import "Masonry.h"

@interface XWPageCoverPushController ()
@end

@implementation XWPageCoverPushController

- (void)dealloc{
    NSLog(@"销毁了");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"翻页效果";
    self.view.backgroundColor = [UIColor grayColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic1.jpg"]];
    [self.view addSubview:imageView];
    imageView.frame = self.view.frame;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点我或向右滑动pop" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(104);
    }];

    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"返回22" style:UIBarButtonItemStylePlain target:self action:@selector(backToRoot)];
    self.navigationItem.leftBarButtonItem = back;
}
#pragma mark - 此处验证多页面返回
- (void)backToRoot
{
//    self.navigationController.delegate = nil;
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}








@end
