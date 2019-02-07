//
//  NSString+ResignExtension.m
//  GuaGuaLe
//
//  Created by Neo on 2018/3/9.
//  Copyright © 2018年 Neo. All rights reserved.
//

#import "NSString+ResignExtension.h"

@implementation NSString (ResignExtension)

/**********************************************
 正则表达式常见字符
 test            # 匹配包含test的字符串
 .               # 匹配除换行符外任意字符
 \               # 转义字符
 [abc]或[a-c]    # 匹配字符类，如例子匹配a,b,c中的任何一个
 [^abc]          # 匹配除了a,b,c以外的所有字符

 正则表达式特殊字符
 \d                  # 数字，等同于[0-9]
 \D                  # 非数字
 \s                  # 空白字符（包括换行、Tab等）
 \S                  # 非空白字符
 \w                  # 单词，等用于[a-zA-Z0-9_]
 \W                  # 非单词

 正则表达式数量词
 c*                  # 匹配字符"c" 0或无限次
 c+                  # 匹配字符"c" 1次以上
 c?                  # 匹配字符"c" 0或1次
 c{3}                # 匹配字符"c" 3次
 c{3,5}              # 匹配字符"c" 3到5次

 正则表达式边界匹配
 ^abc                # 匹配"abc"开头的字符串
 abc$                # 匹配"abc"结尾的字符串

 正则表达式逻辑或分组
 c|b                 # 匹配"c"或"b"
 (ab|cd)             # 匹配"ab"或"cd"
 (?P<name>abc)       # 匹配"abc"并命名为name
 (?P=name)           # 前文中的name组
 ***********************************************/

- (BOOL)checkTelNumber
{
    NSString *pattern = @"^1+[3578]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}


- (BOOL)checkPassword
{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,15}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;

}


- (BOOL)checkUserName
{
    NSString *pattern = @"^[a-zA-Z\u4E00-\u9FA5]{1,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
    
}

#pragma 正则匹配用户身份证号15或18位
+ (BOOL)checkUserIdCard
{
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

#pragma 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber
{
    NSString *pattern = @"^[0-9]{12}";

    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;

}

#pragma 正则匹配URL
+ (BOOL)checkURL
{
    NSString *pattern = @"^[0-9A-Za-z]{1,50}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}


@end
