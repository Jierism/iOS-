//
//  ViewController.m
//  CheckPlease
//
//  Created by  Jierism on 16/8/4.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import "ViewController.h"
#import "CheckMarkRecognizer.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CheckMarkRecognizer *check = [[CheckMarkRecognizer alloc] initWithTarget:self action:@selector(doCheck:)];
    [self.view addGestureRecognizer:check];
    self.imageView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doCheck:(CheckMarkRecognizer *)check
{
    self.imageView.hidden = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.imageView.hidden = YES;
    });
}


@end
