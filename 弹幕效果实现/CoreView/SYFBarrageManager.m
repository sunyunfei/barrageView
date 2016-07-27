//
//  SYFBarrageManager.m
//  弹幕效果实现
//
//  Created by 孙云 on 16/7/27.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import "SYFBarrageManager.h"
#import "SYFBarrageView.h"
@interface SYFBarrageManager()
@property(nonatomic,strong)NSMutableArray *commentArray;//数据数组
@property(nonatomic,strong)NSMutableArray *barrageViews;//弹幕数组
@property(nonatomic,strong)NSMutableArray *barrageComment;//处理数组
@property(nonatomic,assign)BOOL stopAnimation;
@end
@implementation SYFBarrageManager

- (instancetype)init{

    if (self ==[super init]) {
        self.stopAnimation = YES;
    }
    return  self;
}

#pragma mark ----set，get方法
//数组源
- (NSMutableArray *)commentArray{
    
    if (!_commentArray) {
        _commentArray = [NSMutableArray arrayWithObjects:@"我是弹幕1......."
                         ,@"我是弹幕2............."
                         ,@"我是弹幕3...."
                         ,@"我是弹幕4........"
                         ,@"我是弹幕5............."
                         ,@"我是弹幕6...."
                         ,@"我是弹幕7...."
                         ,@"我是弹幕8....",
                         @"我是弹幕2............."
                         ,@"我是弹幕3...."
                         ,@"我是弹幕4........"
                         ,@"我是弹幕5............."
                         ,@"我是弹幕6...."
                         ,@"我是弹幕7...."
                         ,@"我是弹幕8....",nil];
    }
    return _commentArray;
}

- (NSMutableArray *)barrageViews{
    
    if (!_barrageViews) {
        _barrageViews = [NSMutableArray array];
    }
    return  _barrageViews;
}

- (NSMutableArray *)barrageComment{
    
    if (!_barrageComment) {
        _barrageComment = [NSMutableArray array];
    }
    return  _barrageComment;
}

#pragma mark -----开始停止方法
//开始
- (void)start{

    if (!self.stopAnimation) {
        return;
    }
    self.stopAnimation = NO;
    
    //数组数据全部移除
    [self.barrageComment removeAllObjects];
    [self.barrageComment addObjectsFromArray:self.commentArray];
    [self p_initBarrageComment];
    

}
//停止
- (void)stop{
    if (self.stopAnimation) {
        return;
    }
    self.stopAnimation = YES;
    if (self.barrageViews.count > 0) {
        
        [self.barrageViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SYFBarrageView *view = obj;
            [view stopAnimation];
            view = nil;
        }];
        
        [self.barrageViews removeAllObjects];
    }
    
}

#pragma mark ------私有方法
- (void)p_initBarrageComment{

    NSMutableArray *tempArray = [NSMutableArray arrayWithObjects:@(0),@(1),@(2),@(3),@(4), nil];
    for(int i = 0;i < 5;i ++){
    
        if (self.barrageComment.count > 0 ) {
            
            //随机数
            NSInteger index = arc4random() % tempArray.count;
            int temp = [[tempArray objectAtIndex:index] intValue];
            [tempArray removeObjectAtIndex:index];
            
            //从弹幕数组逐一取出数据
            NSString *comment = [self.barrageComment firstObject];
            [self.barrageComment removeObjectAtIndex:0];
            
            //创建view
            [self p_createViewBarrageView:comment temp:temp];
        }
       
    }
}
//创建弹幕
- (void)p_createViewBarrageView:(NSString *)comment temp:(int)tempIndex{

    if (self.stopAnimation) {
        return;
    }
    SYFBarrageView *barrageView = [[SYFBarrageView alloc]initWithComment:comment];
    barrageView.tempIndex = tempIndex;
    
    
    __block typeof(self)weakSelf =self;
    __block typeof(SYFBarrageView *)weakView = barrageView;
    //移除屏幕
    barrageView.successShowComment = ^(NSInteger status){
       
        if (weakSelf.stopAnimation) {//防止在停止时被调用
            return ;
        }
        switch (status) {
            case syf_start:{
                //弹幕进入
                [weakSelf.barrageViews addObject:weakView];
            }
                break;
            case syf_enter:{
                //是否还有其他内容有，在该轨迹创建一个
                NSString *nextComment = [weakSelf p_nextComment];
                if (nextComment) {
                    [weakSelf p_createViewBarrageView:nextComment temp:tempIndex];
                }
            }
                break;
            case syf_end:
            {
                //弹幕飞出从数组删除
                if ([weakSelf.barrageViews containsObject:weakView]) {
                    [weakView stopAnimation];
                    [weakSelf.barrageViews removeObject:weakView];
                }
                
                if (weakSelf.barrageViews.count == 0) {//没有数据源了
                    weakSelf.stopAnimation = YES;
                    [weakSelf start];
                    
                }
            }
                
                break;
                
            default:
                break;
        }
    
    };
    
    
    if (self.generateViewBlock) {
        self.generateViewBlock(barrageView);
    }
    [barrageView startAnimation];
}
//是否还有弹幕
- (NSString *)p_nextComment{

    if (self.barrageComment.count == 0) {
        return  nil;
    }
    NSString *comment = [self.barrageComment firstObject];
    
    if (comment) {
        [self.barrageComment removeObjectAtIndex:0];
    }
    return comment;
}


@end
