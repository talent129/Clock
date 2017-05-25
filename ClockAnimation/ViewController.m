//
//  ViewController.m
//  ClockAnimation
//
//  Created by mac on 17/5/25.
//  Copyright © 2017年 cai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *secondView;

@property (nonatomic, strong) UIView *hourView;

@property (nonatomic, strong) UIView *minuteView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    //创建表盘
    UIView *clockView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    clockView.center = self.view.center;
    
    clockView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"clock"].CGImage);
    
    clockView.layer.cornerRadius = clockView.bounds.size.width * 0.5;
    clockView.layer.masksToBounds = YES;
    
    [self.view addSubview:clockView];
    
    //创建秒针
    UIView *secondView = [[UIView alloc] init];
    secondView.backgroundColor = [UIColor redColor];
    secondView.bounds = CGRectMake(0, 0, 2, clockView.bounds.size.width * 0.5 * 0.9);
    
    //修改了中心点的含义
    secondView.layer.anchorPoint = CGPointMake(0.5, 0.8);
    secondView.center = clockView.center;
    [self.view addSubview:secondView];
    self.secondView = secondView;
    
    //创建时针
    UIView *hourView = [[UIView alloc] init];
    hourView.backgroundColor = [UIColor purpleColor];
    hourView.bounds = CGRectMake(0, 0, 2, clockView.bounds.size.width * 0.5 * 0.3);
    hourView.layer.anchorPoint = CGPointMake(0.5, 0.8);
    hourView.center = clockView.center;
    [self.view addSubview:hourView];
    self.hourView = hourView;
    
    //创建分针
    UIView *minuteView = [[UIView alloc] init];
    minuteView.backgroundColor = [UIColor cyanColor];
    minuteView.bounds = CGRectMake(0, 0, 2, clockView.bounds.size.width * 0.5 * 0.6);
    minuteView.layer.anchorPoint = CGPointMake(0.5, 0.8);
    minuteView.center = clockView.center;
    [self.view addSubview:minuteView];
    self.minuteView = minuteView;
    
    //开启一个定时器
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    
    //与显示器刷新频率相关联的类 每次显示器刷新都会执行这个方法
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick)];
    //加到主消息循环中
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    [self tick];
}

//每隔一秒调一次
- (void)tick
{
    //计算每秒的弧度
    CGFloat radian = M_PI * 2 / 60;
    
    //获取当前系统的时分秒
    NSDate *date = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
//    //获取秒
//    NSInteger second = [calendar component:NSCalendarUnitSecond fromDate:date];

    NSDateComponents *comp = [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:date];
    
    NSInteger hour = comp.hour;
    NSInteger minute = comp.minute;
    NSInteger second = comp.second;
    
    //计算本次秒针应该旋转的弧度
    radian = radian * second;
    
    //让当前秒针与原来的弧度增加一个radian
    self.secondView.transform = CGAffineTransformMakeRotation(radian);
    
    /*******************************************************************/
    
    //计算每小时弧度
    CGFloat hourRadian = (M_PI * 2) / 12.0;
    
    //本次时针应该旋转的弧度
    hourRadian = hourRadian * hour;
    self.hourView.transform = CGAffineTransformMakeRotation(hourRadian);
    
    /*******************************************************************/
    
    //计算每分钟弧度
    CGFloat minuteRadian = M_PI * 2 / 60;
    
    //计算本次分针应该旋转的弧度
    minuteRadian = minuteRadian * minute;
    
    self.minuteView.transform = CGAffineTransformMakeRotation(minuteRadian);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
