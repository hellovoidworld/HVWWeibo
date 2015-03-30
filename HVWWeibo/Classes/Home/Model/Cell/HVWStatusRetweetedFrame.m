//
//  HVWStatusRetweetedFrame.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/12.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWStatusRetweetedFrame.h"
#import "HVWStatusPhotosView.h"

@implementation HVWStatusRetweetedFrame

/** 加载微博数据 */
- (void)setStatus:(HVWStatus *)status {
    _status = status;
    
    // view高度
    CGFloat height = 0;
    
    // 设置控件frame
    // 昵称
//    CGFloat nameX = HVWStatusCellInset;
//    CGFloat nameY = HVWStatusCellInset;
//    CGSize nameBoundSize = CGSizeMake(HVWScreenWidth - nameX * 2, MAXFLOAT);
//    NSDictionary *nameBoundParam = @{NSFontAttributeName : HVWStatusOriginalNameFont};
//    CGSize nameSize = [[status retweetedName] boundingRectWithSize:nameBoundSize options:NSStringDrawingUsesLineFragmentOrigin attributes:nameBoundParam context:nil].size;
//    self.nameFrame =  (CGRect){{nameX, nameY}, nameSize};
    
    // 正文
//    CGFloat textX = nameX;
//    CGFloat textY = CGRectGetMaxY(self.nameFrame);
    CGFloat textX = HVWStatusCellInset;
    CGFloat textY = HVWStatusCellInset * 0.5;
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
