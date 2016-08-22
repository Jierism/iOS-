//
//  ViewController.m
//  SQLite Persistence
//
//  Created by  Jierism on 16/7/27.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import "ViewController.h"
#import <sqlite3.h>

@interface ViewController ()

@property (strong,nonatomic) IBOutletCollection(UITextField) NSArray *lineFields;

@end

@implementation ViewController

- (NSString *)dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingString:@"data.sqlite"];
}

// 数据库在应用打开时才打开用于加载数据，加载完毕后会关闭
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 打开数据库，如果在打开时遇到问题则关闭，并抛出断言错误
    sqlite3 *database;
    if (sqlite3_open([[self dataFilePath] UTF8String],&database) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    
    // 建立一个表来保存我们的数据，用IF NOT可以防止数据库覆盖现有数据：如果已有相同名的表则此命令不执行操作
    NSString *createSQL = @"CREATE TABLE IF NOT EXISTS FIELDS "
    "(ROW INTEGER PRIMAY KEY,FIELD_DATA TEXT);";
    char *errorMsg;
    if (sqlite3_exec (database,[createSQL UTF8String],NULL,NULL,&errorMsg) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Error creating table:%s",errorMsg);
    }
    
    // 数据库中没一行包含一个整型（从0计数）和一个字符串（对应行的内容），加载内容
    NSString *query = @"SELECT ROW,FIELD_DATA FROM FIELDS ORDER BY ROW";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database,[query UTF8String],-1,&statement,nil) == SQLITE_OK) {
        // 遍历返回的每一行
        while (sqlite3_step(statement) == SQLITE_ROW) {
            // 抓取行号存储在一个int变量中，抓取字段数据保存在char类型的字符串中
            int row = sqlite3_column_int(statement,0);
            char *rowData = (char *)sqlite3_column_text(statement,1);
            // 利用从数据库中获取的值设置相应的字段
            NSString *fieldValue = [[NSString alloc] initWithUTF8String:rowData];
            UITextField *field = self.lineFields[row];
            field.text = fieldValue;
        }
        // 关闭数据库连接
        sqlite3_finalize(statement);
    }
    sqlite3_close(database);
    
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:app];
    
    
}

- (void)applicationWillResignActive:(NSNotification *)notification
{
    // 打开数据库
    sqlite3 *database;
    if (sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    
    // 遍历数据库每一行，更新里面的数据
    for (int i = 0; i < 4; i++) {
        UITextField *field = self.lineFields[i];
        char *update = "INSERT OR REPLACE INTO FIELDS (ROW,FIELD_DATA)"
                        "VALUES(?,?)";
        char *errorMsg = NULL;
        
        // 声明一个指向语句的指针，然后为语句添加绑定变量，并将值绑定到两个绑定变量
        sqlite3_stmt *stmt;
        if (sqlite3_prepare_v2(database, update, -1, &stmt, nil) == SQLITE_OK) {
            sqlite3_bind_int(stmt,1,i);
            sqlite3_bind_text(stmt,2,[field.text UTF8String],-1,NULL);
        }
        // 调用sqlite3_step来执行更新，检查并确定其运行正常，然后完成语句，结束循环
        if (sqlite3_step(stmt) != SQLITE_DONE) {
            NSAssert(0, @"Error updating table:%s",errorMsg);
        }
        sqlite3_finalize(stmt);
    }
    // 关闭数据库
    sqlite3_close(database);
}



@end
