//
//  DoubleComponentPickerViewController.m
//  Pickers
//
//  Created by  Jierism on 16/7/19.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import "DoubleComponentPickerViewController.h"

#define kFillingComponent 0
#define kBreadComponent 1

@interface DoubleComponentPickerViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *doublePicker;
@property (strong,nonatomic) NSArray *fillingTypes;
@property (strong,nonatomic) NSArray *breadTypes;
@end

@implementation DoubleComponentPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 初始化滚轮的内容
    self.fillingTypes = @[@"Ham",
                       @"Turkey",
                       @"Peanut Butter",
                       @"Tuna Salad",
                       @"Chicken Salad",
                       @"Roast Beef",
                       @"Vegemite"];
    self.breadTypes = @[@"White",
                        @"Whole Wheat",
                        @"Rye",@"Sourdough",
                        @"Seven Grain"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
- (IBAction)buttonPressed:(id)sender {
    NSInteger fillingRow = [self.doublePicker selectedRowInComponent:kFillingComponent];
    NSInteger breadRow = [self.doublePicker selectedRowInComponent:kBreadComponent];
    
    NSString *filling = self.fillingTypes[fillingRow];
    NSString *bread = self.breadTypes[breadRow];
    
    NSString *message = [[NSString alloc] initWithFormat:@"Your %@ on %@ bread will be right up.",filling,bread];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Thank you for your order" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Great!" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark Picker Data Soure Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    // 滚轮数目2个
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == kBreadComponent) {
        return [self.breadTypes count];
    }else{
        return [self.fillingTypes count];
    }
}

#pragma mark Picker Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == kBreadComponent) {
        return self.breadTypes[row];
    }else{
        return self.fillingTypes[row];
    }
}

@end
