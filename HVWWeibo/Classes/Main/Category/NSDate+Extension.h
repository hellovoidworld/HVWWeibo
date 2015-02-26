//
//  NSDate+Extension.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/16.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

/** 是否今年 */
- (BOOL) isThisYear;

/** 是否今月 */
- (BOOL) isThisMonth;

/** 是否今日 */
- (BOOL) isToday;

/** 是否今个小时 */
- (BOOL) isThisHour;

/** 是否刚刚(一分钟内) */
- (BOOL) isThisMinutes;

/** 返回指定日期到当前时间的NSDataComponents
 * 包含年月日、小时、分钟
 */
- (NSDateComponents *) dateComponentsToNow;

/** 返回年月日格式日期 */
- (NSString *) dateWithFormatYMD;

@end
