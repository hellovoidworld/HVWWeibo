//
//  HVWRegexResult.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/3/25.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HVWRegexResult : NSObject

/** 匹配字符串 */
@property(nonatomic, copy) NSString *str;

/** 匹配位置 */
@property(nonatomic, assign) NSRange range;

/** 是否是表情 */
@property(nonatomic, assign, getter=isEmotion) BOOL emotion;

@end
