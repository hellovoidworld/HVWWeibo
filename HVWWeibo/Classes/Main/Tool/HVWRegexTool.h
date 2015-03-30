//
//  HVWRegexTool.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/3/30.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    HVWRegexTypeNormal,
    HVWRegexTypeMention,
    HVWRegexTypeSubject,
    HVWRegexTypeHref
}HVWRegexType;

@interface HVWRegexTool : NSObject

/** @的正则表达式 */
+ (NSString *) mentionRegex;

/** 话题的正则表达式 */
+ (NSString *) subjectRegex;

/** 超链接的正则表达式 */
+ (NSString *) hrefRegex;

/** 返回匹配到的文本正文 */
+ (NSString *) textWithRegexString:(NSString *)string type:(HVWRegexType)type;

/** 检测文本类型 */
+ (HVWRegexType) typeWithRegexString:(NSString *)regexString;

@end
