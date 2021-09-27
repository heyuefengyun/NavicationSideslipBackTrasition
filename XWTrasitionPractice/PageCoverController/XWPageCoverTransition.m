//
//  XWPageCoverTransition.m
//  XWTrasitionPractice
//
//  Created by YouLoft_MacMini on 15/11/24.
//  Copyright © 2015年 YouLoft_MacMini. All rights reserved.
//

#import "XWPageCoverTransition.h"
#import "UIView+anchorPoint.h"
#import "UIView+FrameChange.h"
#import "XWPageCoverPushController.h"

@interface XWPageCoverTransition ()<UIAlertViewDelegate>
{
    id<UIViewControllerContextTransitioning> aaa ;
}
@property (nonatomic, assign, getter=isPopInitialized) BOOL popInitialized;
@end

@implementation XWPageCoverTransition

+ (instancetype)transitionWithType:(XWPageCoverTransitionType)type{
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(XWPageCoverTransitionType)type{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}
/**
 *  动画时长
 */
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 1;
}
/**
 *  如何执行过渡动画
 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    switch (_type) {
        case XWPageCoverTransitionTypePush:
            [self doPushAnimation:transitionContext];
            break;
            
        case XWPageCoverTransitionTypePop:
            [self doPopAnimation:transitionContext];
            break;
    }
}

/**
 *  执行push过渡动画
 */
- (void)doPushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    //对tempView做动画，避免bug;
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.frame = CGRectMake(- [UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        toVC.view.frame =  CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    } completion:^(BOOL finished) {
#pragma mark - 此处根据手势完成取消做相应处理
        if (transitionContext.transitionWasCancelled) {
            [transitionContext cancelInteractiveTransition];
            [transitionContext completeTransition:NO];
//            [toVC.view removeFromSuperview];
//            fromVC.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        }else {
            [transitionContext finishInteractiveTransition];
            [transitionContext completeTransition:YES];
        }
//        [containerView addSubview:fromVC.view];
    }];
}
/**
 *  执行pop过渡动画
 */
- (void)doPopAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
   
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    toVC.view.frame = CGRectMake(-[UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    //拿到push时候的
    [UIView animateWithDuration:3 animations:^{
        fromVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        toVC.view.frame =  CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    } completion:^(BOOL finished) {
#pragma mark - 此处根据手势完成取消做相应处理
        if (transitionContext.transitionWasCancelled) {
            [transitionContext cancelInteractiveTransition];
            [transitionContext completeTransition:NO];
//            [toVC.view removeFromSuperview];
//            fromVC.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        }else {
            [transitionContext finishInteractiveTransition];
            [transitionContext completeTransition:YES];
        }
    }];
    
}

@end
