//
//  PlayerNode.m
//  TextShooter
//
//  Created by  Jierism on 16/8/3.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import "PlayerNode.h"

@implementation PlayerNode

- (instancetype)init
{
    if (self = [super init]) {
        self.name = [NSString stringWithFormat:@"Player %p",self];
        [self initNodeGraph];
    }
    return self;
}

- (void)initNodeGraph
{
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Courier"];
    label.fontColor = [SKColor darkGrayColor];
    label.fontSize = 40;
    label.text = @"V";
    label.zRotation = M_PI; // 将字母V倒转
    label.name = @"label";
    
    [self addChild:label];
}


// 实现玩家位移动作
- (void)moveToward:(CGPoint)location
{
    [self removeActionForKey:@"movement"];
    
    CGFloat distance = PointDistance(self.position,location);
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat duration = 2.0 * distance / screenWidth;
    
    [self runAction:[SKAction moveTo:location duration:duration] withKey:@"movement"];
}

@end
