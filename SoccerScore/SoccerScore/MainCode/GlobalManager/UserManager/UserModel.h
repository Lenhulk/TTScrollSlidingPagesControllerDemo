//
//  UserModel.h
//  Nativer
//
//  Created by Lenhulk on 2018/5/18.
//  Copyright © 2018年 NITI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject <NSCoding>

// 用户通过输入框输入
@property (nonatomic, copy) NSString *fiction_username;
@property (nonatomic, copy) NSNumber *user_mobile;
@property (nonatomic, copy) NSString *user_email;
@property (nonatomic, copy) NSString *user_password;

// 服务器生成
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *user_heaer; //头像图片的URL地址

// 自动获取
@property (nonatomic, copy) NSString *user_uuid;

// 设置后会保存
@property (assign, nonatomic) BOOL isLogin;

// 暂时无用
@property (nonatomic, strong) NSArray *user_likes;

//TODO: 增加头像url地址？

+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end
