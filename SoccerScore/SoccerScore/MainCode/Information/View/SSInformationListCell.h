//
//  SSInformationListCell.h
//  SoccerScore
//
//  Created by 大雄 on 2018/6/27.
//  Copyright © 2018年 大雄. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kInfoCell_H (kSCREEN_W*5/9.0+42+5+5)

@class SSInformationModel;
@interface SSInformationListCell : UITableViewCell
@property (nonatomic, strong) SSInformationModel *model;
@end
