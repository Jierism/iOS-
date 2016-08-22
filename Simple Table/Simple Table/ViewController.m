//
//  ViewController.m
//  Simple Table
//
//  Created by  Jierism on 16/7/20.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
// 声明一个数组，用来储存表单元的内容
@property(copy,nonatomic) NSArray *dwarves;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 初始化表单元的内容
    self.dwarves = @[@"SLEEPY",@"SNEEZY",@"BASHFUL",@"HAPPY",@"DOC",@"GRUMPY",@"DOPEY",@"THORIN",@"DORIN",
                     @"NORI",@"ORI",@"BALIN",@"DWALIN",@"FILI",@"KILI",@"OIN",@"GLOIN",@"BIFUR",@"BOFUR"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 返回数组的元素个数，即cell的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dwarves count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 声明一个静态字符串实例，作为键使用，用来表示某种表单元
    // 比较复杂的表需要根据它们的内容和位置使用不同的类型的表单元，这样就需要不同的表单元标识符来区分每一种表单元类型
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    
    // 生成表单元
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    // 当视图中没有表单元时，生成表单元，数目为数组的元素个数
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle // 设置cell的样式，这里为默认
                                      reuseIdentifier:SimpleTableIdentifier];
    }
    
    // 在每个表单元前面插入一个图像
    UIImage *image = [UIImage imageNamed:@"star"];  // 普通状态时显示这个
    cell.imageView.image = image;
    UIImage *highlightedImage = [UIImage imageNamed:@"star2"]; // 被点击时显示这个
    cell.imageView.highlightedImage = highlightedImage;
    
    cell.textLabel.text = self.dwarves[indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:25]; // 改变字体大小
    
    // 设置每行的细节文本，当cell的样式设置为非默认才会显示
    if (indexPath.row < 7) {
        cell.detailTextLabel.text = @"Mr.Disney";  // 前面7行的内容是Mr.Disney
    }else{
        cell.detailTextLabel.text = @"Mr.Tolkien"; // 后面的内容是 Mr.Tolkien
    }
    return cell;
}

// 设置行单元级缩进
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row % 4;
}

// 设置行不能被选中，这里指定第一行
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return nil;
    }else{
        return indexPath;
    }
}


// 警告显示
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *rowValue = self.dwarves[indexPath.row];
    NSString *message = [[NSString alloc] initWithFormat:@"You selected %@",rowValue];
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Row Selected!" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Yes I did" style:UIAlertActionStyleDefault handler:nil];
    
    [controller addAction:cancelAction];
    [self presentViewController:controller animated:YES completion:nil];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

// 修改行的高度,这里指定除了第一行是120以外，其他行均为70r
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row == 0 ? 120:70;
}

@end
