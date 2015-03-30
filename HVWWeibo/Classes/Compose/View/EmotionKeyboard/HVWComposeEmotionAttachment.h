//
//  HVWComposeEmotionAttachment.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/3/24.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HVWEmotion.h"

@interface HVWComposeEmotionAttachment : NSTextAttachment

@property(nonatomic, strong) HVWEmotion *emotion;

@end
