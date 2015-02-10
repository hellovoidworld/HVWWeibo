//
//  HVWBaseParam.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/9.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWBaseParam.h"
#import "HVWAccountInfo.h"
#import "HVWAccountInfoTool.h"

@implementation HVWBaseParam

- (NSString *)access_token {
    if (nil == _access_token) {
        _access_token = [HVWAccountInfoTool accountInfo].access_token;
    }
    return _access_token;
}

@end
