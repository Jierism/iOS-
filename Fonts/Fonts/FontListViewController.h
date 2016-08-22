//
//  FontListViewController.h
//  Fonts
//
//  Created by  Jierism on 16/7/23.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FontListViewController : UITableViewController

@property (copy, nonatomic) NSArray *fontNames;
@property (assign, nonatomic) BOOL showsFavorites;

@end
