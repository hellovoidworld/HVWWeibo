//
//  HVWStatusOriginalView.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/12.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWStatusOriginalView.h"
#import "HVWStatus.h"
#import "HVWUser.h"
#import "UIImageView+WebCache.h"

@interface HVWStatusOriginalView()

/** 昵称 */
@property(nonatomic, weak) UILabel *nameLabel;

/** 头像 */
@property(nonatomic, weak) UIImageView *iconView;

/** 微博发表时间 */
@property(nonatomic, weak) UILabel *timeLabel;

/** 微博来源 */
@property(nonatomic, weak) UILabel *sourceLabel;

/** 微博文本内容 */
@property(nonatomic, weak) UILabel *textLabel;

@end

@implementation HVWStatusOriginalView


/** 代码初始化方法 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) { // 初始化子控件开始
        // 昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = HVWStatusOriginalNameFont;
        self.nameLabel = nameLabel;
        [self addSubview:nameLabel];
        
        // 头像
        UIImageView *iconView = [[UIImageView alloc] init];
        self.iconView = iconView;
        [self addSubview:iconView];
        
        // 发表时间
        UILabel *timeLabel = [[UILabel alloc] init];
        self.timeLabel = timeLabel;
        [self addSubview:timeLabel];
        
//        self.timeLabel.backgroundColor = [UIColor greenColor];
        
        // 来源
        UILabel *sourceLabel = [[UILabel alloc] init];
        self.sourceLabel = sourceLabel;
        [self addSubview:sourceLabel];
        
//        self.sourceLabel.backgroundColor = [UIColor yellowColor];
        
        // 正文
        UILabel *textLabel = [[UILabel alloc] init];
        self.textLabel = textLabel;
        [self addSubview:textLabel];
        
//        self.backgroundColor = [UIColor redColor];
    }
    
    return self;
}

/** 设置frame */
- (void)setOriginalFrame:(HVWStatusOriginalFrame *)originalFrame {
    _originalFrame = originalFrame;
    
    HVWStatus *status = originalFrame.status;
    HVWUser *user = status.user;
    
    // 设置控件frame
    // 头像
    self.iconView.frame = originalFrame.iconFrame;
    [self.iconView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithNamed:@"avatar_default_small"]];
    
    // 昵称
    self.nameLabel.frame = originalFrame.nameFrame;
    self.nameLabel.font = HVWStatusOriginalNameFont;
    self.nameLabel.text = user.name;
    
    // 发表时间
    self.timeLabel.frame = originalFrame.timeFrame;
    self.timeLabel.font = HVWStatusOriginalTimeFont;
    self.timeLabel.text = status.created_at;
    
    // 来源
    self.sourceLabel.frame = originalFrame.sourceFrame;
    self.sourceLabel.font = HVWStatusOriginalSourceFont;
    self.sourceLabel.text = status.source;
    
    /* 由于“发表时间”随着时间推移会产生变化
     * 每次都要重新计算“发表时间”和“来源”的frame
     */
    // 发表时间
    CGFloat timeX = self.nameLabel.frame.origin.x;
    CGFloat timeY = CGRectGetMaxY(self.nameLabel.frame);
    CGSize timeBoundSize = CGSizeMake(HVWScreenWidth - timeX, MAXFLOAT);
    NSDictionary *timeBoundParam = @{NSFontAttributeName : HVWStatusOriginalTimeFont};
    CGSize timeSize = [status.created_at boundingRectWithSize:timeBoundSize options:NSStringDrawingUsesLineFragmentOrigin attributes:timeBoundParam context:nil].size;
    self.timeLabel.frame = (CGRect){{timeX, timeY}, timeSize};
    
    // 来源
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + HVWStatusCellInset;
    CGFloat sourceY = timeY;
    CGSize sourceBoundSize = CGSizeMake(HVWScreenWidth - sourceX, MAXFLOAT);
    NSDictionary *sourceBoundParam = @{NSFontAttributeName : HVWStatusOriginalSourceFont};
    CGSize sourceSize = [status.source boundingRectWithSize:sourceBoundSize options:NSStringDrawingUsesLineFragmentOrigin attributes:sourceBoundParam context:nil].size;
    self.sourceLabel.frame = (CGRect){{sourceX, sourceY}, sourceSize};
    
    // 正文
    self.textLabel.frame = originalFrame.textFrame;
    self.textLabel.font = HVWStatusOriginalTextFont;
    // 设置自动换行
    self.textLabel.numberOfLines = 0;
    self.textLabel.text = status.text;
    
    // 设置自己的frame
    self.frame = originalFrame.frame;
}

@end
