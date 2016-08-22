//
//  ViewController.m
//  QuartzFun
//
//  Created by  Jierism on 16/8/1.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import "ViewController.h"
#import "Constants.h"
#import "QuartzFunView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *colorControl;

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

- (IBAction)changeColor:(UISegmentedControl *)sender {
    QuartzFunView *funView = (QuartzFunView *)self.view;
    ColorTabIndex index = [sender selectedSegmentIndex];
    switch (index) {
        case kRedColorTab:
            funView.currentColor = [UIColor redColor];
            funView.useRandomColor = NO;
            break;
        case kBuleColorTab:
            funView.currentColor = [UIColor blueColor];
            funView.useRandomColor = NO;
            break;
        case kYellowColorTab:
            funView.currentColor = [UIColor yellowColor];
            funView.useRandomColor = NO;
            break;
        case kGreenColorTab:
            funView.currentColor = [UIColor greenColor];
            funView.useRandomColor = NO;
            break;
        case kRandomColorTab:
            funView.useRandomColor = YES;
            break;
        default:
            break;
    }
    
}
- (IBAction)changeShape:(UISegmentedControl *)sender {
    [(QuartzFunView *)self.view setShapeType:[sender selectedSegmentIndex]];
    // 点击分段空点Image，颜色控件消失
    self.colorControl.hidden = [sender selectedSegmentIndex] == kImageShape;
}

@end
