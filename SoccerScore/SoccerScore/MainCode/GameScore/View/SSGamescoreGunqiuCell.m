//
//  SSGamescoreGunqiuCell.m
//  SoccerScore
//
//  Created by 大雄 on 2018/6/28.
//  Copyright © 2018年 大雄. All rights reserved.
//

#import "SSGamescoreGunqiuCell.h"
#import "SSGamescoreModel.h"
#import <UIImageView+WebCache.h>
#import "NSObject+NTExtension.h"
#import <EventKit/EventKit.h>

@interface SSGamescoreGunqiuCell()
@property (weak, nonatomic) IBOutlet UILabel *leagueLb;
@property (weak, nonatomic) IBOutlet UILabel *matchTimeLb;
@property (weak, nonatomic) IBOutlet UILabel *stateDesLb;
@property (weak, nonatomic) IBOutlet UILabel *bcLb;
@property (weak, nonatomic) IBOutlet UIImageView *homeImgv;
@property (weak, nonatomic) IBOutlet UIImageView *awayImgv;
@property (weak, nonatomic) IBOutlet UILabel *homeTeamLb;
@property (weak, nonatomic) IBOutlet UILabel *awayTeamLb;
@property (weak, nonatomic) IBOutlet UILabel *homeScoreLb;
@property (weak, nonatomic) IBOutlet UILabel *awayScoreLb;
@property (weak, nonatomic) IBOutlet UIView *oddBgView;
@property (weak, nonatomic) IBOutlet UILabel *dxodd1;
@property (weak, nonatomic) IBOutlet UILabel *dxodd2;
@property (weak, nonatomic) IBOutlet UILabel *dxodd3;
@property (weak, nonatomic) IBOutlet UILabel *aodd1;
@property (weak, nonatomic) IBOutlet UILabel *aodd2;
@property (weak, nonatomic) IBOutlet UILabel *aodd3;
@property (weak, nonatomic) IBOutlet UIView *alertBgView;
@property (weak, nonatomic) IBOutlet UILabel *yellow1;
@property (weak, nonatomic) IBOutlet UILabel *yellow2;
@property (weak, nonatomic) IBOutlet UILabel *red1;
@property (weak, nonatomic) IBOutlet UILabel *red2;
@property (weak, nonatomic) IBOutlet UILabel *passTimeLb;

@property (nonatomic, strong) NSDate *gameDate;
@end

@implementation SSGamescoreGunqiuCell

- (NSDate *)gameDate{
    if (!_gameDate) {
        // 创建日历 -> 关联component - 根据model生成gameDate - 记录到提醒事项
        NSDate *date = [NSDate date];
        NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour fromDate:date];
        NSString *hmStr = self.model.matchTime;
        NSInteger matchHour = [[hmStr componentsSeparatedByString:@":"].firstObject integerValue];
        // 判断是否在凌晨（第二天）的时间
        if (comp.hour > matchHour) {
            comp.day += 1;
        }
        NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
        // 判断comp.day是否超出改该月
        if (comp.day > range.length) {
            comp.day = 1;
            comp.month += 1;
        }
        // 设置闹钟时间咯
        comp.hour = matchHour;
        comp.minute = [[hmStr componentsSeparatedByString:@":"].lastObject integerValue];
        NSDate *newDate = [calendar dateFromComponents:comp];
        _gameDate = newDate;
        
    }
    return _gameDate;
}

