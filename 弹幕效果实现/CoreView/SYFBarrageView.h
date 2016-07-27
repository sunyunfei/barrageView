//
//  SYFBarrageView.h
//  弹幕效果实现
//
//  Created by 孙云 on 16/7/27.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,AnimationStatus){//运行的状态

    syf_start,
    syf_enter,
    syf_end
};
@interface SYFBarrageView : UIView
//随机出现的y
@property(nonatomic,assign)int tempIndex;
//弹幕弹出的回调块
@property(nonatomic,copy)void(^successShowComment)(NSInteger status);
//创建
- (instancetype)initWithComment:(NSString *)comment;
//开始动画
- (void)startAnimation;
//结束
- (void)stopAnimation;
@end
