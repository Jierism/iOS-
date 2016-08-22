//
//  ViewController.m
//  Persistence
//
//  Created by  Jierism on 16/7/27.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(strong,nonatomic)IBOutletCollection(UITextField) NSArray *lineFields;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 用NSFileManager类去检查数据文件是否存在：如果不存在就不加载，存在就用改文件内容实例化数据并将数组中的对象复制到4个文本框
    NSString *filePath = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSArray *array = [[NSArray alloc] initWithContentsOfFile:filePath];
        for (int i = 0; i < 4; i++) {
            UITextField *theFiled = self.lineFields[i];
            theFiled.text = array[i];
        }
    }
    
    // 订阅，获取通知
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillResignActive:)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:app];
}

// 接收通知，告诉应用在终止运行或者进入后台之前保存数据
- (void)applicationWillResignActive:(NSNotification *)notification
{
    NSString *filePath = [self dataFilePath];
    NSArray *array = [self.lineFields valueForKey:@"text"];
    [array writeToFile:filePath atomically:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 获取数据文件的完整路径（两步）
- (NSString *)dataFilePath
{
    //1.查找Documents目录
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [path objectAtIndex:0];
    //2.在后面附加数据文件的文件名
    return [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
}



@end
