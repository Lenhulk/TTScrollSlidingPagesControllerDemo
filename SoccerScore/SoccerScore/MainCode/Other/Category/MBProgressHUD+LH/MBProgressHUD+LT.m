//
//  MBProgressHUD+LT.m
//  AddFriendsDB
//
//  Created by apple004 on 2017/6/28.
//  Copyright © 2017年 test. All rights reserved.
//

#import "MBProgressHUD+LT.h"

@implementation MBProgressHUD (LT)


+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    [self showSuccessWithTitle:nil success:text icon:icon toView:view];
}


+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}


+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:nil view:view];
}

+ (void)showSuccessWithTitle:(NSString *)title success:(NSString *)success icon:(NSString *)icon toView:(UIView *)view
{
    [self hideHUD];
    
    if (view == nil)
//        view = [[UIApplication sharedApplication].windows lastObject];
        view = [self currentView];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // 设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    
    hud.labelText = title;
    hud.detailsLabelText = success;
//    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
//    hud.bezelView.backgroundColor = NTRGBAColor(0, 0, 0, 0.8);
//    hud.detailsLabel.text = success;
//    hud.contentColor = [UIColor whiteColor];    //修改字体颜色
    
    
    hud.animationType = MBProgressHUDAnimationZoom;
    // 设置图片
    if (icon == nil) icon = @"success";
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    
    
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.5];
}



+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}


+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error" view:view];
}


+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}


/**
 *  显示一些信息
 *
 *  @param message 信息内容
 *  @param view    需要显示信息的视图
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
//    hud.label.text = message;
//    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
//    hud.bezelView.backgroundColor = NTRGBAColor(0, 0, 0, 0.8);
//    hud.contentColor = [UIColor whiteColor];
    hud.labelText = message;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
//    hud.dimBackground = YES;
    [hud hide:YES afterDelay:1.5];
    return hud;
}


/**
 *  手动关闭MBProgressHUD
 */
+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil)
//        view = [[UIApplication sharedApplication].windows lastObject];
        view = [self currentView];
    [self hideHUDForView:view animated:YES];
}

+ (UIView *)currentView{
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    if ([vc isKindOfClass:[UITabBarController class]]) {
        vc = [(UITabBarController *)vc selectedViewController];
    }
    if([vc isKindOfClass:[UINavigationController class]]) {
        vc = [(UINavigationController *)vc visibleViewController]; //当前显示的控制器
    }
    if (!vc) {
        return [UIApplication sharedApplication].keyWindow;
    }
    return vc.view;
}


@end
