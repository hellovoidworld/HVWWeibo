//
//  HVWEmotionTool.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/3/24.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HVWEmotion.h"

@interface HVWEmotionTool : NSObject

/** 默认表情 */
+ (NSArray *) defaultEmotions;

/** emoji表情 */
+ (NSArray *) emojiEmotions;

/** 浪小花表情 */
+ (NSArray *) lxhEmotions;

/** 最近表情 */
+ (NSMutableArray *) recentEmotions;

/** 添加最近表情 */
+ (void) addRecentEmotions:(HVWEmotion *)emotion;

/** 根据表情名称返回表情 */
+ (HVWEmotion *) emotionWithDesc:(NSString *)desc;

@end
