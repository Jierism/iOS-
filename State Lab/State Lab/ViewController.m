//
//  ViewController.m
//  State Lab
//
//  Created by  Jierism on 16/7/31.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong,nonatomic) UILabel *label;
@property (strong,nonatomic) UIImage *smiley;
@property (strong,nonatomic) UIImageView *smileyView;
@property (assign,nonatomic) NSInteger index;
@property (strong,nonatomic) UISegmentedControl *segmentedControl;


@end

@implementation ViewController{
    BOOL animate;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 设置Label
    CGRect bounds = self.view.bounds;
    CGRect labelFrame = CGRectMake(bounds.origin.x, CGRectGetMidY(bounds)-50, bounds.size.width, 100);
    self.label = [[UILabel alloc] initWithFrame:labelFrame];
    self.label.font = [UIFont fontWithName:@"Helvetica" size:70];
    self.label.text = @"Bazinga!";
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.label];
    
    // 设置smiley图像,尺寸是84像素X84像素
    CGRect smileyFrame = CGRectMake(CGRectGetMidX(bounds)-42, CGRectGetMidY(bounds)/2-42, 84, 84);
    self.smileyView = [[UIImageView alloc] initWithFrame:smileyFrame];
    self.smileyView.contentMode = UIViewContentModeCenter;
    NSString *smileyPath = [[NSBundle mainBundle] pathForResource:@"smiley" ofType:@"png"];
    self.smiley = [UIImage imageWithContentsOfFile:smileyPath];
    self.smileyView.image = self.smiley;
    [self.view addSubview:self.smileyView];
    
    // 创建分段控件
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"One",@"Two",@"Three",@"Four",nil]];
    self.segmentedControl.frame = CGRectMake(bounds.origin.x+20, 50, bounds.size.width-40, 30);
    [self.segmentedControl addTarget:self
                              action:@selector(selectionChanged:)
                    forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segmentedControl];
    
    // 从后台返回时显示原来的分段控件index值的状态,并设置默认选中第一个
    self.index = [[NSUserDefaults standardUserDefaults] integerForKey:@"index"];
    self.segmentedControl.selectedSegmentIndex = self.index;
    
    // 改变应用程序状态会通知应用程序委托，不过因为我们的类不是应用委托，所以无法实现委托方法并期望他们生效，
    // 但我们可以注册以接受在执行装填更改是来自应用的通知
    // 当程序在运行过程中受到短信时，通过改变animate标记，会停止转动，关闭短信窗口后会继续转动
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(applicationWillResignActive)
                   name:(UIApplicationWillResignActiveNotification)
                 object:nil];
    [center addObserver:self
               selector:@selector(applicationDidBecomeActive)
                   name:UIApplicationDidBecomeActiveNotification
                 object:nil];
    
    // 再注册两个通知，用以下两个方法实现，当程序进入后台时回收笑脸的资源，当程序从后台返回时重新创建它，优化系统资源
    [center addObserver:self
               selector:@selector(applicationDidEnterBackground)
                   name:(UIApplicationWillResignActiveNotification)
                 object:nil];
    [center addObserver:self
               selector:@selector(applicationWillEnterForeground)
                   name:UIApplicationDidBecomeActiveNotification
                 object:nil];
}

- (void)rotateLabelDown
{
    [UIView animateWithDuration:0.5 animations:^{
        self.label.transform = CGAffineTransformMakeRotation(M_PI);
    }
     completion:^(BOOL finished) {
         [self rotateLabelUp];
     }];
}

- (void)rotateLabelUp
{
    [UIView animateWithDuration:0.5 animations:^{
        self.label.transform = CGAffineTransformMakeRotation(0);
    }
                     completion:^(BOOL finished) {
                         
                         if (animate) {
                             [self rotateLabelDown];
                         }
                         
                     }];
}

// 程序将要变为不活跃
- (void)applicationWillResignActive
{
    NSLog(@"VC:%@",NSStringFromSelector(_cmd));
    animate = NO;
}

// 程序变为活跃
- (void)applicationDidBecomeActive
{
    NSLog(@"VC:%@",NSStringFromSelector(_cmd));
    animate = YES;
    [self rotateLabelDown];
}

// 程序进入后台，释放图片
- (void)applicationDidEnterBackground
{
    NSLog(@"VC:%@",NSStringFromSelector(_cmd));
    self.smiley = nil;
    self.smileyView = nil;
    [[NSUserDefaults standardUserDefaults] setInteger:self.index forKey:@"index"];
    
    // 请求更多的后台时间，当程序进如后台时，向系统请求时间继续执行任务
    UIApplication *app = [UIApplication sharedApplication];
    // 调用beginBackgroundTaskWithExpirationHandler和endBackgroundTask匹配调用，是在告诉系统：我们需要更多时间来完成某件事，并承诺在完成后告诉他。如果系统断定我们运行了太长的时间并决定停止后台任务，可以调用我们作为参数提供的代码块。
    __block UIBackgroundTaskIdentifier taskId = [app beginBackgroundTaskWithExpirationHandler:^{
        NSLog(@"Background task ran out of time and was terminated.");
        [app endBackgroundTask:taskId];
    }];
    
    // 如果返回特殊值UIBackgroundTaskInvalid，则表明系统没有为我们提供任何多余的时间
    if (taskId == UIBackgroundTaskInvalid) {
        NSLog(@"Failed to start background task!");
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"Starting background task with %f seconds remaining",app.backgroundTimeRemaining);
        self.smiley = nil;
        self.smileyView = nil;
        // 模拟一个25s的过程
        [NSThread sleepForTimeInterval:25];
        
        NSLog(@"Finishing background task with %f seconds remaining",app.backgroundTimeRemaining);
        // 告诉系统我们完成了之前请求额外时间来完成的工作
        [app endBackgroundTask:taskId];
    });
}

// 程序从后台返回时加载图片
- (void)applicationWillEnterForeground
{
    NSLog(@"VC:%@",NSStringFromSelector(_cmd));
    NSString *smileyPath = [[NSBundle mainBundle] pathForResource:@"smiley" ofType:@"png"];
    self.smiley = [UIImage imageWithContentsOfFile:smileyPath];
    self.smileyView.image = self.smiley;
}

// 每当用户改变了所选的分段，index属性的值就会更新
- (void)selectionChanged:(UISegmentedControl *)sender
{
    self.index = sender.selectedSegmentIndex;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
