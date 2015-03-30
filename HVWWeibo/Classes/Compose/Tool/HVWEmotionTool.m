//
//  HVWEmotionTool.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/3/24.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWEmotionTool.h"
#import "MJExtension.h"

#define RecentEmotionFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"recent_emotions.data"]


@implementation HVWEmotionTool

static NSArray *_defaultEmotions;
static NSArray *_emojiEmotions;
static NSArray *_lxhEmotions;
static NSMutableArray *_recentEmotions;

/** 默认表情 */
+ (NSArray *) defaultEmotions {
    if (nil == _defaultEmotions) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        _defaultEmotions = [HVWEmotion objectArrayWithFile:filePath];
        [_defaultEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/default"];
        
//        NSString *p = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
//        HVWLog(@"%@", p);
    }
    
    return _defaultEmotions;
}

/** emoji表情 */
+ (NSArray *) emojiEmotions {
    if (nil == _emojiEmotions) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        _emojiEmotions = [HVWEmotion objectArrayWithFile:filePath];
        [_emojiEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/emoji"];
    }
    
    return _emojiEmotions;
}

/** 浪小花表情 */
+ (NSArray *) lxhEmotions {
    if (nil == _lxhEmotions) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        _lxhEmotions = [HVWEmotion objectArrayWithFile:filePath];
        [_lxhEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/lxh"];
    }
    
    return _lxhEmotions;
}

/** 最近表情 */
+ (NSMutableArray *) recentEmotions {
    if (nil == _recentEmotions) {
        _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:RecentEmotionFilePath];
        if (nil == _recentEmotions) {
        _recentEmotions = [NSMutableArray array];
        }
    }
    
    return _recentEmotions;
}

/** 添加最近表情 */
+ (void) addRecentEmotions:(HVWEmotion *)emotion {
    NSMutableArray *recentEmotions = [self recentEmotions];
    
    // 删掉旧的
    [recentEmotions removeObject:emotion];
    // 加入新的到最前头
    [recentEmotions insertObject:emotion atIndex:0];
    
    // 存储到沙盒中
    [NSKeyedArchiver archiveRootObject:recentEmotions toFile:RecentEmotionFilePath];
}

/** 根据表情名称返回表情 */
+ (HVWEmotion *) emotionWithDesc:(NSString *)desc {
    
    __block HVWEmotion *resultEmotion = nil;
    
    [[self defaultEmotions] enumerateObjectsUsingBlock:^(HVWEmotion *emotion, NSUInteger idx, BOOL *stop) {
        if ([desc isEqualToString:emotion.chs] || [desc isEqualToString:emotion.cht]) {
            resultEmotion = emotion;
            *stop = YES;
        }
    }];
    
    if (resultEmotion) return resultEmotion;
    
    [[self lxhEmotions] enumerateObjectsUsingBlock:^(HVWEmotion *emotion, NSUInteger idx, BOOL *stop) {
        if ([desc isEqualToString:emotion.chs] || [desc isEqualToString:emotion.cht]) {
            resultEmotion = emotion;
            *stop = YES;
        }
    }];
    
    return resultEmotion;
}


@end
