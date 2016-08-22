//
//  NameAndColorCellTableViewCell.m
//  Tabel Cells
//
//  Created by  Jierism on 16/7/21.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import "NameAndColorCellTableViewCell.h"

@interface NameAndColorCellTableViewCell ()

// 定义两个属性变量
@property(strong,nonatomic) UILabel *nameLabel;
@property(strong,nonatomic) UILabel *colorLabel;

@end

@implementation NameAndColorCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 初始化代码
        // 往表单元里面添加子视图
        // 这里在每个表单元里添加了四个Label
        CGRect nameLabelRect = CGRectMake(0, 5, 70, 15);
        UILabel *nameMaker = [[UILabel alloc] initWithFrame:nameLabelRect];
        nameMaker.textAlignment = NSTextAlignmentRight;  // 右对齐
        nameMaker.text = @"Name:";
        nameMaker.font = [UIFont boldSystemFontOfSize:12];
        [self.contentView addSubview:nameMaker];
        
        CGRect colorLabelRect = CGRectMake(0, 26, 70, 15);
        UILabel *colorMaker = [[UILabel alloc] initWithFrame:colorLabelRect];
        colorMaker.textAlignment = NSTextAlignmentRight;
        colorMaker.text = @"Color:";
        colorMaker.font = [UIFont boldSystemFontOfSize:12];
        [self.contentView addSubview:colorMaker];
        
        CGRect nameValueRect = CGRectMake(80, 5, 200, 15);
        self.nameLabel = [[UILabel alloc] initWithFrame:nameValueRect];
        [self.contentView addSubview:_nameLabel];
        
        CGRect colorValueRect = CGRectMake(80, 25, 200, 15);
        self.colorLabel = [[UILabel alloc] initWithFrame:colorValueRect];
        [self.contentView addSubview:_colorLabel];
        
    }
    return self;
}

// 重写了Name和Color的set方法，当传递一个新的值时，更新标签的额内容
- (void) setName:(NSString *)n {
    if (![n isEqualToString:_name]) {
        _name = [n copy];
        self.nameLabel.text = _name;
    }
}

- (void)setColor:(NSString *)c {
    if (![c isEqualToString:_color]) {
        _color = [c copy];
        self.colorLabel.text = _color;
    }
}

@end
