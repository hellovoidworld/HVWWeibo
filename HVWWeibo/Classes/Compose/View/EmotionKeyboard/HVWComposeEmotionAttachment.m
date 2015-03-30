//
//  HVWComposeEmotionAttachment.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/3/24.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWComposeEmotionAttachment.h"

@implementation HVWComposeEmotionAttachment

- (void)setEmotion:(HVWEmotion *)emotion {
    _emotion = emotion;
    
    NSString *imagePath = [emotion.directory stringByAppendingPathComponent:emotion.png];
    self.image = [UIImage imageWithNamed:imagePath];
}

@end
