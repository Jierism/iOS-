//
//  ViewController.m
//  Core Data Persistance
//
//  Created by  Jierism on 16/7/27.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

static NSString * const kLineEntityName = @"Line";
static NSString * const kLineNumberKey = @"lineNumber";
static NSString * const kLineTextKey = @"lineText";

@interface ViewController ()

@property (strong,nonatomic) IBOutletCollection(UITextField) NSArray *lineFields;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 获取对应用委托的引用，使用这个引用获得为我们创建的托管对象上下文
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    // 创建一个获取请求并将实体描述传递给它，以便请求指导要检索的对象类型
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:kLineEntityName];
    
    // 检索存储中所有Line对象，上下文返回库中每一个Line对象。确保返回的是有效数组，否则记录相应日志
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    if (objects == nil) {
        NSLog(@"There was an error!"); // 进行适当错误处理
    }
    
    // 使用快熟枚举遍历已获取托管对象的数组，从中提取每个托管对象的lineNum和lineText的值，并用该信息更新用户界面上的文本框
    for (NSManagedObject *oneObject in objects) {
        int lineNum = [[oneObject valueForKey:kLineNumberKey] intValue];
        NSString *lineText = [oneObject valueForKey:kLineTextKey];
        
        UITextField *theField = self.lineFields[lineNum];
        theField.text = lineText;
    }
    
    // 在应用终止时获取通知，保存更改
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:app];
}


- (void)applicationWillResignActive:(NSNotification *)notification
{
    
    // 与上面一样，获取对应用委托的引用，使用引用获取指向应用的默认托管对象上下文的指针
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    
    NSError *error;
    
    // 获得每一个字段对应的索引
    for (int i = 0; i < 4; i++) {
        UITextField *theField = self.lineFields[i];
        
        
        // 为Line实体创建获取请求，创建一个谓词确认存储中是否已经有一个与这个字段对应的托管对象
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:kLineEntityName];
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"(%K = %d)",kLineNumberKey,i]; // 谓词
        [request setPredicate:pred];
        
        // 在上下文中执行后去请求，并检查objects是否为nil
        
        NSArray *objects = [context executeFetchRequest:request error:&error];
        if (objects == nil) {
            NSLog(@"There was an error!");
        }
        
        // 声明一个指向NSManagedObject的指针并设置为nil。因为我们不知道要从持久存储中加载托管对象，还是创建新的托管对象。
        // 因此，可以检查与条件匹配的返回对象。如果返回有效的对象就进行加载，否则就创建一个新的托管对象来保存这个字段的文本
        NSManagedObject *theLine = nil;
        if ([objects count] > 0) {
            theLine = [objects objectAtIndex:0];
        }else{
            theLine = [NSEntityDescription insertNewObjectForEntityForName:kLineEntityName inManagedObjectContext:context];
        }
        
        // 使用键-值编码（KVC）来设置行号以及此托管对象的文本
        [theLine setValue:[NSNumber numberWithInt:i] forKey:kLineNumberKey];
        [theLine setValue:theField.text forKey:kLineTextKey];
    }
    // 完成循环，保存更改
    [appDelegate saveContext];
}

@end
