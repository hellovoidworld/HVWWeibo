//
//  HVWEmotion.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/3/23.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    EmotionTypeNormal = 0,
    EmotionTypeEmoji = 1
} EmotionType;


@interface HVWEmotion : NSObject <NSCoding>

/** 简体表情描述 */
@property(nonatomic, copy) NSString *chs;

/** 繁体表情描述 */
@property(nonatomic, copy) NSString *cht;

/** gif文件名 */
@property(nonatomic, copy) NSString *gif;

/** png文件名 */
@property(nonatomic, copy) NSString *png;

/** 类型 */
@property(nonatomic, assign) int type;

/** emoji 编码 */
@property(nonatomic, copy) NSString *code;

/** emoji 字符 */
@property(nonatomic, copy) NSString *emoji;

/** 存放路径 */
@property(nonatomic, copy) NSString *directory;

@end
