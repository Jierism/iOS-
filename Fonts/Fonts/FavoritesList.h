//
//  FavoritesList.h
//  Fonts
//
//  Created by  Jierism on 16/7/23.
//  Copyright © 2016年  Jierism. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FavoritesList : NSObject

+ (instancetype)sharedFavoritesList;

- (NSArray *)favorites;

- (void)addFavorite:(id)item;
- (void)removeFavorite:(id)item;
- (void)moveItemAtIndex:(NSInteger)from toIndex:(NSInteger)to;

@end
