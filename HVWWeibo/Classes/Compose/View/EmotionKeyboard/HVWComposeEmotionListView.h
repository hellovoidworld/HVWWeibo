//
//  HVWComposeEmotionListView.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/3/23.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ComposeEmotionColumnCount 7
#define ComposeEmotionRowCount 3
#define ComposeEmotionListMaxCount (ComposeEmotionColumnCount * ComposeEmotionRowCount - 1)

@interface HVWComposeEmotionListView : UIView

/** 表情数组 */
@property(nonatomic, strong) NSArray *emotions;

@end
