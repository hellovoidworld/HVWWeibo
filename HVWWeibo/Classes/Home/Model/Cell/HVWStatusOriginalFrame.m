//
//  HVWStatusOriginalFrame.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/12.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWStatusOriginalFrame.h"

@implementation HVWStatusOriginalFrame

/** 加载微博数据 */
- (void)setStatus:(HVWStatus *)status {
    _status = status;
    
    // 设置控件frame
    // 头像
    CGFloat iconX = HVWStatusCellInset;
    CGFloat iconY = HVWStatusCellInset;
    CGFloat iconWidth = 35;
    CGFloat iconHeight = 35;
    self.iconFrame = CGRectMake(iconX, iconY, iconWidth, iconHeight);
    
    // 昵称
    CGFloat nameX = CGRectGetMaxX(self.iconFrame) + HVWStatusCellInset;
    CGFloat nameY = iconY;
    
    HVWUser *user = status.user;
    CGSize nameBoundSize = CGSizeMake(HVWScreenWidth - nameX, MAXFLOAT);
    NSDictionary *nameBoundParam = @{NSFontAttributeName : HVWStatusOriginalNameFont};
    CGSize nameSize = [user.name boundingRectWithSize:nameBoundSize options:NSStringDrawingUsesLineFragmentOrigin attributes:nameBoundParam context:nil].size;
    self.nameFrame =  (CGRect){{nameX, nameY}, nameSize};

    /**  由于发表时间会随着时间推移变化，所以不能在这里一次性设置尺寸
     * 而“来源”的位置尺寸和“发表时间”有关联，所以一起移走
     * 移动到view,每次加载“发表时间”、“来源”都要重新计算size
    // 发表时间
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameFrame);
    CGSize timeBoundSize = CGSizeMake(HVWScreenWidth - timeX, MAXFLOAT);
    NSDictionary *timeBoundParam = @{NSFontAttributeName : HVWStatusOriginalTimeFont};
    CGSize timeSize = [status.created_at boundingRectWithSize:timeBoundSize options:NSStringDrawingUsesLineFragmentOrigin attributes:timeBoundParam context:nil].size;
    self.timeFrame = (CGRect){{timeX, timeY}, timeSize};
    
    // 来源
    CGFloat sourceX = CGRectGetMaxX(self.timeFrame) + HVWStatusCellInset;
    CGFloat sourceY = timeY;
    CGSize sourceBoundSize = CGSizeMake(HVWScreenWidth - sourceX, MAXFLOAT);
    NSDictionary *sourceBoundParam = @{NSFontAttributeName : HVWStatusOriginalSourceFont};
    CGSize sourceSize = [status.source boundingRectWithSize:sourceBoundSize options:NSStringDrawingUsesLineFragmentOrigin attributes:sourceBoundParam context:nil].size;
    self.sourceFrame = (CGRect){{sourceX, sourceY}, sourceSize};
  */
    
    // 正文
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(self.iconFrame);
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
