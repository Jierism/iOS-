//
//  FourLines.m
//  Persistence
//
//  Created by  Jierism on 16/7/27.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import "FourLines.h"

static NSString * const kLinesKey = @"kLinesKey";

@implementation FourLines

#pragma mark - Coding
// 回复我们之前归档的对象
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.lines = [aDecoder decodeObjectForKey:kLinesKey];
    }
    return self;
}

// 将所有实例变成编码成aCoder
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.lines forKey:kLinesKey];
}

#pragma mark - Copying

- (id)copyWithZone:(NSZone *)zone
{
    // 新建一个新的FourLines对象，并将字符串数组复制进去
    FourLines *copy = [[[self class] allocWithZone:zone] init];
    NSMutableArray *linesCopy = [NSMutableArray array];
    for (  id line in self.lines) {
        [linesCopy addObject:[line copyWithZone:zone]];
    }
    copy.lines = linesCopy;
    return copy;
}

@end
