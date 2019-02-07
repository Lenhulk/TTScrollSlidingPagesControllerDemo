//
//  AppUtils.h
//  app28
//
//  Created by Neo on 2017/11/1.
//  Copyright © 2017年 Neo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppConstants.h"

static inline void delay(NSTimeInterval delay, dispatch_block_t block) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

@interface AppUtils : NSObject

+ (void)setApplicationAppearence;

/**
 App主色
 */
+ (UIColor *)dominantColor;
/**
 导航栏背景色（不用）
 */
+ (UIColor *)navBarBgColor;
/**
 浅灰色背景（系统的silver）
 */
+ (UIColor *)lightGrayBgColor;
/**
 返回一个除黑白的随机颜色
 */
+ (UIColor *)ramdomColor;
+ (UIColor *)textDarkGrayColor;



@end
