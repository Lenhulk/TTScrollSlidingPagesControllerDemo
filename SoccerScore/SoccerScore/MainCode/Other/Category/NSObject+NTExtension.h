//
//  NSObject+AFExtension.h
//  AddFriendsDB
//
//  Created by apple004 on 2017/8/1.
//  Copyright © 2017年 test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (NTExtension)

/* 递归找最上面的viewController */
- (UIViewController *)topViewController;

/* 获取当前window */
- (UIWindow *)getCurrentWindow;

/* 查找当前的TabBarController */
- (UITabBarController *)mainTabBarController;

/**将字符串转化为控制器*/
- (UIViewController*)stringChangeToClass:(NSString *)str;


@end
