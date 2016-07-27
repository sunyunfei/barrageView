//
//  SYFBarrageView.m
//  弹幕效果实现
//
//  Created by 孙云 on 16/7/27.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import "SYFBarrageView.h"
#define padding 10
@interface SYFBarrageView()
//label显示内容
@property(nonatomic,strong)UILabel *commentLabel;
@end

@implementation SYFBarrageView

//创建
- (instancetype)initWithComment:(NSString *)comment{

    self = [super init];
    if (self) {
        //创建label
        self.commentLabel.text = comment;
        NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        CGFloat width = [comment sizeWithAttributes:attr].width;//求出字体的宽度
        self.bounds = CGRectMake(0, 0, width + 2 * padding, 30);
        self.commentLabel.frame = CGRectMake(padding, 0, width, 30);
    }
    return self;
}

#pragma mark -------开始结束方法
//开始方法
- (void)startAnimation{

    //给出uilabel的位置大小
    CGFloat screen = [UIScreen mainScreen].bounds.size.width;
    CGFloat duration = 3.0f;
    CGFloat wholeWidth = screen + CGRectGetWidth(self.bounds);
    
    //开始
    if (self.successShowComment) {
        self.successShowComment(syf_start);
    }
    
    //运行时间
    CGFloat speed = wholeWidth / 3.0f;
    CGFloat enterDurtion = CGRectGetWidth(self.bounds) / speed;
    [self performSelector:@selector(p_enterScreen) withObject:self afterDelay:enterDurtion];
    
    __block CGRect frame = self.frame;
    [UIView animateWithDuration:duration animations:^{
        
        frame.origin.x -= wholeWidth;
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
        if (self.successShowComment) {
            self.successShowComment(syf_end);
        }
    }];
}
//结束
- (void)stopAnimation{
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}

#pragma mark -------私有方法
//view尾部也进入屏幕后调用
- (void)p_enterScreen{

    if (self.successShowComment) {
        self.successShowComment(syf_enter);
    }
}


//创建label
- (UILabel *)commentLabel{

    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc]initWithFrame:self.bounds];
        _commentLabel.backgroundColor = [UIColor redColor];
        _commentLabel.textColor = [UIColor whiteColor];
        _commentLabel.font = [UIFont systemFontOfSize:14];
        _commentLabel.textAlignment = NSTextAlignmentCenter;
        _commentLabel.layer.cornerRadius = 5;
        _commentLabel.layer.masksToBounds = YES;
        [self addSubview:_commentLabel];
    }
    return _commentLabel;
}
@end
