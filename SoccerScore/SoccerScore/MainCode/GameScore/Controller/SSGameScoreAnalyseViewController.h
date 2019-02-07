//
//  SSGameScoreAnalyseViewController.h
//  SoccerScore
//
//  Created by 大雄 on 2018/7/1.
//  Copyright © 2018年 大雄. All rights reserved.
//

#import "BaseViewController.h"
@class SSGamescoreModel;

typedef NS_ENUM(NSUInteger, SSGameAnalyzeType) {
    SSGameAnalyzeTypeHistory = 1, //可用于oddsType
    SSGameAnalyzeTypeGrade = 2,
};


@interface SSGameScoreAnalyseViewController : BaseViewController

@property (nonatomic, strong) SSGamescoreModel *model;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil matchId:(NSNumber *)matchId;

@end
