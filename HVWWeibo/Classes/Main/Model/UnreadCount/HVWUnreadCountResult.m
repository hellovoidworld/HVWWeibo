//
//  HVWUnreadCountResult.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/11.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWUnreadCountResult.h"

@implementation HVWUnreadCountResult

/** 获取“消息”未读数 */
- (int) messageUnreadCount {
    return self.cmt + self.dm + self.mention_status + self.cmt + self.group + self.private_group + self.notice + self.invite;
}

/** 获取“发现”未读数 */
- (int) discoverUnreadCount {
    return 0;
}

/** 获取“我”未读数 */
- (int) profileUnreadCount {
    return self.follower + self.photo + self.badge + self.msgbox;
}

/** 总未读数 */
- (int) totalUnreadCount {
    return self.status + [self messageUnreadCount] + [self discoverUnreadCount] + [self profileUnreadCount];
}

@end
