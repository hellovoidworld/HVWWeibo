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

@end
