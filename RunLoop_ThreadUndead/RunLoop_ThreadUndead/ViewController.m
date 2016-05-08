//
//  ViewController.m
//  RunLoop_ThreadUndead
//
//  Created by  江苏 on 16/5/8.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,strong)NSThread* thread;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //创建线程
    self.thread=[[NSThread alloc]initWithTarget:self selector:@selector(run) object:nil];
    
    //线程开始
    [self.thread start];
  
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   
    //调用线程方法
    [self performSelector:@selector(run) withObject:nil afterDelay:2.0];
    
}

//在此方法开始运行循环，那么该方法永远不会结束，一直在等待外部调用来完成一些任务
-(void)run
{
    NSLog(@"线程开始");
    
    //获得当前runLoop
    NSRunLoop *runLoop=[NSRunLoop currentRunLoop];
    
    //给runLoop添加port(添加timer,observer均可执行相应功能，同时保证开启运行循环)
    [runLoop addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    
    //启动运行循环
    [runLoop run];
    
    NSLog(@"线程结束");
    
    
}
@end
