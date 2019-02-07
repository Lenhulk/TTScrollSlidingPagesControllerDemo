//
//  UserManager.m
//  Nativer
//
//  Created by Lenhulk on 2018/5/18.
//  Copyright © 2018年 NITI. All rights reserved.
//

#import "UserManager.h"
#import "UserModel.h"
#import <AFNetworking.h>

@interface UserManager()
@property (nonatomic, strong) AFHTTPSessionManager *sessionMgr;
@end

@implementation UserManager
static NSString *errorDomain = @"com.ntNativer.UserManager.ErrorDomain";
static NSString *loginUrl = @"http://wsdsuo.com/FApi/Login/UserLogin";
static NSString *registerUrl = @"http://wsdsuo.com/FApi/Register/Register";

#pragma mark - LazyLoad
- (AFHTTPSessionManager *)sessionMgr{
    if (!_sessionMgr) {
        _sessionMgr = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        // 错误？
//            AFHTTPResponseSerializer *responSerializer = [AFHTTPResponseSerializer serializer];
//            responSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
//                                                       @"text/html",
//                                                       @"text/json",
//                                                       @"text/javascript",
//                                                       @"text/plain",nil];
//            _sessionMgr.responseSerializer = responSerializer;
//
//            AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
////            [requestSerializer setValue:@"multipart/form-data" forKey:@"Content-Type"]; //？no need now?
//            _sessionMgr.requestSerializer = requestSerializer;
        
        // 正确
        AFJSONResponseSerializer *responSerializer = [AFJSONResponseSerializer serializer];
        responSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                   @"application/json",
                                                   @"text/html",
                                                   @"text/json",
                                                   @"text/javascript",
                                                   @"text/plain",
                                                   nil];
        _sessionMgr.responseSerializer = responSerializer;
        
        _sessionMgr.requestSerializer = [AFJSONRequestSerializer serializer];
        [_sessionMgr.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    }
    return _sessionMgr;
}

#pragma mark - Singleton
static id _instance = nil;

+ (instancetype)sharedManager{
    return [[self alloc] init];
}
//alloc会调用allocWithZone
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (instancetype)init{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super init];
    });
    return _instance;
}

//copy在底层 会调用copyWithZone:
- (id)copyWithZone:(NSZone *)zone{
    return  _instance;
}
- (id)mutableCopyWithZone:(NSZone *)zone{
    return _instance;
}


#pragma mark - Main Function (Private)
// 判断是否在手机有登陆
- (BOOL)isLogin{
    UserModel *model = [self getLocalUserInfo];   //不需判断有没有
    return model.isLogin;
}

// 保存/刷新 用户信息到本地
- (void)setupNewModel2Local:(UserModel *)model{
    NSData *nData = [NSKeyedArchiver archivedDataWithRootObject:model];
    [kUserDefault setObject:nData forKey:kUd_UserAccout];
    [kUserDefault synchronize];
}


#pragma mark - Main Function (Public)
- (NSString *)getDeviceUUID{
    NSString *uuidStr = [[UIDevice currentDevice] identifierForVendor].UUIDString;
    return uuidStr;
}

- (id)getLocalUserInfo{
    NSData *data = [kUserDefault objectForKey:kUd_UserAccout];
    if (data != nil) {
        UserModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        return model;
    } else {
        return nil;
    }
}

- (void)logoutCurrentUser{
    UserModel *model = [self getLocalUserInfo];
    if (model) {
        model.isLogin = NO;
        [self setupNewModel2Local:model];
    }
}


