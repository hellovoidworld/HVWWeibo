//
//  HVWStatusLink.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/3/29.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HVWRegexTool.h"

@interface HVWStatusLink : NSObject

/** 文本信息 */
@property(nonatomic, copy) NSString *text;

/** 链接文本片段在总文本的范围 */
@property(nonatomic, assign) NSRange range;

/** 文本占有的所有rect */
@property(nonatomic, strong) NSArray *frames;

/** 链接类型 */
@property(nonatomic, assign) HVWRegexType type;

@end
