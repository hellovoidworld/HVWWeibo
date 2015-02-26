//
//  NSDate+Extension.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/16.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

/** 是否今年 */
- (BOOL) isThisYear {
    // 日期对比
    NSDateComponents *comps = [self dateComponentsToNow];
    
    if (comps.year == 0) {
        return YES;
    } else {
        return NO;
    }
}

/** 是否今月 */
- (BOOL) isThisMonth {
    // 日期对比
    NSDateComponents *comps = [self dateComponentsToNow];
    
    if (comps.year == 0
        && comps.month == 0) {
        return YES;
    } else {
        return NO;
    }
}

/** 是否今日 */
- (BOOL) isToday {
    // 日期对比
    NSDateComponents *comps = [self dateComponentsToNow];
    
    if (comps.year == 0
        && comps.month == 0
        && comps.day == 0) {
        return YES;
    } else {
        return NO;
    }
}

/** 是否今个小时 */
- (BOOL) isThisHour {
    // 日期对比
    NSDateComponents *comps = [self dateComponentsToNow];
    
    if (comps.year == 0
        && comps.month == 0
        && comps.day == 0
        && comps.hour == 0) {
        return YES;
    } else {
        return NO;
    }

}

/** 是否刚刚(一分钟内) */
- (BOOL) isThisMinutes {
    // 日期对比
    NSDateComponents *comps = [self dateComponentsToNow];
    
    if (comps.year == 0
        && comps.month == 0
        && comps.day == 0
        && comps.hour == 0
        && comps.minute == 0) {
        return YES;
    } else {
        return NO;
    }
}

/** 返回指定日期的NSDataComponents
 * 包含年月日、小时、分钟
 */
- (NSDateComponents *) dateComponentsToNow {
    // 创建日期类
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 当前时间
    NSDate *now = [NSDate date];
    
    // 日期
    NSDateComponents *comps =  [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:self toDate:now options:0];
    
    return comps;
}

/** 返回年月日格式日期 */
- (NSString *) dateWithFormatYMD {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    return [fmt stringFromDate:self];
}

@end
