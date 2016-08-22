//
//  SearchResultsController.h
//  Sections
//
//  Created by  Jierism on 16/7/21.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultsController : UICollectionViewController
<UISearchResultsUpdating>

- (instancetype)initWithNames:(NSDictionary *)names keys:(NSArray *)keys;

@end
