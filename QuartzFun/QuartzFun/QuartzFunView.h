//
//  QuartzFunView.h
//  QuartzFun
//
//  Created by  Jierism on 16/8/1.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface QuartzFunView : UIView

@property (assign,nonatomic) ShapeType shapeType;
@property (assign,nonatomic) BOOL useRandomColor;
@property (strong,nonatomic) UIColor *currentColor;

@end
