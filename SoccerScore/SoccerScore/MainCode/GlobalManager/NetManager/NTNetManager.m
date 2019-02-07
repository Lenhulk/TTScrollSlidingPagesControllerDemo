//
//  NTNetManager.m
//  Nativer
//
//  Created by 大雄 on 2018/6/9.
//  Copyright © 2018年 NITI. All rights reserved.
//

#import "NTNetManager.h"
#import <AFNetworking.h>
#import "SSGamescoreModel.h"
#import <MJExtension.h>

@interface NTNetManager()
@property (nonatomic, strong) AFHTTPSessionManager *sessionMgr;
@end

@implementation NTNetManager
static NSString * const errorDomain = @"com.ntNativer.NetManager.ErrorDomain";

// 需要参数 get
static NSString * const MyNewsListUrl = @"http://bjrec.m.163.com/flow/recsys/getComRecNews";
static NSString * const MyNewscmListUrl = @"https://c.m.163.com/dlist/article/dynamic";

// 需要 base64列表页参数+sign post
static NSString * const JrbfGamesScoreListUrl = @"http://api.jinribifenjiekou.com/bfZqMatch/findAllMatch";
static NSString * const JrbfGameAnalyzeOneUrl = @"http://api.jinribifenjiekou.com/bfZqMatch/findAnalyzeOneByMatchId";
// 需要 base64场次参数 post
static NSString * const JrbfGameOddsUrl = @"http://api.jinribifenjiekou.com/odds/get-odds";
static NSString * const JrbfGameAnalyzeHistoryUrl = @"http://api.jinribifenjiekou.com/bfZqMatch/findAnalyzeTwoByMatchId";

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


#pragma mark - LazyLoad
- (AFHTTPSessionManager *)sessionMgr{
    if (!_sessionMgr) {
        _sessionMgr = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
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


#pragma mark - Main Function (Private)
// data 转 json 字符串
- (NSString *)toJsonData:(id)theData{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    if (jsonData.length > 0) {
        return jsonStr;
    }else{
        return nil;
    }
}


#pragma mark - Main Function (Public)
- (void)getDataWithType:(NTRequestType)type parameters:(id)parm success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    NSString *urlStr = @"";
    if (type == NTRequestTypeMyNewsList) {
        urlStr = MyNewsListUrl;
    } else {
        urlStr = MyNewscmListUrl;
    }

    [self.sessionMgr GET:urlStr parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        NTLog(@"Request SUCCESS");
        
        if (responseObject != nil) {
            if (success) {
                success(responseObject);
            }

        } else {
//            NTLog(@"Request's Success But data Wrong:%@", responseObject);
            NSError *error = [NSError errorWithDomain:errorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey:responseObject[@"返回数据错误"]}];
            if (failure) {
                failure(error);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NTLog(@"Request's Network FAIL: %@", error.localizedDescription);
        if (failure) {
            failure(error);
        }
    }];
    
}

- (void)postDataWithType:(NTRequestType)type parameters:(id)parm success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    NSString *urlStr = @"";
    if (type == NTRequestTypeGamesScoreList) {
        urlStr = JrbfGamesScoreListUrl;
    } else if (type == NTRequestTypeGameOddsData) {
        urlStr = JrbfGameOddsUrl;
    } else if (type == NTRequestTypeGameAnalyzeOne) {
        urlStr = JrbfGameAnalyzeOneUrl;
    } else {
        urlStr = JrbfGameAnalyzeHistoryUrl;
    }
    
    [self.sessionMgr POST:urlStr parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        NTLog(@"======== Request SUCCESS ========");
        
        if ([responseObject[@"status"] integerValue] == 200) {
            // 返回Data 字典数组
            NSDictionary *objDict = responseObject[@"data"];
            NSArray *dictArr = objDict[@"object"];
            if (success) {
                success(dictArr);
            }
            
        } else {
            NTLog(@"Request success but data FAIL:%@", responseObject[@"msg"]);
            NSError *error = [NSError errorWithDomain:errorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey:responseObject[@"msg"]}];
            if (failure) {
                failure(error);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NTLog(@"Request's Network FAIL: %@", error.localizedDescription);
        if (failure) {
            failure(error);
        }
    }];
}



@end
