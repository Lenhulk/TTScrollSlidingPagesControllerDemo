//
//  NSObject+AFExtension.m
//  AddFriendsDB
//
//  Created by apple004 on 2017/8/1.
//  Copyright © 2017年 test. All rights reserved.
//

#import "NSObject+NTExtension.h"

@implementation NSObject (NTExtension)


- (UIViewController *)topViewController
{
    return [self topViewControllerWithRootViewController:[self getCurrentWindow].rootViewController];
}


- (UIViewController *)topViewControllerWithRootViewController:(UIViewController *)rootVc
{
    if (!rootVc) {
        return nil;
    }
    if (rootVc.presentedViewController != nil) {
        return [self topViewControllerWithRootViewController:rootVc.presentedViewController];
    }
    else if ([rootVc isKindOfClass:[UITabBarController class]]){
        UITabBarController *tabBarVc = (UITabBarController *)rootVc;
        return [self topViewControllerWithRootViewController:tabBarVc.selectedViewController];
    }
    else if ([rootVc isKindOfClass:[UINavigationController class]]){
        UINavigationController *navVc = (UINavigationController *)rootVc;
        return [self topViewControllerWithRootViewController:navVc.visibleViewController];
    }
    else {
        return rootVc;
    }
}


- (UITabBarController *)mainTabBarController
{
    UIViewController *rootVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    if (!rootVc) {
        return nil;
    }
    if ([rootVc isKindOfClass:[UITabBarController class]]){
        UITabBarController *tabBarVc = (UITabBarController *)rootVc;
        return tabBarVc;
    }
    else {
        return nil;
    }
}


- (UIWindow *)getCurrentWindow
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [UIApplication sharedApplication].windows;
        for (UIWindow *tempWin in windows) {
            if (tempWin.windowLevel == UIWindowLevelNormal) {
                window = tempWin;
                break;
            }
        }
    }
    return window;
}


- (UIViewController *)stringChangeToClass:(NSString *)str
{
    id vc = [[NSClassFromString(str) alloc]init];
    if ([vc isKindOfClass:[UIViewController class]]) {
        return vc;
    }
    return nil;
}



@end
