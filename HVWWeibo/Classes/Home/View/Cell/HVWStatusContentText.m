//
//  HVWStatusContentText.m
//  HVWWeibo
//
//  Created by hellovoidworld on 15/3/28.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWStatusContentText.h"
#import "HVWStatusLink.h"

@interface HVWStatusContentText()

/** 文字label */
@property(nonatomic, weak) UITextView *textView;

/** 可点击链接文本数组 */
@property(nonatomic, strong) NSMutableArray *links;

/** 被选中的链接文本 */
@property(nonatomic, strong) HVWStatusLink *selectedLink;

/** 文本背景 */
@property(nonatomic, strong) NSMutableArray *bgs;

@end

@implementation HVWStatusContentText

- (NSMutableArray *)bgs {
    if (nil == _bgs) {
        _bgs = [NSMutableArray array];
    }
    return _bgs;
}

- (NSMutableArray *)links {
    if (nil == _links) {
        _links = [NSMutableArray array];
        
        // 取出所有富文本属性
        [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
            
            // 挑出具有链接属性的富文本片段
            NSString *linkAttr = attrs[HVWStatusLinkAttributeKey];
            
            if (linkAttr) {
                // 取得文本信息和所在范围
                HVWStatusLink *link = [[HVWStatusLink alloc] init];
                link.text = linkAttr;
                link.range = range;
                
                NSMutableArray *frames = [NSMutableArray array];
                // 取得文本所在位置
                self.textView.selectedRange = range; // 选中文本
                // 被选中文本的所有位置
                NSArray *selectionRects = [self.textView selectionRectsForRange:self.textView.selectedTextRange];
                for (UITextSelectionRect *selectionRect in selectionRects) {
                    // 没有宽度和高度的位置去除
                    if (selectionRect.rect.size.width == 0 || selectionRect.rect.size.height == 0) continue;
                    
                    [frames addObject:selectionRect];
                }
                
                link.frames = frames;
                
                [_links addObject:link];
            }
        }];
    }
    
    return _links;
}

/** 初始化 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UITextView *textView = [[UITextView alloc] init];
        // 不可编辑
        textView.editable = NO;
        // 不能滚动
        textView.scrollEnabled = NO;
        // 设置为不可交互，才能把点击事件传到本层
        textView.userInteractionEnabled = NO;
        // 内边距
        textView.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
        textView.backgroundColor = [UIColor clearColor];
        self.textView = textView;
        [self addSubview:textView];
    }
    
    return self;
}

/** 布局 */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.textView.frame = self.bounds;
}

/** 设置图文文本 */
- (void)setAttributedText:(NSAttributedString *)attributedText {
    _attributedText = attributedText;
    
    self.textView.attributedText = attributedText;

    self.links = nil;
}

#pragma mark - 触摸事件
/** 触摸开始 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // 点击点
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:touch.view];
    
    // 检测点击链接文本
    HVWStatusLink *link = [self touchesLink:touchPoint];
    self.selectedLink = link;
    
    if (link) {
        [self didLinkSelected:link];
    }
}

/** 触摸结束 */
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesCancelled:touches withEvent:event];
}

/** 触摸取消 */
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    // 延迟消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 消除链接文本背景
        [self dismissLinkBackground:self.selectedLink];
    });
}

#pragma mark - 链接文字背景方法
/** 检测点击链接文本 */
- (HVWStatusLink *) touchesLink:(CGPoint)touchPoint {
    __block HVWStatusLink *returnLink = nil;
    // 读取所有链接文本
    [self.links enumerateObjectsUsingBlock:^(HVWStatusLink *link, NSUInteger idx, BOOL *stop) {
        
        // 遍历其中一个连接文本的所有位置
        for (UITextSelectionRect *selectionRect in link.frames) {
            // 如果点击中了这个文本
            if (CGRectContainsPoint(selectionRect.rect, touchPoint)) {
                returnLink = link;
                *stop = YES;
            }
        }
    }];
    
    return returnLink;
}

/** 显示链接文本背景 */
- (void) showLinkBackground:(HVWStatusLink *)link {
    for (UITextSelectionRect *selectionRect in link.frames) {
        UIView *bg = [self showTextBackground:selectionRect.rect];
        [self.bgs addObject:bg];
    }
}

/** 显示背景 */
- (UIView *) showTextBackground:(CGRect)rect {
    // 加上背景
    UIView *bg = [[UIView alloc] init];
    bg.backgroundColor = [UIColor lightGrayColor];
    bg.layer.cornerRadius = 3;
    bg.frame = rect;
    
    // 加入到文本面板文本下方，这里加到最底层
    [self.textView insertSubview:bg atIndex:0];
    
    return bg;
}

/** 消除链接文本背景 */
- (void) dismissLinkBackground:(HVWStatusLink *)link {
    for (UIView *bg in self.bgs) {
        [bg removeFromSuperview];
    }
    self.bgs = nil;
}

/** 链接文本点击事件 */
- (void) didLinkSelected:(HVWStatusLink *)link {
    // 文本背景
    [self showLinkBackground:link];
    
    // 发送通知
    NSDictionary *userInfo = @{HVWStatusLinkKey : link};
    [[NSNotificationCenter defaultCenter] postNotificationName:HVWStatusDidLinkSelectedNotification object:nil userInfo:userInfo];
}

@end
