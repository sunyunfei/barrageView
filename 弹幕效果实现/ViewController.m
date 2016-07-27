//
//  ViewController.m
//  弹幕效果实现
//
//  Created by 孙云 on 16/7/27.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import "ViewController.h"
#import "SYFBarrageManager.h"
#import "SYFBarrageView.h"
@interface ViewController ()
@property(nonatomic,strong)SYFBarrageManager *manager;
- (IBAction)clickBtn:(id)sender;
- (IBAction)clickStop:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [[SYFBarrageManager alloc]init];
    __block typeof(self)weakSelf = self;
    self.manager.generateViewBlock =^ (SYFBarrageView *view){
    
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        view.frame = CGRectMake(width, 100 + view.tempIndex * 40, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds));
        [weakSelf.view addSubview:view];
        
    };
}



- (IBAction)clickBtn:(id)sender {
    
    [self.manager start];
}

- (IBAction)clickStop:(id)sender {
    [self.manager stop];
}
@end
