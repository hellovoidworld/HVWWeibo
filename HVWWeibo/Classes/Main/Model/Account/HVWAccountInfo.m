//
//  HVWAccountInfo.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/5.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWAccountInfo.h"

@implementation HVWAccountInfo

/** 自定义初始化方法,这里是用来初始化服务器发来的json数据的 */
+ (instancetype) accountInfoWithDictionary:(NSDictionary *) dict {
    HVWAccountInfo *accountInfo = [[self alloc] init];
    
    accountInfo.access_token = dict[@"access_token"];
    accountInfo.expires_in = dict[@"expires_in"];
    
    NSDate *now = [NSDate date];
    accountInfo.expires_time = [now dateByAddingTimeInterval:accountInfo.expires_in.doubleValue];
    
    accountInfo.uid = dict[@"uid"];
    
    return accountInfo;
}

#pragma mark - NSCoding
/** 从文件解析对象调用 */
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.expires_time = [aDecoder decodeObjectForKey:@"expires_time"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.screen_name = [aDecoder decodeObjectForKey:@"screen_name"];
    }
    
    return self;
}

/** 把对象写入文件调用 */
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.expires_time forKey:@"expires_time"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.screen_name forKey:@"screen_name"];
}

@end
