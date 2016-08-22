//
//  SearchResultsController.m
//  Sections
//
//  Created by  Jierism on 16/7/21.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import "SearchResultsController.h"


static NSString *SectionsTableIndentifier = @"SectionsTableIndentifier";


@interface SearchResultsController ()



@property(strong,nonatomic) NSDictionary *names;
@property(strong,nonatomic) NSArray *keys;
@property(strong,nonatomic) NSMutableArray *filteredNames;

@end

@implementation SearchResultsController


// 搜索结果表的初始化函数
- (instancetype)initWithNames:(NSDictionary *)names keys:(NSArray *)keys
{
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        self.names = names;
        self.keys = keys;
        self.filteredNames = [[NSMutableArray alloc] init];
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 为结果控制器嵌入的表视图注册表单元的标识符
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:SectionsTableIndentifier];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.filteredNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SectionsTableIndentifier forIndexPath:indexPath];
    cell.textLabel.text = self.filteredNames[indexPath.row];
    return cell;
}

#pragma mark - UISearchReaultsUpdating Conformance

static const NSUInteger longNameSize = 6;
static const NSUInteger shortNamesButtonIndex = 1;
static const NSUInteger longNamesButtonIndex = 2;

- (void)updateSearchResultsForSearchController:(UISearchController *)controller
{
    // 从搜索栏中获取字符串和所选范围按钮的索引值，然后清除过滤后的名字列表
    NSString *searchString = controller.searchBar.text;
    NSInteger buttonIndex = controller.searchBar.selectedScopeButtonIndex;
    [self.filteredNames removeAllObjects];
    
    
    if (searchString.length > 0) {
        
        // 定义一个谓词predicate，用于判断名字与搜索字符串是否匹配
        NSPredicate *predicate =
        [NSPredicate predicateWithBlock:^BOOL(NSString *name,NSDictionary *b) {
            // 根据所选择的范围按钮可以筛选名称的长度
            NSInteger nameLength = name.length;
            if ((buttonIndex == shortNamesButtonIndex && nameLength >= longNameSize) || (buttonIndex == longNamesButtonIndex && nameLength < longNameSize)) {
                return NO;
            }
            
            // 寻找字符串是否有搜索字符串的分段，找到则匹配成功
            NSRange range = [name rangeOfString:searchString options:NSCaseInsensitiveSearch];
            return range.location != NSNotFound;
        }];
        for (NSString *key in self.keys) {
            NSArray *matches = [self.names[key] filteredArrayUsingPredicate:predicate];
            [self.filteredNames addObjectsFromArray:matches];
        }
    }
    [self.tableView reloadData];
}




@end
