//
//  HVWUser.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/5.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWUser.h"

@implementation HVWUser

/** 判断是否是会员 */
- (BOOL)isVip {
    return self.mbtype > 2;
}

/** 转发微博中的富文本昵称 */
- (NSAttributedString *) attrName {
    NSMutableAttributedString *attrName = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"@%@", self.name]];
    // 设置称为高亮蓝色
    [attrName addAttribute:NSForegroundColorAttributeName value:HVWStatusHighlightedTextColor range:NSMakeRange(0, attrName.length)];
    [attrName addAttribute:NSFontAttributeName value:HVWStatusRichTextFont range:NSMakeRange(0, attrName.length)];
    
    return attrName;
}

@end
