//
//  NSString+ResignExtension.h
//  GuaGuaLe
//
//  Created by Neo on 2018/3/9.
//  Copyright © 2018年 Neo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ResignExtension)

///正则匹配手机号
- (BOOL)checkTelNumber;

///正则匹配用户密码6-15位数字和字母组合
- (BOOL)checkPassword;

///正则匹配用户姓名,20位的中文或英文
- (BOOL)checkUserName;

@end
