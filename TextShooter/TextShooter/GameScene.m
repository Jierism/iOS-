//
//  GameScene.m
//  TextShooter
//
//  Created by  Jierism on 16/8/3.
//  Copyright (c) 2016年  Jierism. All rights reserved.
//

#import "GameScene.h"
#import "PlayerNode.h"

@interface GameScene()

@property (strong,nonatomic) PlayerNode *playerNode;

@end

@implementation GameScene


// 是一个工厂方法，可以快速创建一个关卡并立即设置它的叙述
+ (instancetype)sceneWithSize:(CGSize)size levelNumber:(NSUInteger)levelNumber
{
    return [[self alloc] initWithSize:size levelNumber:levelNumber];
}

// 重写类的默认初始化函数，并将控制权交给第三个方法
- (instancetype)initWithSize:(CGSize)size
{
    return [self initWithSize:size levelNumber:1];
}

// 由下往上调用了父类实现的特定初始化函数。一般在为某个类添加新的初始化函数时，通常仍会使用类中特定的初始化函数。
- (instancetype)initWithSize:(CGSize)size levelNumber:(NSUInteger)levelNumber
{
    if (self = [super initWithSize:size]) {
        _levelNumber = levelNumber;
        _playerLives = 5;
        
        self.backgroundColor = [SKColor whiteColor];
        
        // 设置生命值
        SKLabelNode *lives = [SKLabelNode labelNodeWithFontNamed:@"Courier"];
        lives.fontSize = 16;
        lives.fontColor = [SKColor blueColor];
        lives.name = @"LivesLabel";
        lives.text = [NSString stringWithFormat:@"Lives: %lu",(unsigned long)_playerLives];
        lives.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
        lives.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;// 放在右侧
        lives.position = CGPointMake(self.frame.size.width, self.frame.size.height);// 这里传入的是场景的高度
        [self addChild:lives];
        
        // 设置关卡
        SKLabelNode *level = [SKLabelNode labelNodeWithFontNamed:@"Courier"];
        level.fontSize = 16;
        level.fontColor = [SKColor blackColor];
        level.name = @"LevelLabel";
        level.text = [NSString stringWithFormat:@"Level: %lu",(unsigned long)_levelNumber];
        level.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
        level.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        level.position = CGPointMake(0, self.frame.size.height);
        [self addChild:level];
        
        // 设置玩家位置
        _playerNode = [PlayerNode node];
        _playerNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetHeight(self.frame)*0.1);
        [self addChild:_playerNode];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if (location.y < CGRectGetHeight(self.frame) * 0.2) {
            CGPoint target = CGPointMake(location.x, self.playerNode.position.y);
            [self.playerNode moveToward:target];
        }
        
        
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
