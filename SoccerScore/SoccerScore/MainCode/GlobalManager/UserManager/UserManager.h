//
//  UserManager.h
//  Nativer
//
//  Created by Lenhulk on 2018/5/18.
//  Copyright © 2018年 NITI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface UserManager : NSObject

// 是否登录
@property (nonatomic, assign) BOOL isLogin;

//单例方法
+ (instancetype)sharedManager;

// 获取UUID
- (NSString *)getDeviceUUID;

// 获取本地保存用户信息
- (id)getLocalUserInfo;

// 注册
- (void)registerWithRawModel:(UserModel *)model
                     success:(nullable void (^)(UserModel *completeModel))success
                     failure:(nullable void (^)(NSError *error))failure;

// 登录
- (void)loginWithRawUserModel:(UserModel *)model
                      success:(nullable void (^)(UserModel *completeModel))success
                      failure:(nullable void (^)(NSError *error))failure;
// 登出
- (void)logoutCurrentUser;





@end
