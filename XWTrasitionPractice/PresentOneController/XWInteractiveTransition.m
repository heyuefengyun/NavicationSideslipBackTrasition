//
//  XWInteractiveTransition.m
//  XWTrasitionPractice
//
//  Created by YouLoft_MacMini on 15/11/24.
//  Copyright © 2015年 YouLoft_MacMini. All rights reserved.
//

#import "XWInteractiveTransition.h"

@interface XWInteractiveTransition ()<UIGestureRecognizerDelegate>

@property (nonatomic, weak) UINavigationController *vc;
/**手势方向*/
@property (nonatomic, assign) XWInteractiveTransitionGestureDirection direction;
/**手势类型*/
@property (nonatomic, assign) XWInteractiveTransitionType type;

@end

@implementation XWInteractiveTransition

+ (instancetype)interactiveTransitionWithTransitionType:(XWInteractiveTransitionType)type GestureDirection:(XWInteractiveTransitionGestureDirection)direction{
    return [[self alloc] initWithTransitionType:type GestureDirection:direction];
}

- (instancetype)initWithTransitionType:(XWInteractiveTransitionType)type GestureDirection:(XWInteractiveTransitionGestureDirection)direction{
    self = [super init];
    if (self) {
        _direction = direction;
        _type = type;
    }
    return self;
}

- (void)addPanGestureForViewController:(UINavigationController *)viewController{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    pan.delegate = self;
    self.vc = viewController;
    [viewController.view addGestureRecognizer:pan];
}

/**
 *  手势过渡的过程
 */
- (void)handleGesture:(UIPanGestureRecognizer *)panGesture{
    //手势百分比
    CGFloat persent = 0;
    switch (_direction) {
        case XWInteractiveTransitionGestureDirectionLeft:{
            CGFloat transitionX = -[panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;
        }
            break;
        case XWInteractiveTransitionGestureDirectionRight:{
            CGFloat transitionX = [panGesture translationInView:panGesture.view].x;
            persent = transitionX / panGesture.view.frame.size.width;
        }
            break;
        case XWInteractiveTransitionGestureDirectionUp:{
            CGFloat transitionY = -[panGesture translationInView:panGesture.view].y;
            persent = transitionY / panGesture.view.frame.size.width;
        }
            break;
        case XWInteractiveTransitionGestureDirectionDown:{
            CGFloat transitionY = [panGesture translationInView:panGesture.view].y;
            persent = transitionY / panGesture.view.frame.size.width;
        }
            break;
    }
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            //手势开始的时候标记手势状态，并开始相应的事件
            self.interation = YES;
            [self startGesture];
            break;
        case UIGestureRecognizerStateChanged:{
            //手势过程中，通过updateInteractiveTransition设置pop过程进行的百分比
            [self updateInteractiveTransition:persent];
            NSLog(@"3333333333333");

            break;
        }
        case UIGestureRecognizerStateEnded:{
            //手势完成后结束标记并且判断移动距离是否过半，过则finishInteractiveTransition完成转场操作，否者取消转场操作
            self.interation = NO;
            if (persent > 0.5) {
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }
            NSLog(@"444444444444444");
            break;
        }
        default:
            break;
    }
}

- (void)startGesture{
    switch (_type) {
        case XWInteractiveTransitionTypePresent:{
            if (_presentConifg) {
                _presentConifg();
            }
        }
            break;
            
        case XWInteractiveTransitionTypeDismiss:
            [_vc dismissViewControllerAnimated:YES completion:nil];
            break;
        case XWInteractiveTransitionTypePush:{
           
        }
            break;
        case XWInteractiveTransitionTypePop:
#pragma mark - 此处满足侧滑返回出现弹窗需求  比如退出编辑页  点返回和侧滑返回都弹出弹窗
//            if ([self.vc isKindOfClass:NSClassFromString(@"XWPageCoverPushController")]) {
#pragma mark - 如果非手势返回则此处要置位No
//                self.interation = NO;
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"1111" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                [alert show];
//                NSLog(@"1111111111111111111111111111");
//                return;
//            }
            
            if (_vc.viewControllers.count > 1) {
                NSLog(@"22222222222");
                [_vc popViewControllerAnimated:YES];
            }else {
                
            }
           
            break;
    }
}




- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    // Ignore when no view controller is pushed into the navigation stack.
    if (self.vc.viewControllers.count <= 1) {
        return NO;
    }
    
//    // Ignore when the active view controller doesn't allow interactive pop.
//    UIViewController *topViewController = self.navigationController.viewControllers.lastObject;
//    if (topViewController.fd_interactivePopDisabled) {
//        return NO;
//    }
//
//    // Ignore when the beginning location is beyond max allowed initial distance to left edge.
//    CGPoint beginningLocation = [gestureRecognizer locationInView:gestureRecognizer.view];
//    CGFloat maxAllowedInitialDistance = topViewController.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge;
//    if (maxAllowedInitialDistance > 0 && beginningLocation.x > maxAllowedInitialDistance) {
//        return NO;
//    }

    // Ignore pan gesture when the navigation controller is currently in transition.
    if ([[self.vc valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    
    // Prevent calling the handler when the gesture begins in an opposite direction.
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    BOOL isLeftToRight = [UIApplication sharedApplication].userInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionLeftToRight;
    CGFloat multiplier = isLeftToRight ? 1 : - 1;
    if ((translation.x * multiplier) <= 0) {
        return NO;
    }
    
    return YES;
}
@end
