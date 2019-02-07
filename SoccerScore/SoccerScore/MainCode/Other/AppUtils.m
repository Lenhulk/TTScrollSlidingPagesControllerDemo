

//
//  AppUtils.m
//  app28
//
//  Created by Neo on 2017/11/1.
//  Copyright © 2017年 Neo. All rights reserved.
//

#import "AppUtils.h"
#import "AppDelegate.h"

@implementation AppUtils


+ (void)setApplicationAppearence
{
    
    //自定义字体名：FZTCGHJW--GB1-0
    
    //TABBAR
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];  //普通颜色
    [[UITabBar appearance] setBarTintColor:[AppUtils dominantColor]];  //背景颜色

    // NAVIGATION BAR
    // -BACK
    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"back"]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"back"]];
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];   //去掉返回按钮文字
    // -COLOR
    [[UINavigationBar appearance] setBarTintColor:[AppUtils dominantColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    // -TITLE
    //    NSArray *familyNames = [UIFont familyNames];
    //    for( NSString *familyName in familyNames )
    //    {
    //        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
    //        for( NSString *fontName in fontNames )
    //        {
    //            printf( "\tFont: %s \n", [fontName UTF8String] );
    //        }
    //    }
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold]}];
    
    
    // STATUSBAR
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

+ (UIColor *)dominantColor{
//    return NTColor(220, 163, 39);
    return NTColor(24, 155, 123);
}

+ (UIColor *)lightGrayBgColor{
    return NTColor(234, 234, 234);
}

+ (UIColor *)textDarkGrayColor{//再浅一点
    return NTColor(93, 93, 93);
}

+ (UIColor *)navBarBgColor{
    return NTColor(123, 237, 237);
}

+ (UIColor *)ramdomColor{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.45;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.45;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}




@end
