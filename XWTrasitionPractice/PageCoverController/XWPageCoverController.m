//
//  XWPageCoverController.m
//  XWTrasitionPractice
//
//  Created by YouLoft_MacMini on 15/11/24.
//  Copyright © 2015年 YouLoft_MacMini. All rights reserved.
//

#import "XWPageCoverController.h"
#import "XWPageCoverPushController.h"
#import "XWInteractiveTransition.h"
#import "Masonry.h"

@interface XWPageCoverController ()
@end

@implementation XWPageCoverController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"翻页效果PUSH";
    self.view.backgroundColor = [UIColor grayColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic2.jpeg"]];
    [self.view addSubview:imageView];
    imageView.frame = self.view.frame;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点我或向左滑动push" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(174);
    }];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backToRoot)];
    self.navigationItem.leftBarButtonItem = back;
}

- (void)backToRoot
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)push{
    XWPageCoverPushController *pushVC = [XWPageCoverPushController new];
    [self.navigationController pushViewController:pushVC animated:YES];
}
@end
