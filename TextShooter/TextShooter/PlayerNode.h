//
//  PlayerNode.h
//  TextShooter
//
//  Created by  Jierism on 16/8/3.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface PlayerNode : SKNode

// 返回将来移动所需的时间
- (void)moveToward:(CGPoint)location;

@end
