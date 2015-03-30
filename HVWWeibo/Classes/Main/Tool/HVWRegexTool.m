//
//  HVWRegexTool.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/3/30.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWRegexTool.h"
#import "RegexKitLite.h"

@implementation HVWRegexTool

/** @的正则表达式 */
+ (NSString *) mentionRegex {
    return @"@[0-9a-zA-Z\\u4e00-\\u9fa5\\-_]+";
}

/** 话题的正则表达式 */
+ (NSString *) subjectRegex {
    return @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
}

/** 超链接的正则表达式 */
+ (NSString *) hrefRegex {
    return @"http(s)?://([a-zA-Z|\\d]+\\.)+[a-zA-Z|\\d]+(/[a-zA-Z|\\d|\\-|\\+|_./?%&=]*)?";
}

/** 返回匹配到的文本正文 */
+ (NSString *) textWithRegexString:(NSString *)string type:(HVWRegexType)type {
    NSString *text = nil;
    switch (type) {
        case HVWRegexTypeMention:
            text = [string stringByReplacingOccurrencesOfString:@"@" withString:@""];
            break;
        case HVWRegexTypeSubject:
            [string stringByReplacingOccurrencesOfString:@"#" withString:@""];
            break;
        case HVWRegexTypeHref:
            text = string;
            break;
        default:
            break;
    }
    
    return text;
}

/** 检测文本类型 */
+ (HVWRegexType) typeWithRegexString:(NSString *)regexString {
    if ([regexString isMatchedByRegex:[self mentionRegex]]) { // @
        return HVWRegexTypeMention;
    } else if ([regexString isMatchedByRegex:[self subjectRegex]]) { // 主题
        return HVWRegexTypeSubject;
    } else if ([regexString isMatchedByRegex:[self hrefRegex]]) { // 超链接
        return HVWRegexTypeHref;
    }
    
    return HVWRegexTypeNormal;
}

@end
