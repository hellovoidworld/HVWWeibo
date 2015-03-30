//
//  HVWEmotion.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/3/23.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWEmotion.h"
#import "NSString+Emoji.h"

@implementation HVWEmotion

- (void)setCode:(NSString *)code {
    _code = [code copy];
    if (code) {
        _emoji = [NSString emojiWithStringCode:code];
    }
}

/** 重写比较方法 */
- (BOOL)isEqual:(HVWEmotion *)otherEmotion {
    if (self.type == EmotionTypeEmoji) { // emoji表情符号
        return [self.code isEqualToString:otherEmotion.code];
    } else { // 普通图片表情
        return [self.chs isEqualToString:otherEmotion.chs];
    }
}

#pragma mark - NSCoding
/** 解码 */
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.type = [(NSNumber *)[decoder decodeObjectForKey:@"type"] intValue];
        self.chs = [decoder decodeObjectForKey:@"chs"];
        self.cht = [decoder decodeObjectForKey:@"cht"];
        self.png = [decoder decodeObjectForKey:@"png"];
        self.code = [decoder decodeObjectForKey:@"code"];
        self.emoji =  [decoder decodeObjectForKey:@"emoji"];
        self.directory = [decoder decodeObjectForKey:@"directory"];
    }
    return self;
}

/** 编码 */
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:[NSNumber numberWithInt:self.type] forKey:@"type"];
    [encoder encodeObject:self.chs forKey:@"chs"];
    [encoder encodeObject:self.cht forKey:@"cht"];
    [encoder encodeObject:self.png forKey:@"png"];
    [encoder encodeObject:self.code forKey:@"code"];
    [encoder encodeObject:self.emoji forKey:@"emoji"];
    [encoder encodeObject:self.directory forKey:@"directory"];
}

@end
