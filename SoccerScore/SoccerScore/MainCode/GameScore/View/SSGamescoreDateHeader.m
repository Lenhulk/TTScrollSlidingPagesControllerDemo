//
//  SSGamescoreDateHeader.m
//  SoccerScore
//
//  Created by 大雄 on 2018/6/30.
//  Copyright © 2018年 大雄. All rights reserved.
//

#import "SSGamescoreDateHeader.h"

@interface SSGamescoreDateHeader ()
@property (nonatomic, strong) NSDateFormatter *ymdFmt;
@property (weak, nonatomic) IBOutlet UILabel *dateLb;
@end

@implementation SSGamescoreDateHeader

- (NSDateFormatter *)ymdFmt{
    if (!_ymdFmt) {
        _ymdFmt = [[NSDateFormatter alloc] init];
        _ymdFmt.dateFormat = @"yyyy 年 MM 月 dd 日";
        _ymdFmt.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    }
    return _ymdFmt;
}

- (void)setIsWanchang:(BOOL)isWanchang{
    _isWanchang = isWanchang;
    // 日期是今天
    if (isWanchang) {
        self.dateLb.text = [self.ymdFmt stringFromDate:[NSDate date]];
        
    // 日期是明天
    } else {
        NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
        comp.day += 1;
        NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
        // 判断comp.day是否超出改该月
        if (comp.day > range.length) {
            comp.day = 1;
            comp.month += 1;
        }
        NSDate *date = [calendar dateFromComponents:comp];
        self.dateLb.text = [self.ymdFmt stringFromDate:date];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
