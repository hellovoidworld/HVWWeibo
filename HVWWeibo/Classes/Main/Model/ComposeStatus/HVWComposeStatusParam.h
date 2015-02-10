//
//  HVWComposeStatusParam.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/10.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWBaseParam.h"
#import "HVWStatus.h"

@interface HVWComposeStatusParam : HVWBaseParam

/** true	string	要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。 */
@property(nonatomic, copy) NSString *status;

@end