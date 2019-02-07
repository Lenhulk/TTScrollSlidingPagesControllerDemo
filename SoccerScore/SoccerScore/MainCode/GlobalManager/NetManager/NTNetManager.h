//
//  NTNetManager.h
//  Nativer
//
//  Created by 大雄 on 2018/6/9.
//  Copyright © 2018年 NITI. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, NTRequestType) {
    // 新闻
    NTRequestTypeMyNewsList = 0,
    NTRequestTypeMycmNewsList,
    // jr比分
    NTRequestTypeGamesScoreList,  //列表
    NTRequestTypeGameAnalyzeOne, //内页
    NTRequestTypeGameOddsData,   //内页-赔率
    NTRequestTypeGameAnalyzeHistory     //内页-分析-最近战绩
};

@interface NTNetManager : NSObject

//单例方法
+ (instancetype)sharedManager;

- (void)getDataWithType:(NTRequestType)type
             parameters:(id)parm
                success:(void (^)(id))success
                failure:(void (^)(NSError *))failure;

- (void)postDataWithType:(NTRequestType)type
                  parameters:(id)parm
                     success:(void (^)(id))success
                     failure:(void (^)(NSError *))failure;


 
 
@end
