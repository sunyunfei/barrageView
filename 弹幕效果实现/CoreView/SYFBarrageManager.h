//
//  SYFBarrageManager.h
//  弹幕效果实现
//
//  Created by 孙云 on 16/7/27.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SYFBarrageView;
@interface SYFBarrageManager : NSObject
@property(nonatomic,copy)void(^generateViewBlock)(SYFBarrageView *view);//回调布置位置
//开始动画
- (void)start;
//停止动画
- (void)stop;
@end
