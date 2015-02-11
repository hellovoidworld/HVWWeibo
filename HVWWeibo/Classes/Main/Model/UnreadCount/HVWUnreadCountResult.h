//
//  HVWUnreadCountResult.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/11.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HVWUnreadCountResult : NSObject

/** int	新微博未读数 */
@property(nonatomic, assign) int status;

/** int	新粉丝数 */
@property(nonatomic, assign) int follower;

/** int	新评论数 */
@property(nonatomic, assign) int cmt;

/** int	新私信数 */
@property(nonatomic, assign) int dm;

/** int	新提及我的微博数 */
@property(nonatomic, assign) int mention_status;

/** int	新提及我的评论数 */
@property(nonatomic, assign) int mention_cmt;

/** int	微群消息未读数 */
@property(nonatomic, assign) int group;

/** int	私有微群消息未读数 */
@property(nonatomic, assign) int private_group;

/** int	新通知未读数 */
@property(nonatomic, assign) int notice;

/** int	新邀请未读数 */
@property(nonatomic, assign) int invite;

/** int	新勋章数 */
@property(nonatomic, assign) int badge;

/** int	相册消息未读数 */
@property(nonatomic, assign) int photo;

/** 聊天未读数 */
@property(nonatomic, assign) int msgbox;

/** 获取“消息”未读数 */
- (int) messageUnreadCount;


/** 获取“发现”未读数 */
- (int) discoverUnreadCount;

/** 获取“我”未读数 */
- (int) profileUnreadCount;

/** 总未读数 */
- (int) totalUnreadCount;

@end
