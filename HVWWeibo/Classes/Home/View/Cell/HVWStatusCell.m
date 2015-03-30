//
//  HVWStatusCell.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/12.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWStatusCell.h"
#import "HVWStatusContentView.h"
#import "HVWStatusToolbar.h"

@interface HVWStatusCell()

/** 微博内容控件 */
@property(nonatomic, weak) HVWStatusContentView *statusContentView;

/** 微博工具条控件 */
@property(nonatomic, weak) HVWStatusToolbar *toolbar;

@end

@implementation HVWStatusCell

/** 创建 */
+ (instancetype) cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"HVWStatusCell";
    HVWStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (nil == cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    // 清空cell背景色
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

/** 初始化 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) { // 初始化子控件开始
        // 去掉cell的点击效果
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 初始化微博内容控件
        [self setupStatusContentView];
        
        // 初始化工具条控件 */
        [self setupToolbar];
    }
    
    return self;
}

/** 初始化微博内容控件 */
- (void) setupStatusContentView {
    HVWStatusContentView *statusContentView = [[HVWStatusContentView alloc] init];
    self.statusContentView = statusContentView;
    [self.contentView addSubview:statusContentView];
}

/** 初始化工具条控件 */
- (void) setupToolbar {
    HVWStatusToolbar *toolbar = [[HVWStatusToolbar alloc] init];
    self.toolbar = toolbar;
    [self.contentView addSubview:toolbar];
}

/** 初始化frame */
- (void)setStatusFrame:(HVWStatusFrame *)statusFrame {
    _statusFrame = statusFrame;
    
    // 设置微博内容frame
    self.statusContentView.contentFrame = statusFrame.contentFrame;
    
    // 设置工具条frame
    self.toolbar.toolbarFrame = statusFrame.toolbarFrame;
}

@end
