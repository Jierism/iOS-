//
//  ViewController.m
//  Persistence
//
//  Created by  Jierism on 16/7/27.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import "ViewController.h"
#import "FourLines.h"

static NSString * const kRootKey = @"kRootKey";
@interface ViewController ()

@property(strong,nonatomic)IBOutletCollection(UITextField) NSArray *lineFields;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    NSString *filePath = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        
    // 从归档中重组对象，对数据进行解码
        NSData *data = [[NSMutableData alloc] initWithContentsOfFile:filePath];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        FourLines *foueLines = [unarchiver decodeObjectForKey:kRootKey];
        [unarchiver finishDecoding];
        
        for (int i = 0; i < 4; i++) {
            UITextField *theFiled = self.lineFields[i];
            theFiled.text = foueLines.lines[i];
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
- (void) applicationWillResignActive:(NSNotification *)notification
{
    NSString *filePath = [self dataFilePath];
    
    // 将对象归档到data实例中
    FourLines *fourLines = [[FourLines alloc] init];
    fourLines.lines = [self.lineFields valueForKey:@"text"];
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:fourLines forKey:kRootKey];
    [archiver finishEncoding];
    [data writeToFile:filePath atomically:YES];
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
    return [documentsDirectory stringByAppendingPathComponent:@"data.archive"];
}



@end
