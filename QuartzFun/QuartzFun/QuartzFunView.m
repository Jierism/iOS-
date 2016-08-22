//
//  QuartzFunView.m
//  QuartzFun
//
//  Created by  Jierism on 16/8/1.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import "QuartzFunView.h"
#import "UIColor+Random.h"

@interface QuartzFunView ()

@property (assign,nonatomic) CGPoint firstTouchLocation;
@property (assign,nonatomic) CGPoint lastTouchLocation;
@property (strong,nonatomic) UIImage *image;
@property (readonly,nonatomic) CGRect currentRect;
@property (assign,nonatomic) CGRect redrawRect;

@end

@implementation QuartzFunView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super initWithCoder:coder]) {
        _currentColor = [UIColor redColor];
        _useRandomColor = NO;
        _image = [UIImage imageNamed:@"iphone"];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);    // 宽度为2.0的画笔
    CGContextSetStrokeColorWithColor(context, self.currentColor.CGColor); // 使用当前选择的颜色
    CGContextSetFillColorWithColor(context, self.currentColor.CGColor); // 用于画图形填充颜色

    
    switch (self.shapeType) {
        case kLineShape:
            CGContextMoveToPoint(context, self.firstTouchLocation.x, self.firstTouchLocation.y); // 起点坐标
            CGContextAddLineToPoint(context, self.lastTouchLocation.x, self.lastTouchLocation.y); // 终点坐标
            CGContextStrokePath(context); // 使用context作为绘制路径去绘制
            break;
        case kRectShape:
            CGContextAddRect(context, self.currentRect); // 绘制矩形
            CGContextDrawPath(context, kCGPathFillStroke);
            break;
        case kEllipseShape:
            CGContextAddEllipseInRect(context, self.currentRect);  // 绘制椭圆,只需一个矩形的范围。
            CGContextDrawPath(context, kCGPathFillStroke);
            break;
        case kImageShape:{
            CGFloat horizontalOffset = self.image.size.width/2;
            CGFloat verticalOffset = self.image.size.height/2;
            CGPoint drawPoint = CGPointMake(self.lastTouchLocation.x - horizontalOffset, self.lastTouchLocation.y - verticalOffset);
            [self.image drawAtPoint:drawPoint];
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - Touch Handling

// 在手指第一次触碰屏幕时调用，储存当前坐标。如果使用随机颜色则使用randomColor方法改变当前颜色。之后调用setNeedsDisplay方法将视图标记为需要重新绘制的
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.useRandomColor) {
        self.currentColor = [UIColor randomColor];
    }
    
    UITouch *touch = [touches anyObject];
    self.firstTouchLocation = [touch locationInView:self];
    self.lastTouchLocation = [touch locationInView:self];
    
    self.redrawRect = CGRectZero;
    [self setNeedsDisplay];
}

// 在手指在屏幕上持续拖动时调用，每次都在lastTouchLocation变量中存储最新的当前位置，并标记为需要重新绘制屏幕
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    self.lastTouchLocation = [touch locationInView:self];
    
    if (self.shapeType == kImageShape) {
        CGFloat horizontalOffset = self.image.size.width/2;
        CGFloat verticalOffset = self.image.size.height/2;
        self.redrawRect = CGRectUnion(self.redrawRect, CGRectMake(self.lastTouchLocation.x - horizontalOffset, self.lastTouchLocation.y - verticalOffset, self.image.size.width, self.image.size.height));
    }else{
        self.redrawRect = CGRectUnion(_redrawRect, self.currentRect);
    }

    
    [self setNeedsDisplayInRect:self.redrawRect];

}

// 在手指离开屏幕时调用，存储最终位置，并标记为需要重新绘制
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    self.lastTouchLocation = [touch locationInView:self];
    
    if (self.shapeType == kImageShape) {
        CGFloat horizontalOffset = self.image.size.width/2;
        CGFloat verticalOffset = self.image.size.height/2;
        self.redrawRect = CGRectUnion(self.redrawRect, CGRectMake(self.lastTouchLocation.x - horizontalOffset, self.lastTouchLocation.y - verticalOffset, self.image.size.width, self.image.size.height));
    }else{
        self.redrawRect = CGRectUnion(self.redrawRect, self.currentRect);
    }
    self.redrawRect = CGRectInset(self.redrawRect, -2.0, -2.0);
    
    [self setNeedsDisplayInRect:self.redrawRect];
}

// 计算要重新绘制的区域
- (CGRect)currentRect {
    return CGRectMake (self.firstTouchLocation.x,
                       self.firstTouchLocation.y,
                       self.lastTouchLocation.x - self.firstTouchLocation.x,
                       self.lastTouchLocation.y - self.firstTouchLocation.y);
}



@end