//  ******************************************* 登录 **************************************************
- (void)loginWithRawUserModel:(UserModel *)model success:(void (^)(UserModel *))success failure:(void (^)(NSError *))failure{
    // 1.判断本地是否有保存用户信息 -> 如果有 修改isLogin == YES
    UserModel *user = [self getLocalUserInfo];
    if (![user isKindOfClass:[NSNull class]]) {
        if ([user.user_id isEqualToString:model.user_id]) {
            model.isLogin = YES;
            if (success) {
                success(user);
            }
            return;
        }
    }
    
    // 2.如果没有 发送到服务器登录 设置isLogin == YES
    NSDictionary *parsDict = @{@"username":model.fiction_username==nil?@"":model.fiction_username,
                               @"email":model.user_email==nil?@"":model.user_email,
                               @"mobile":model.user_mobile==nil?@"":model.user_mobile,
                               @"password":model.user_password};
    
    NSString *testUrl = @"http://api.jinribifenjiekou.com/bfZqMatch/findAllMatch";
    NSDictionary *parm = @{@"object":@"eyJjb3VudFBlclBhZ2UiOjIwLCJzZW5kVHlwZSI6IjQiLCJpc1BhZ2UiOiIyIiwibGVhZ3VlSWRzIjpudWxsLCJwYWdlTm8iOjF9",
                           @"sign":@"1368ec3f877e033398aa2aa2ff0c9fd7"
                           };
    
    [self.sessionMgr POST:loginUrl parameters:parsDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        NTLog(@"%@登录信息",responseObject);
        //判断登录成功还是失败
        if ([responseObject[@"code"] isEqualToString:@"1"]) {
            NSDictionary *dataDict = responseObject[@"data"];
            model.user_id = dataDict[@"id"];
            model.user_email = dataDict[@"user_email"];
            model.user_mobile = dataDict[@"user_mobile"];
            model.fiction_username = dataDict[@"fiction_username"];
            model.isLogin = YES;
            [self setupNewModel2Local:model];
            if (success) {
                success(model);
            }

        } else {
            NSError *error = [NSError errorWithDomain:errorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey:responseObject[@"msg"]}];
            if (failure) {
                failure(error);
            }
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NTLog(@"登录失败，网络错误:%@", error.localizedDescription);
        NSError *myError = [NSError errorWithDomain:errorDomain code:0 userInfo:@{NSLocalizedDescriptionKey:@"网络错误 稍后尝试"}];
        if (failure) {
            failure(myError);
        }
    }];
}


//  ******************************************* 注册 **************************************************
- (void)registerWithRawModel:(UserModel *)model success:(void (^)(UserModel *))success failure:(void (^)(NSError *))failure{
    // 1.判断本地是否有保存用户信息 -> 如果有 提示已经存在用户
    UserModel *user = [self getLocalUserInfo];
    if (![user isKindOfClass:[NSNull class]]) {
        if ([user.user_id isEqualToString:model.user_id]) {
            if (failure) {
                NSError *myError = [NSError errorWithDomain:errorDomain code:0 userInfo:@{NSLocalizedDescriptionKey:@"该用户已存在 可直接登录"}];
                failure(myError);
            }
            return;
        }
    }
    
    // 2.发送到服务器 注册 获取返回的用户信息
    NSDictionary *parm = @{@"username":model.fiction_username,
                           @"email":model.user_email==nil?@"":model.user_email,
                           @"mobile":model.user_mobile==nil?@"":model.user_mobile,
                           @"password":model.user_password,
                           @"uuid":[self getDeviceUUID]};
    [self.sessionMgr POST:registerUrl parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NTLog(@"注册成功：%@", responseObject);
        //判断注册成功还是失败： 成功 -> 设置登录，保存到本地
        if ([responseObject[@"code"] isEqualToString:@"1"]) {
            model.isLogin = YES;
            [self setupNewModel2Local:model];
            if (success) {
                success(model);
            }
            
        } else if ([responseObject[@"code"] isEqualToString:@"-1"]) {
            NTLog(@"注册失败：%@", responseObject[@"msg"]);
            NSError *error = [NSError errorWithDomain:errorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey:responseObject[@"msg"]}];
            if (failure) {
                failure(error);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NTLog(@"注册失败，网络错误：%@", error.localizedDescription);
        if (failure) {
            failure(error);
        }
    }];
}


//TODO: 修改用户信息 -> 发送到服务器

//- (void)renameUser:(NSString *)newName{
//    UserModel *model = [self getUserInfo];
//    model.userName = newName;
//    [self setupNewModel:model];
//}

//- (void)reloadUserHeadIcon:(NSString *)picPath{
//    UserModel *model = [self getUserInfo];
//    model.userIcon = picPath;
//    [self setupNewModel:model];
//}





@end
