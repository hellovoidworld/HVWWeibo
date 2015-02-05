//
//  HVWStatus.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/5.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWStatus.h"
#import "HVWPic.h"

// 注意引入框架
#import "MJExtension.h"

@implementation HVWStatus

- (NSDictionary *)objectClassInArray {
    // 返回一个字典，创建数组子元素和包装类的映射关系
    return @{@"pic_urls": [HVWPic class]};
}

@end
