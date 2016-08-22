//
//  ViewController.m
//  Sections
//
//  Created by  Jierism on 16/7/21.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import "ViewController.h"
#import "SearchResultsController.h"

static NSString *SectionsTableIdentifier = @"SectionsTableIdentifier";

@interface ViewController ()

@property(copy,nonatomic) NSDictionary *names;
@property(copy,nonatomic) NSArray *keys;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong,nonatomic) UISearchController *searchController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 注册一个类来创建新的cell，并从属性列表里面加载内容
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:SectionsTableIdentifier];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sortednames" ofType:@"plist"];
    self.names = [NSDictionary dictionaryWithContentsOfFile:path];
    self.keys = [[self.names allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    // 创建结果控制器，然后创建UISearchController，并将它的引用传递给结果控制器，UISearchController在搜索结果时会出现这个视图控制器
    SearchResultsController *resultsController = [[SearchResultsController alloc] initWithNames:self.names keys:self.keys];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:resultsController];
    
    // 配置UISearchBar
    UISearchBar *searchBar = self.searchController.searchBar;
    searchBar.scopeButtonTitles = @[@"All",@"Short",@"Long"];
    searchBar.placeholder = @"Enter a search term"; // 设置搜索器的占位符
    
    // 获取搜索栏并将其作为主视图控制器中表视图的顶部视图
    [searchBar sizeToFit];
    self.tableView.tableHeaderView = searchBar;
    
    // 用searchResultsUpdater属性的对象来更新搜索结果
    self.searchController.searchResultsUpdater = resultsController;
    
    // 反色显示索引分区
    self.tableView.sectionIndexBackgroundColor = [UIColor blackColor];
    self.tableView.sectionIndexTrackingBackgroundColor = [UIColor darkGrayColor];
    self.tableView.sectionIndexColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table View Data Source Methods

// 告诉视图，字典中的每个键都有一个分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.keys count];
}


// 计算特定分区中的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = self.keys[section];
    NSArray *nameSection = self.names[key];
    return [nameSection count];
}


// 为每个分区指定一个特定的标题，这里用每组对应的首字母
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.keys[section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SectionsTableIdentifier forIndexPath:indexPath];
    
    NSString *key = self.keys[indexPath.section];
    NSArray *nameSection = self.names[key];
    
    cell.textLabel.text = nameSection[indexPath.row];
    return cell;
    
}

#pragma mark 添加索引
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.keys;
}





@end
