//
//  HVWStatusLink.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/3/29.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWStatusLink.h"

@implementation HVWStatusLink

- (void)setText:(NSString *)text {
    _text = text;
    
    self.type = [HVWRegexTool typeWithRegexString:text];
}

@end
