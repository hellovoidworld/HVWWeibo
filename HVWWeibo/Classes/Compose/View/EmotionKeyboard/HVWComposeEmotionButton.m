//
//  HVWComposeEmotionButton.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/3/24.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWComposeEmotionButton.h"
#import "HVWEmotion.h"

@implementation HVWComposeEmotionButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeCenter;
        self.adjustsImageWhenHighlighted = NO;
        self.titleLabel.font = HVWComposeEmotionEmojiFont;
    }
    return self;
}

- (void)setEmotion:(HVWEmotion *)emotion {
    _emotion = emotion;
    
    if (emotion.type == EmotionTypeNormal) {
        NSString *imageDirectory = emotion.directory;
        NSString *imageResource = [imageDirectory stringByAppendingPathComponent:emotion.png];
        
        UIImage *emotionImage = [UIImage imageWithNamed:imageResource];
        [self setImage:emotionImage forState:UIControlStateNormal];
        
    } else if (emotion.type == EmotionTypeEmoji) {
        [self setTitle:emotion.emoji forState:UIControlStateNormal];
        // 设置emoji表情字体大小
        [self.titleLabel setFont:HVWStatusComposeEmojiFont];
    }
}

@end
