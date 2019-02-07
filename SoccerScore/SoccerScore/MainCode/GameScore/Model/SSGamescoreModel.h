//
//  SSGamescoreModel.h
//  SoccerScore
//
//  Created by 大雄 on 2018/6/27.
//  Copyright © 2018年 大雄. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSGamescoreModel : NSObject <NSCoding>

// 比赛类型
//"gb":"球会友谊"
@property (nonatomic, strong) NSDictionary *bfZqLeague;
// 客场球队
//"flags": "http://zq.win007.com/Image/team/images/2013120125538.jpg",
//"gs": "沙尔克04B队"
@property (nonatomic, strong) NSDictionary *bfZqTeamAway;
// 主场球队
//"flag": "http://zq.win007.com/Image/team/",
//"g": "尔肯卫克"
@property (nonatomic, strong) NSDictionary *bfZqTeamHome;

// 滚球才显示赔率
// 右赔率?
@property (nonatomic, copy) NSString *aodds;
// 左赔率？
@property (nonatomic, copy) NSString *dxodds;

// 客场球队id
@property (nonatomic, copy) NSString *awayId;
// 主场球队id
@property (nonatomic, copy) NSString *homeId;
// 全场比分
@property (nonatomic, strong) NSNumber *homeScore;  //主队
@property (nonatomic, strong) NSNumber *awayScore;  //客队
// 半场比分
@property (nonatomic, strong) NSNumber *bc1;        //主队
@property (nonatomic, strong) NSNumber *bc2;        //客队
// 比赛id
@property (nonatomic, strong) NSNumber *matchId;
// 黄牌
@property (nonatomic, strong) NSNumber *yellow1;
@property (nonatomic, strong) NSNumber *yellow2;
// 红牌
@property (nonatomic, strong) NSNumber *red1;
@property (nonatomic, strong) NSNumber *red2;
// 联盟id
@property (nonatomic, strong) NSNumber *leagueId;
// 开赛时间 （可用于添加到日历）
@property (nonatomic, copy) NSString *matchTime;
// *滚球和完场时 （上半场之类的）  显示在matchTime后面
@property (nonatomic, copy) NSString *stateDesb;
// *“即时数据”使用（101'） 显示在matchTime后面   否则数据是-1
@property (nonatomic, strong) NSNumber *passTime;
// state == 0 未开
// state == -1 完场
// state == 1 在进行
// state == 3 正在进行
@property (nonatomic, copy) NSString *state;

// 关联用户是否关注这场比赛 默认是2
@property (nonatomic, strong) NSNumber *isAttention;


@end
