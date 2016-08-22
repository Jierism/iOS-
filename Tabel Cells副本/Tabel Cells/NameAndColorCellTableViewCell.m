//
//  NameAndColorCellTableViewCell.m
//  Tabel Cells
//
//  Created by  Jierism on 16/7/21.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import "NameAndColorCellTableViewCell.h"

@interface NameAndColorCellTableViewCell ()

@property(strong,nonatomic) IBOutlet UILabel *nameLabel;
@property(strong,nonatomic) IBOutlet UILabel *colorLabel;

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
