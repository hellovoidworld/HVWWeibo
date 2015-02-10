//
//  HVWFileDataParam.h
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/10.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HVWFileDataParam : NSObject

/** 文件二进制数据 */
@property(nonatomic, strong) NSData *fileData;

/** 文件参数名 */
@property(nonatomic, copy) NSString *name;

/** 文件名 */
@property(nonatomic, copy) NSString *fileName;

/** 文件类型 */
@property(nonatomic, copy) NSString *mimeType;

@end
