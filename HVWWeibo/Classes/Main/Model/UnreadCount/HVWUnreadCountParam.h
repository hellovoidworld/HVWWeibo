//
//  HVWUnreadCountParam.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/11.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWBaseParam.h"

@interface HVWUnreadCountParam : HVWBaseParam

/** uid	true	int64	需要获取消息未读数的用户UID，必须是当前登录用户。*/
@property(nonatomic, assign) int uid;

/** false	boolean	未读数版本。0：原版未读数，1：新版未读数。默认为0。 */
@property(nonatomic, assign) BOOL unread_message;

@end
