//
//  AppDelegate.h
//  XWTrasitionPractice
//
//  Created by YouLoft_MacMini on 15/11/23.
//  Copyright © 2015年 YouLoft_MacMini. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol NavcPushControllerDelegate <NSObject>

- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPush;

@end

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) id<NavcPushControllerDelegate> delegate;


@end

