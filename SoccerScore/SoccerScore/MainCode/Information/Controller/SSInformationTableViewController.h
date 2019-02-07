//
//  SSInformationTableViewController.h
//  SoccerScore
//
//  Created by 大雄 on 2018/6/28.
//  Copyright © 2018年 大雄. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTUITableViewZoomController.h"

typedef NS_ENUM(NSUInteger, SSInfoType) {
    SSInfoTypeSport = 0,
    SSInfoTypeWorldCup,
    SSInfoTypeNBA,
    SSInfoTypeYule
};

@interface SSInformationTableViewController : TTUITableViewZoomController
@property (nonatomic, assign) SSInfoType iftype;
- (instancetype)initWithType:(SSInfoType)type;
@end
