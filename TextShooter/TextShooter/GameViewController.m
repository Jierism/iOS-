//
//  GameViewController.m
//  TextShooter
//
//  Created by  Jierism on 16/8/3.
//  Copyright (c) 2016年  Jierism. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 配置视图
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = false;
    skView.showsNodeCount = false;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;
    
    // 创建并配置场景
    GameScene *scene = [GameScene sceneWithSize:self.view.frame.size levelNumber:1];
    
    // 呈现场景
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


// 这段代码设置在游戏运行时隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
