//
//  Grid.m
//  Primes
//
//  Created by David Barsky on 7/14/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Grid.h"
#import "Tile.h"

@implementation Grid {
    CGFloat _columnWidth;
    CGFloat _columnHeight;
    CGFloat _tileMarginHorizontal;
    CGFloat _tileMarginVertical;
    NSMutableArray *_gridArray;
    NSNull *_noTile;
}

#pragma mark - Constants

static const NSInteger GRID_SIZE = 5;
static const NSInteger START_TILES = 25;

- (void)didLoadFromCCB {
    [self setupBackground];
    
    _noTile = [NSNull null];
    _gridArray = [NSMutableArray array];
    
    for (int i = 0; i < GRID_SIZE; i++) {
        _gridArray[i]= [NSMutableArray array];
        for (int j = 0; j < GRID_SIZE; j++) {
            _gridArray[i][j] = _noTile;
        }
    }
    
//    [self spawnStartingTiles];
}

- (void)setupBackground {
    // load tile to read dimenions. Remember, you never declared size of the tiles.
    
    CCNode *tile = [CCBReader load:@"Tile"];
    
    _columnWidth = tile.contentSize.width;
    _columnHeight = tile.contentSize.height;
    
    // hotfix
        [tile performSelector:@selector(cleanup)];
    
    _tileMarginHorizontal = 2;
    NSLog(@"%f", _tileMarginHorizontal);
    _tileMarginVertical = 2;
    NSLog(@"%f", _tileMarginVertical);
    
    float x = _tileMarginHorizontal;
    float y = _tileMarginVertical;
    
    for (int i = 0; i < GRID_SIZE; i++) {
        
        x = _tileMarginHorizontal;
        
        for (int j = 0; j < GRID_SIZE; j++) {
            CCNodeColor *backgroundTile = [CCNodeColor nodeWithColor:[CCColor grayColor]];
            backgroundTile.contentSize = CGSizeMake(_columnWidth, _columnHeight);
            backgroundTile.position = ccp(x, y);
            [self addChild:backgroundTile];
            x += _columnWidth + _tileMarginHorizontal;
        }
        y += _columnHeight + _tileMarginVertical;
    }
}

# pragma mark - tile helper methods

- (void)addTileAtColumn:(NSInteger)column row:(NSInteger)row {
    Tile *tile = (Tile *) [CCBReader load:@"tile"];
    _gridArray[column][row] = tile;
    tile.scale = 0.f;
    [self addChild:tile];
    self.position = [self positionForColumn:column row:row];
    //TODO: sort out timing
    CCActionDelay *delay = [CCActionDelay actionWithDuration:0.3f];
    CCActionScaleTo *scaleUp = [CCActionScaleTo actionWithDuration:0.2f scale:1.f];
    CCActionSequence *sequence = [CCActionSequence actionWithArray:@[delay, scaleUp]];
    [tile runAction:sequence];
}

- (CGPoint)positionForColumn:(NSInteger)column row:(NSInteger)row {
    return CGPointMake(column, row);
}

- (void)spawnStartingTiles {
    for (int i = 0; i < GRID_SIZE; i++) {
        for (int j = 0; j < GRID_SIZE; j++) {
            [self addTileAtColumn:i row:j];
            NSLog(@"%d", i);
        }
    }
}

@end
