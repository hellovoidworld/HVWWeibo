//
//  HVWHomeStatusResult.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/9.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWHomeStatusResult.h"
#import "MJExtension.h"

@implementation HVWHomeStatusResult

/** 指明将json数组元素转为什么模型类 */
- (NSDictionary *)objectClassInArray {
    return @{@"statuses":[HVWStatus class]};
}

@end
