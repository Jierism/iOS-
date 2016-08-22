//
//  SearchResultsController.h
//  Sections
//
//  Created by  Jierism on 16/7/21.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultsController : UITableViewController
<UISearchResultsUpdating> // 用户在搜索栏输入时，协议的某个方法就会被调用以更新搜索结果

- (instancetype)initWithNames:(NSDictionary *)names keys:(NSArray *)keys;

@end
