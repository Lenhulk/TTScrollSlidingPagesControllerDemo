//
//  SSGameScoreTableViewController.h
//  SoccerScore
//
//  Created by 大雄 on 2018/6/27.
//  Copyright © 2018年 大雄. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTUITableViewZoomController.h"

typedef NS_ENUM(NSUInteger, SSGameScoreType) {
    SSGameScoreTypeGunqiu = 0,
    SSGameScoreTypeJishi,
    SSGameScoreTypeWanchang,
    SSGameScoreTypeSaicheng
};

@interface SSGameScoreTableViewController : TTUITableViewZoomController
@property (nonatomic, assign) SSGameScoreType gstype;
- (instancetype)initWithType:(SSGameScoreType)type;

@end
