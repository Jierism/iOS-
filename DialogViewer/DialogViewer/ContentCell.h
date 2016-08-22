//
//  ContentCell.h
//  DialogViewer
//
//  Created by  Jierism on 16/7/23.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentCell : UICollectionViewCell

@property (strong,nonatomic) UILabel *label;
@property (copy,nonatomic) NSString *text;
@property (assign,nonatomic) CGFloat maxWidth;

+ (CGSize) sizeForContentString:(NSString *)string forMaxWidth:(CGFloat)maxWidth;

@end
