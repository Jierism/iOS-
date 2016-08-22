//
//  FontInfoViewController.h
//  Fonts
//
//  Created by  Jierism on 16/7/23.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FontInfoViewController : UITableViewController

@property (strong, nonatomic) UIFont *font;
@property (assign, nonatomic) BOOL favorite;

@end
