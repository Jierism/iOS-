//
//  DetailViewController.m
//  Presidents
//
//  Created by  Jierism on 16/7/24.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import "DetailViewController.h"
#import "LanguageListController.h"

@interface DetailViewController ()<UIPopoverControllerDelegate>

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
    
}

// 这是一本个函数，仅在两个字符串上执行一项操作并返回另一个字符串
static NSString * modifyUrlForLanguage(NSString *url,NSString *lang)
{
    if (!lang) {
        return url;
    }
    
    NSRange codeRange = NSMakeRange(7, 2);
    if ([[url substringWithRange:codeRange] isEqualToString:lang]) {
        return url;
    }else{
        NSString *newUrl = [url stringByReplacingCharactersInRange:codeRange withString:lang];
        return newUrl;
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        NSDictionary *dict = (NSDictionary *)self.detailItem;
        
        NSString *urlString = modifyUrlForLanguage(dict[@"url"], self.languageString);
        
        self.detailDescriptionLabel.text = urlString;
        
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *resquest = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:resquest];
        
        NSString *name = dict[@"name"];
        self.title = name;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 创建一个UIBarButtonItem并置于屏幕顶部的UINavigationItem中,(只在IPad中运行时会添加这个按钮)
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.languageButton = [[UIBarButtonItem alloc] initWithTitle:@"Choose Language"
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(toggleLanguagePopover)];
    }
    [self configureView];
}

- (void)setLanguageString:(NSString *)newString
{
    if (![newString isEqualToString:self.languageString]) {
        _languageString = [newString copy];
        [self configureView];
    }
    
    if (self.languagePopoverController != nil) {
        [self.languagePopoverController dismissPopoverAnimated:YES];
        self.languagePopoverController = nil;
    }
}

- (void)toggleLanguagePopover
{
    if (self.languagePopoverController == nil) {
        LanguageListController *languageListController = [[LanguageListController alloc] init];
        languageListController.detailViewController = self;
        UIPopoverController *poc = [[UIPopoverController alloc] initWithContentViewController:languageListController];
        [poc presentPopoverFromBarButtonItem:self.languageButton
                    permittedArrowDirections:UIPopoverArrowDirectionAny
                                    animated:YES];
        self.languagePopoverController = poc;
    }else{
        [self.languagePopoverController dismissPopoverAnimated:YES];
        self.languagePopoverController = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 实现点击屏幕其他地方，关闭语言弹出窗口
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    if (popoverController == self.languagePopoverController) {
        self.languagePopoverController = nil;
    }
}


@end
