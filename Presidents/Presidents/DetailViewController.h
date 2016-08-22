//
//  DetailViewController.h
//  Presidents
//
//  Created by  Jierism on 16/7/24.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak,nonatomic) IBOutlet UIWebView *webView;

@property (strong,nonatomic) UIBarButtonItem *languageButton;
@property (strong,nonatomic) UIPopoverController *languagePopoverController;
@property (copy,nonatomic) NSString *languageString;

@end

