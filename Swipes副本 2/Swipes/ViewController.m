//
//  ViewController.m
//  Swipes
//
//  Created by  Jierism on 16/8/4.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic) CGPoint gestureStartPoint;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    for (NSUInteger touchCount = 1; touchCount <= 5; touchCount++) {
        //创建两个手势识别器
        // 1、水平方向识别器
        UISwipeGestureRecognizer *horizontal = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(reportHorizontalSwipe:)];
        
        horizontal.direction = UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight;
        [self.view addGestureRecognizer:horizontal];
        
        // 2、垂直方向识别器
        UISwipeGestureRecognizer *vertical = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(reportVerticalSwipe:)];
        vertical.direction = UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionDown;
        [self.view addGestureRecognizer:vertical];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)descriptionForTouchCount:(NSUInteger)touchCount
{
    switch (touchCount) {
        case 1:
            return @"Single";
        case 2:
            return @"Double";
        case 3:
            return @"Triple";
        case 4:
            return @"Quadruple";
        case 5:
            return @"Quintuple";
            
        default:
            return @"";
    }
}

- (void)reportHorizontalSwipe:(UIGestureRecognizer *)recognizer
{

    self.label.text = [NSString stringWithFormat:@"%@ Horizontal swipe detected",[self descriptionForTouchCount:[recognizer numberOfTouches]]];
    // 2s后擦除文本
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(),
                   ^{
                       self.label.text = @"";
                   });
}

- (void)reportVerticalSwipe:(UIGestureRecognizer *)recognizer
{
    self.label.text = [NSString stringWithFormat:@"%@ Vertical swipe detected",[self descriptionForTouchCount:[recognizer numberOfTouches]]];
    // 2s后擦除文本
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(),
                   ^{
                       self.label.text = @"";
                   });
}

@end
