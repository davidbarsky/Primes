//
//  Grid.m
//  Primes
//
//  Created by David Barsky on 7/14/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Grid.h"

@implementation Grid {
    CGFloat _columnWidth;
    CGFloat _columnHeight;
    CGFloat _tileMarginHorizontal;
    CGFloat _tileMarginVertical;
}

static const NSInteger GRID_SIZE = 5;

- (void)didLoadFromCCB {
    [self setupBackground];
}

- (void)setupBackground {
    // load tile to read dimenions. Remember, you never declared size of the tiles.
    
    CCNode *tile = [CCBReader load:@"Tile"];
    _columnWidth = tile.contentSize.width;
    _columnHeight = tile.contentSize.height;
    
    [tile performSelector:@selector(cleanup)];
    
    _tileMarginHorizontal = 0;
    _tileMarginVertical = 0;
    
    float x = _tileMarginHorizontal;
    float y = _tileMarginVertical;
    
    for (int i = 0; i < GRID_SIZE; i++) {
        
        x = _tileMarginHorizontal;
        
        for (int j = 0; j < GRID_SIZE; j++) {
            CCNodeColor *backgroundTile = [CCNodeColor nodeWithColor:[CCColor colorWithRed:145 green:246 blue:238]];
            backgroundTile.contentSize = CGSizeMake(_columnWidth, _columnHeight);
            backgroundTile.position = ccp(x, y);
            [self addChild:backgroundTile];
            x += _columnWidth + _tileMarginHorizontal;
        }
        y += _columnHeight + _tileMarginVertical;
    }
}

@end
