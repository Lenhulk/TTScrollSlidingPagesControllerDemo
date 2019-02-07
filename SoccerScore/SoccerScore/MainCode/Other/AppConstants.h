//
//  AppConstants.h
//  app28
//
//  Created by Neo on 2017/11/1.
//  Copyright © 2017年 Neo. All rights reserved.
//


#ifndef AppConstants_h
#define AppConstants_h


/////////////////////////// 系统 ///////////////////////////
#define kSystemVersion [[UIDevice currentDevice].systemVersion floatValue]
#define kDevice_Is_iPhoneX      ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPad         ([[UIDevice currentDevice].model isEqualToString:@"iPad"])
#define kAppDelegate            (AppDelegate *)[[UIApplication sharedApplication] delegate]


/////////////////////////// 屏幕适配 ///////////////////////////
#define kSCREEN_H              [UIScreen mainScreen].bounds.size.height
#define kSCREEN_W              [UIScreen mainScreen].bounds.size.width
#define kiPXBottom_M           34
#define kSTATUSBAR_H           [[UIApplication sharedApplication] statusBarFrame].size.height
#define kTABBAR_H              (kSTATUSBAR_H > 20 ? 49+kiPXBottom_M : 49)
#define kAPPTOPS_H             (kSTATUSBAR_H + 44)


/////////////////////////// SB&Nib文件 ///////////////////////////
#define kLoadNibWithName(name)  [[NSBundle mainBundle] loadNibNamed:([NSString stringWithFormat:@"%@", name]) owner:nil options:nil].firstObject
#define kLoadNibWithNameAndOwner(name, owner) [[NSBundle mainBundle] loadNibNamed:([NSString stringWithFormat:@"%@", name]) owner:owner options:nil].firstObject
#define kInstantiateStoryBoard(name) [[UIStoryboard storyboardWithName:name  bundle:nil] instantiateInitialViewController]


/////////////////////////// 颜色 ///////////////////////////
#define NTRGBAColor(r, g, b, a)     [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a)]
#define NTColor(r, g, b)            NTRGBAColor(r, g, b, 1)
#define kRandomColor                NTColor((arc4random_uniform(255)), (arc4random_uniform(255)), (arc4random_uniform(255)))


/////////////////////////// 缓存地址 ///////////////////////////
#define kCachePath          [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
#define kDocumentPath       [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define kLibraryPath        [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]


/////////////////////////// 偏好设置 ///////////////////////////
#define kUserDefault [NSUserDefaults standardUserDefaults]
#define kUd_UserAccout @"USER"
#define kUd_MyLike @"LIKE"


/////////////////////////// 通知 ///////////////////////////
#define kNotification [NSNotificationCenter defaultCenter]
#define kNc_ViewNeedRefreshWithNewData @"NeedsRefresh"


/////////////////////////// 便利方法 /////////////////////////////
#define kRADIANS_2_DEGREES(radians)     ((radians) * (180.0 / M_PI))    //弧度转角度
#define kDEGREES_2_RADIANS(angle)       ((angle) / 180.0 * M_PI)        //角度转弧度
#define kStr2Int(str)                   [(NSString*)str integerValue]
#define kNum2Int(num)                   [(NSNumber*)num integerValue]


#endif /* AppConstants_h */
