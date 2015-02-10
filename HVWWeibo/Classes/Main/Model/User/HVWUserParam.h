//
//  HVWUserParam.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/10.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWBaseParam.h"

@interface HVWUserParam : HVWBaseParam

/** false	string	采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。 */
@property(nonatomic, copy) NSString *source;

/** false	int64	需要查询的用户ID。 */
@property(nonatomic, copy) NSString *uid;

/** false	string	需要查询的用户昵称。 */
@property(nonatomic, copy) NSString *screen_name;

@end