- (void)setModel:(SSGamescoreModel *)model{
    _model = model;
    
    _leagueLb.text = model.bfZqLeague[@"gb"];
    _matchTimeLb.text = model.matchTime;
    _stateDesLb.text = model.stateDesb;
    if([model.stateDesb isEqualToString:@"完场"]) {
        _stateDesLb.textColor = [UIColor redColor];
    } else if ([model.stateDesb isEqualToString:@"未开"]) {
        _stateDesLb.textColor = [UIColor grayColor];
    } else {
        _stateDesLb.textColor = NTColor(48, 109, 160);
    }
    
    _bcLb.text = [NSString stringWithFormat:@"半场 %@-%@", model.bc1, model.bc2];
    NSNumber *passNum = model.passTime;
    if (passNum.integerValue < 0) {
        _passTimeLb.text = @"";
    } else {
        _passTimeLb.text = [NSString stringWithFormat:@"%ld'", passNum.integerValue+1];
    }
    
    NSDictionary *teamAway = model.bfZqTeamAway;
    _awayTeamLb.text = teamAway[@"gs"];
    [_awayImgv sd_setImageWithURL:[NSURL URLWithString:teamAway[@"flags"]] placeholderImage:[UIImage imageNamed:@"appiicon_ball"]];
    NSDictionary *teamHome = model.bfZqTeamHome;
    _homeTeamLb.text = teamHome[@"g"];
    [_homeImgv sd_setImageWithURL:[NSURL URLWithString:teamHome[@"flag"]] placeholderImage:[UIImage imageNamed:@"appiicon_ball"]];
    
    _homeScoreLb.text = [NSString stringWithFormat:@"%@", model.homeScore];
    _awayScoreLb.text = [NSString stringWithFormat:@"%@", model.awayScore];
    
    NSArray *dxOdds = [model.dxodds componentsSeparatedByString:@","];
    _dxodd1.text = dxOdds[0];
    _dxodd2.text = dxOdds[1];
    _dxodd3.text = dxOdds[2];
    NSArray *aodds = [model.aodds componentsSeparatedByString:@","];
    _aodd1.text = aodds[0];
    _aodd2.text = aodds[1];
    _aodd3.text = aodds[2];
    
    _yellow1.text = [NSString stringWithFormat:@"%@", model.yellow1];
    _yellow2.text = [NSString stringWithFormat:@"%@", model.yellow2];
    _red1.text = [NSString stringWithFormat:@"%@", model.red1];
    _red2.text = [NSString stringWithFormat:@"%@", model.red2];
    _yellow1.hidden = !(model.yellow1.integerValue);
    _yellow2.hidden = !(model.yellow2.integerValue);
    _red1.hidden = !(model.red1.integerValue);
    _red2.hidden = !(model.red2.integerValue);
    
    // 根据state判断状态
    if ([model.state isEqualToString:@"0"]) {
        self.alertBgView.hidden = NO;
    } else {
        self.alertBgView.hidden = YES;
    }
    
    if ([model.state isEqualToString:@"3"]) {
        self.passTimeLb.hidden = NO;
    } else {
        self.passTimeLb.hidden = YES;
    }
}

- (IBAction)tapNotificationBellBtn:(id)sender {

    NSString *notiStr = [NSString stringWithFormat:@"别忘了 %@VS%@ 的球赛哦！", _awayTeamLb.text, _homeTeamLb.text];
    [self addReminderNotify:self.gameDate title:notiStr];
}

-(void)addEventNotify:(NSDate *)date title:(NSString *)title
{
    //生成事件数据库对象
    EKEventStore *eventDB = [[EKEventStore alloc] init];
    
    //申请事件类型权限
    [eventDB requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
        
        if (granted) { //授权是否成功
            EKEvent *myEvent  = [EKEvent eventWithEventStore:eventDB]; //创建一个日历事件
            myEvent.title     = title;  //标题
            myEvent.startDate = date; //开始date   required
            myEvent.endDate   = date;  //结束date    required
            [myEvent addAlarm:[EKAlarm alarmWithAbsoluteDate:date]]; //添加一个闹钟  optional
            [myEvent setCalendar:[eventDB defaultCalendarForNewEvents]]; //添加calendar  required
            NSError *err;
            [eventDB saveEvent:myEvent span:EKSpanThisEvent error:&err]; //保存
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"请开启日历权限才可添加通知"];
            });
        }
        
    }];
    
}

-(void)addReminderNotify:(NSDate *)date title:(NSString *)title
{
    EKEventStore *eventDB = [[EKEventStore alloc] init];
    //申请提醒权限
    [eventDB requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError * _Nullable error) {
        
        if (granted) {
            
            //创建一个提醒功能
            EKReminder *reminder = [EKReminder reminderWithEventStore:eventDB];
            
            //标题
            reminder.title = title;
            //添加日历
            [reminder setCalendar:[eventDB defaultCalendarForNewReminders]];
            
            NSCalendar *cal = [NSCalendar currentCalendar];
//            [cal setTimeZone:[NSTimeZone systemTimeZone]];
            [cal setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"]];
            
            NSInteger flags = NSCalendarUnitYear | NSCalendarUnitMonth |
            NSCalendarUnitDay |NSCalendarUnitHour | NSCalendarUnitMinute |
            NSCalendarUnitSecond;
            NSDateComponents* dateComp = [cal components:flags fromDate:date];
            dateComp.timeZone = [NSTimeZone systemTimeZone];
            reminder.startDateComponents = dateComp; //开始时间
            reminder.dueDateComponents = dateComp; //到期时间
            reminder.priority = 1; //优先级
            EKAlarm *alarm = [EKAlarm alarmWithAbsoluteDate:date]; //添加一个车闹钟
            [reminder addAlarm:alarm];
            NSError *err;
            [eventDB saveReminder:reminder commit:YES error:&err];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [MBProgressHUD showSuccess:@"添加提醒事项成功！"];
            });
            
            if (err) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [MBProgressHUD showError:[NSString stringWithFormat:@"添加通知失败：%@", err.localizedDescription]];
                });
            }
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [MBProgressHUD showError:@"请开启日历权限才可添加通知"];
            });
        }
        
    }];
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
