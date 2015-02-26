//
//  HVWStatusRetweetedFrame.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/12.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWStatusRetweetedFrame.h"

@implementation HVWStatusRetweetedFrame

/** 加载微博数据 */
- (void)setStatus:(HVWStatus *)status {
    _status = status;
    
    // 设置控件frame
    // 昵称
    CGFloat nameX = HVWStatusCellInset;
    CGFloat nameY = HVWStatusCellInset;
    CGSize nameBoundSize = CGSizeMake(HVWScreenWidth - nameX * 2, MAXFLOAT);
    NSDictionary *nameBoundParam = @{NSFontAttributeName : HVWStatusOriginalNameFont};
    CGSize nameSize = [[status retweetedName] boundingRectWithSize:nameBoundSize options:NSStringDrawingUsesLineFragmentOrigin attributes:nameBoundParam context:nil].size;
    self.nameFrame =  (CGRect){{nameX, nameY}, nameSize};
    
    // 正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(self.nameFrame);
    CGSize textBoundSize = CGSizeMake(HVWScreenWidth - textX * 2, MAXFLOAT);
    NSDictionary *textBoundParam = @{NSFontAttributeName : HVWStatusOriginalTextFont};
    CGSize textSize = [status.text boundingRectWithSize:textBoundSize options:NSStringDrawingUsesLineFragmentOrigin attributes:textBoundParam context:nil].size;
    self.textFrame = (CGRect){{textX, textY}, textSize};
    
    // 设置自己的frame
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = HVWScreenWidth;
    CGFloat height = CGRectGetMaxY(self.textFrame) + HVWStatusCellInset;
    self.frame = CGRectMake(x, y, width, height);
}

@end
