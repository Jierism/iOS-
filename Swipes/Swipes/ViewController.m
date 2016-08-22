//
//  ViewController.m
//  Swipes
//
//  Created by  Jierism on 16/8/4.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import "ViewController.h"
// 设置检测范围
static CGFloat const kMinimmGestureLength = 25;
static CGFloat const kMaximmVariance = 5;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic) CGPoint gestureStartPoint;
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    self.gestureStartPoint = [touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:self.view];
    // 返回一个float的绝对值
    CGFloat deltaX = fabsf(self.gestureStartPoint.x - currentPosition.x);
    CGFloat deltaY = fabsf(self.gestureStartPoint.y - currentPosition.y);
    
    // 获得两个增量后，判断用户在两个方向上移动过的距离，检测用户是否在一个方向上移动得足够远但在另一个方向移动得不够来形成轻扫动作
    if (deltaX >= kMinimmGestureLength && deltaY <= kMaximmVariance) {
        self.label.text = @"Horizontal swipe detected";
        // 2s后擦除文本
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)),
                       dispatch_get_main_queue(),
                       ^{
            self.label.text = @"";
        });
    }else if (deltaY >= kMinimmGestureLength && deltaX <= kMaximmVariance){
        self.label.text = @"Vertical swipe detected";
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.label.text = @"";
        });
    }
}

@end
