//
//  AppDelegate.m
//  XWTrasitionPractice
//
//  Created by YouLoft_MacMini on 15/11/23.
//  Copyright © 2015年 YouLoft_MacMini. All rights reserved.
//

#import "AppDelegate.h"
#import "XWInteractiveTransition.h"
#import "XWPageCoverTransition.h"
#import "Masonry.h"
#import "RootViewController.h"
@interface AppDelegate ()<UINavigationControllerDelegate>
@property (nonatomic, strong) XWInteractiveTransition *interactiveTransitionPop;
@property (nonatomic, assign) UINavigationControllerOperation operation;
@property (nonatomic, strong) UINavigationController *navc;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.rootViewController = self.navc;
    [_window makeKeyAndVisible];
    [self configTransition];
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    _operation = operation;
    //分pop和push两种情况分别返回动画过渡代理相应不同的动画操作
    return [XWPageCoverTransition transitionWithType:operation == UINavigationControllerOperationPush ? XWPageCoverTransitionTypePush : XWPageCoverTransitionTypePop];
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    if (_operation == UINavigationControllerOperationPush) {
        XWInteractiveTransition *interactiveTransitionPush = [_delegate interactiveTransitionForPush];
        return interactiveTransitionPush.interation ? interactiveTransitionPush : nil;
    }else{
        return _interactiveTransitionPop.interation ? _interactiveTransitionPop : nil;
    }
}
- (void)configTransition {
    //初始化手势过渡的代理
    _interactiveTransitionPop = [XWInteractiveTransition interactiveTransitionWithTransitionType:XWInteractiveTransitionTypePop GestureDirection:XWInteractiveTransitionGestureDirectionRight];
    //给当前控制器的视图添加手势
    [_interactiveTransitionPop addPanGestureForViewController:self.navc];
}
- (UINavigationController *)navc {
    if (!_navc) {
        _navc = [[UINavigationController alloc]initWithRootViewController:[[RootViewController alloc] init] ];
        _navc.delegate = self;
    }
    return _navc;
}

@end
