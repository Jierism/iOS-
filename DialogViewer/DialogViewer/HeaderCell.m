//
//  HeaderCell.m
//  DialogViewer
//
//  Created by  Jierism on 16/7/23.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import "HeaderCell.h"

@implementation HeaderCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label.backgroundColor = [UIColor colorWithRed:0.8 green:0.9 blue:1.0 alpha:1.0];
        self.label.textColor = [UIColor blackColor];
    }
    return self;
}

+ (UIFont *)defaultFont
{
    return [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}


@end
