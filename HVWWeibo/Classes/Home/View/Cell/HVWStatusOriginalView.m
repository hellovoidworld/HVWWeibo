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
#import "HVWStatusPhotosView.h"
#import "HVWStatusContentText.h"

@interface HVWStatusOriginalView()

/** 昵称 */
@property(nonatomic, weak) UILabel *nameLabel;

/** 头像 */
@property(nonatomic, weak) UIImageView *iconView;

/** vip会员标识 */
@property(nonatomic, weak) UIImageView *vipView;

/** 微博发表时间 */
@property(nonatomic, weak) UILabel *timeLabel;

/** 微博来源 */
@property(nonatomic, weak) UILabel *sourceLabel;

/** 微博文本内容 */
@property(nonatomic, weak) HVWStatusContentText *textLabel;

/** 微博配图控件 */
@property(nonatomic, weak) HVWStatusPhotosView *photosView;

@end

@implementation HVWStatusOriginalView


/** 代码初始化方法 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) { // 初始化子控件开始
        self.userInteractionEnabled = YES;
        
        // 昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = HVWStatusOriginalNameFont;
        self.nameLabel = nameLabel;
        [self addSubview:nameLabel];
        
        // 头像
        UIImageView *iconView = [[UIImageView alloc] init];
        self.iconView = iconView;
        [self addSubview:iconView];
        
        // vip会员
        UIImageView *vipView = [[UIImageView alloc] init];
        vipView.contentMode = UIViewContentModeCenter;
        self.vipView = vipView;
        [self addSubview:vipView];
        
        // 发表时间
        UILabel *timeLabel = [[UILabel alloc] init];
        self.timeLabel = timeLabel;
        [self addSubview:timeLabel];
        
        // 来源
        UILabel *sourceLabel = [[UILabel alloc] init];
        self.sourceLabel = sourceLabel;
        [self addSubview:sourceLabel];
        
        // 正文
        HVWStatusContentText *textLabel = [[HVWStatusContentText alloc] init];
        self.textLabel = textLabel;
        [self addSubview:textLabel];
        
        // 配图
        HVWStatusPhotosView *photosView = [[HVWStatusPhotosView alloc] init];
        self.photosView = photosView;
        [self addSubview:photosView];
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
    
    // vip会员标识
    if (user.isVip) {
        self.nameLabel.textColor = [UIColor orangeColor];
        self.vipView.hidden = NO;
        self.vipView.frame = originalFrame.vipFrame;
        self.vipView.image = [UIImage imageWithNamed:[NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank]];
        
    } else { // 注意cell的重用问题，需要回复设置
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    
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
    self.timeLabel.textColor = HVWStatusOriginalTimeColor;
    
    // 来源
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + HVWStatusCellInset;
    CGFloat sourceY = timeY;
    CGSize sourceBoundSize = CGSizeMake(HVWScreenWidth - sourceX, MAXFLOAT);
    NSDictionary *sourceBoundParam = @{NSFontAttributeName : HVWStatusOriginalSourceFont};
    CGSize sourceSize = [status.source boundingRectWithSize:sourceBoundSize options:NSStringDrawingUsesLineFragmentOrigin attributes:sourceBoundParam context:nil].size;
    self.sourceLabel.frame = (CGRect){{sourceX, sourceY}, sourceSize};
    self.sourceLabel.textColor = HVWStatusOriginalSourceColor;
    
    // 正文
    self.textLabel.frame = originalFrame.textFrame;
//    self.textLabel.font = HVWStatusOriginalTextFont;
//    // 设置自动换行
//    self.textLabel.numberOfLines = 0;
    self.textLabel.attributedText = status.attrText;
    
    // 配图
    if (status.pic_urls.count) {
        self.photosView.frame = originalFrame.photosFrame;
        self.photosView.photos = status.pic_urls;
        self.photosView.hidden = NO;
    } else {
        self.photosView.hidden = YES;
    }
    
    // 设置自己的frame
    self.frame = originalFrame.frame;
}

@end
