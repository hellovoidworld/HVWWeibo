//
//  HVWUser.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/5.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HVWUser : NSObject

/** 友好显示名称 */
@property(nonatomic, strong) NSString *name;

/** 用户头像地址（中图），50×50像素 */
@property(nonatomic, strong) NSString *profile_image_url;

@end
