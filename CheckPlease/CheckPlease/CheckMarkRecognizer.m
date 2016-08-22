//
//  CheckMarkRecognizer.m
//  CheckPlease
//
//  Created by  Jierism on 16/8/4.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import "CheckMarkRecognizer.h"
#import "CGPointUtils.h"
#import <UIKit/UIGestureRecognizerSubclass.h> // 一个重要目的是使手势识别器的state属性可写，子类将使用这个机制断言我们所观察的手势已成功完成

// 设置检测范围
static CGFloat const kMinimunCheckMarkAngle = 80;
static CGFloat const kMaximumCheckMarkAngle = 100;
static CGFloat const kMinimumCheckMarkLength = 10;

@implementation CheckMarkRecognizer{
    // 前两个实例变量提供之前的线段
    CGPoint lastPreviousPoint;
    CGPoint lastCurrentPoint;
    // 画出的线段长度
    CGFloat lineLengthSoFar;
}


// 用lastPreviousPoint和lastCurrentPoint组成第一条线段，跟第二条线段形成角度去完成手势
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    lastPreviousPoint = point;
    lastCurrentPoint = point;
    lineLengthSoFar = 0.0;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint previousPoint = [touch previousLocationInView:self.view];
    CGPoint currentPoint = [touch locationInView:self.view];
    CGFloat angle = angleBetweenLines(lastPreviousPoint, lastCurrentPoint, previousPoint, currentPoint);
    if (angle >= kMinimunCheckMarkAngle && angle <= kMaximumCheckMarkAngle && lineLengthSoFar > kMinimumCheckMarkLength) {
        self.state = UIGestureRecognizerStateRecognized;
    }
    lineLengthSoFar += distanceBetweenPoints(previousPoint, currentPoint);
    lastPreviousPoint = previousPoint;
    lastCurrentPoint = currentPoint;
}

@end
