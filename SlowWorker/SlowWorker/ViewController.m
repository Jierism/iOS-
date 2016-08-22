//
//  ViewController.m
//  SlowWorker
//
//  Created by  Jierism on 16/7/31.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UITextView *resultsTextView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *) fetchSomethingFromServer
{
    [NSThread sleepForTimeInterval:1];
    return @"Hi there";
}

- (NSString *)processData:(NSString *)data
{
    [NSThread sleepForTimeInterval:2];
    return [data uppercaseString];
}

- (NSString *)calculateFirstResult:(NSString *)data
{
    [NSThread sleepForTimeInterval:3];
    return [NSString stringWithFormat:@"Number of chars:%lu",(unsigned long)[data length]];
}

- (NSString *)calculateSecondResult:(NSString *)data
{
    [NSThread sleepForTimeInterval:4];
    return [data stringByReplacingOccurrencesOfString:@"E" withString:@"e"];
}

- (IBAction)doWork:(id)sender
{
    self.resultsTextView.text = @"";
    NSDate *startTime = [NSDate date];
    // 点击后按钮变为禁用状态
    self.startButton.enabled = NO;
    
    // 让旋转器转动
    [self.spinner startAnimating];
    // 使用dispatch_get_global_queue（1.指定优先级，2.目前没使用为0）函数，来抓取一个已经存在并始终可用的全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue,  ^{
        NSString *fetchedData = [self fetchSomethingFromServer];
        NSString *processedData = [self processData:fetchedData];
        // 使用分派组（dispatch group），通过dispatch_group_async（）函数异步分派的所有代码块设置为松散，以便尽可能快执行。如果可能，将他们分发给多个线程同时执行(并发).
        __block NSString *firstResult;
        __block NSString *secondResult;
        dispatch_group_t group = dispatch_group_create();
        dispatch_group_async(group, queue, ^{
            firstResult = [self calculateFirstResult:processedData];
        });
        dispatch_group_async(group, queue, ^{
            secondResult = [self calculateSecondResult:processedData];
        });
        // 使用dispatch_group_notify（）指定一个额外的代码块，让它在组中的所有代码块运行完成时再执行。
        dispatch_group_notify(group, queue, ^{
            NSString *resultsSummary = [NSString stringWithFormat:@"First:[%@]\nSecond:[%@]",firstResult,secondResult];
            // 调用分派函数，将工作传回主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                self.resultsTextView.text = resultsSummary;
                self.startButton.enabled = YES;
                [self.spinner stopAnimating];
            });
            
            NSDate *endTime = [NSDate date];
            NSLog(@"Completed in %f seconds",[endTime timeIntervalSinceDate:startTime]);// 运行时间减少了
        });

    });
}

@end
