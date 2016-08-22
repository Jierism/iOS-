//
//  ViewController.m
//  View Switcher
//
//  Created by  Jierism on 16/7/2.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import "SwitchingViewController.h"
#import "BlueViewController.h"
#import "YellowViewController.h"

@interface SwitchingViewController ()

@property (strong,nonatomic) BlueViewController *blueViewController;
@property (strong,nonatomic) YellowViewController *yellowViewController;

@end

@implementation SwitchingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.blueViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Blue"];
    self.blueViewController.view.frame = self.view.frame;
    [self switchFromViewController:nil toViewController:self.blueViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    if (!self.blueViewController.view.superview) {
        self.blueViewController = nil;
    }else{
        self.yellowViewController = nil;
    }
}


- (IBAction)switchViews:(id)sender{
    // 视情况创建新的视图控制器
    if (!self.yellowViewController.view.superview) {
        if (!self.yellowViewController) {
            self.yellowViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Yellow"];
        }
    }else{
        if (!self.blueViewController) {
            self.blueViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Blue"];
        }
    }
    
    // 加载视图控制器
    [UIView beginAnimations:@"View Flip" context:NULL];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    if (!self.yellowViewController.view.superview) {
        
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
        
        self.yellowViewController.view.frame = self.view.frame;
        [self switchFromViewController:self.blueViewController toViewController:self.yellowViewController];
    }else{
        
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
        
        self.blueViewController.view.frame = self.view.frame;
        [self switchFromViewController:self.yellowViewController toViewController:self.blueViewController];
    }
    [UIView commitAnimations];
    
}

- (void)switchFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (fromVC != nil) {
        [fromVC willMoveToParentViewController:nil];
        [fromVC.view removeFromSuperview];
        [fromVC removeFromParentViewController];
    }
    if (toVC != nil) {
        [self addChildViewController:toVC];
        [self.view insertSubview:toVC.view atIndex:0];
        [toVC didMoveToParentViewController:self];
    }
    
}



@end
