//
//  HVWStatusOriginalFrame.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/12.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWStatusOriginalFrame.h"
#import "HVWStatusPhotosView.h"
#import "HVWPic.h"
#import "UIImageView+WebCache.h"

@implementation HVWStatusOriginalFrame

/** 加载微博数据 */
- (void)setStatus:(HVWStatus *)status {
    _status = status;
    
    // 整个view高度
    CGFloat height = 0;
    
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
    
    // vip会员标识
    if (user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameFrame) + HVWStatusCellInset;
        CGFloat vipY = nameY;
        CGFloat vipWidth = nameSize.height;
        CGFloat vipHeight = vipWidth;
        self.vipFrame = CGRectMake(vipX, vipY, vipWidth, vipHeight);
    }
    
    // 正文
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(self.iconFrame);
    CGSize textBoundSize = CGSizeMake(HVWScreenWidth - textX * 2, MAXFLOAT);
    
    CGSize textSize = [status.attrText boundingRectWithSize:textBoundSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    self.textFrame = (CGRect){{textX, textY}, textSize};
    
    
    // 配图相册
    if (status.pic_urls.count) {
        CGFloat photosX = textX;
        CGFloat photosY = CGRectGetMaxY(self.textFrame);
        CGSize photosSize = [HVWStatusPhotosView photosViewSizeWithCount:status.pic_urls.count];
        self.photosFrame = (CGRect){{photosX, photosY}, photosSize};
        
        height = CGRectGetMaxY(self.photosFrame);
    } else {
        height = CGRectGetMaxY(self.textFrame) + HVWStatusCellInset;
    }
    
    // 设置自己的frame
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = HVWScreenWidth;
    self.frame = CGRectMake(x, y, width, height);
}

@end
