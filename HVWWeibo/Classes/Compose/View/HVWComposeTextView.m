//
//  HVWComposeTextView.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/2/6.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWComposeTextView.h"

@interface HVWComposeTextView()

@property(nonatomic, strong) UILabel *placeHolderLabel;

@end

@implementation HVWComposeTextView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // 可以拖曳
        self.scrollEnabled = YES;
        self.alwaysBounceVertical = YES;
        
        // 添加placeHolderLabel
        [self setupPlaceHolder];
        
        // 设置默认字体
        [self setFont:HVWStatusComposeTextFont];

        // 设置通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    
    return self;
}

/** 添加placeHolder */
- (void) setupPlaceHolder {
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    self.placeHolderLabel = placeHolderLabel;
    
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    placeHolderLabel.userInteractionEnabled = NO;
    placeHolderLabel.numberOfLines = 0; // 自动换行
    placeHolderLabel.backgroundColor = [UIColor clearColor];
    
    [self addSubview:placeHolderLabel];
}

/** 设置子控件frame */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.placeHolderLabel.x = 5;
    self.placeHolderLabel.y = 8;
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = self.placeHolderLabel.font;
    CGFloat placeHolderWidth = self.width - 2 * self.placeHolderLabel.x;
    
    CGRect tempRect = [self.placeHolderLabel.text boundingRectWithSize:CGSizeMake(placeHolderWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
    self.placeHolderLabel.size = tempRect.size;
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    self.placeHolderLabel.text = placeHolder;
    
    // 重新计算frame，可能不会立即调用layoutSubviews
    [self setNeedsLayout];
}

/** 重写setFont，更改正文font的时候也更改placeHolder的font */
- (void)setFont:(UIFont *)font {
    [super setFont:font];
    self.placeHolderLabel.font = font;
    
    // 重新计算frame，可能不会立即调用layoutSubviews
    [self setNeedsLayout];
}

- (void)dealloc {
    // 注销通知监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/** 正在输入文本 */
- (void) textDidChange {
    self.placeHolderLabel.hidden = self.hasText;
}

/** 设置富文本，激活文本改变方法 */
- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    
    [self textDidChange];
}

@end
