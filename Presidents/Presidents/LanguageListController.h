//
//  LanguageListController.h
//  Presidents
//
//  Created by  Jierism on 16/7/24.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DetailViewController;

@interface LanguageListController : UITableViewController

@property (weak,nonatomic) DetailViewController *detailViewController;
@property (copy,nonatomic) NSArray *languageNames;
@property (copy,nonatomic) NSArray *languageCodes;

@end
