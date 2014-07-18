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
	CGFloat _tileMarginVertical;
	CGFloat _tileMarginHorizontal;
    NSMutableArray *_gridArray;
    NSNull *_noTile;
}

@synthesize tileValuesToCombine = _tileValuesToCombine;

#pragma mark - Constants

static const NSInteger GRID_SIZE = 5;
static const NSInteger START_TILES = 25;

- (void)didLoadFromCCB {
	[self setupBackground];
    
    self.tileValuesToCombine = [NSMutableArray alloc];
    
    _noTile = [NSNull null];
	_gridArray = [NSMutableArray array];
	for (int i = 0; i < GRID_SIZE; i++) {
		_gridArray[i] = [NSMutableArray array];
		for (int j = 0; j < GRID_SIZE; j++) {
			_gridArray[i][j] = _noTile;
		}
	}
    
    [self spawnStartTiles];
}

#pragma mark - Sets up Tile background

- (void)setupBackground {
    // load tile to read dimenions. Remember, you never declared size of the tiles.
	CCNode *tile = [CCBReader load:@"Tile" owner:self];
	_columnWidth = tile.contentSize.width;
	_columnHeight = tile.contentSize.height;
    
    // hotfix
        [tile performSelector:@selector(cleanup)];
    
    _tileMarginHorizontal = (self.contentSize.width - (GRID_SIZE * _columnWidth)) / (GRID_SIZE+1);
    _tileMarginVertical = (self.contentSize.height - (GRID_SIZE * _columnHeight)) / (GRID_SIZE+1);
    
	// set up initial x and y positions
	float x = _tileMarginHorizontal;
	float y = _tileMarginVertical;

	for (int i = 0; i < GRID_SIZE; i++) {
        // iterate through each row
		x = _tileMarginHorizontal;

		for (int j = 0; j < GRID_SIZE; j++) {
			//  iterate through each column in the current row
			CCNodeColor *backgroundTile = [CCNodeColor nodeWithColor:[CCColor grayColor]];
			backgroundTile.contentSize = CGSizeMake(_columnWidth, _columnHeight);
			backgroundTile.position = ccp(x, y);
			[self addChild:backgroundTile];
			x+= _columnWidth + _tileMarginHorizontal;
		}
		y += _columnHeight + _tileMarginVertical;
	}
}

# pragma mark - Gameplay

// gets values from array, and combines them.
//TODO: add support for additional operators.
- (void)addTileValues {
    
    for (int i = 0; i < [_tileValuesToCombine count]; i++) {
        NSInteger value = [_tileValuesToCombine objectAtIndex:i];
        self.currentSum += value;
    }
 
    // clears for next move
    [_tileValuesToCombine removeAllObjects];
}

# pragma mark - Tile Spawners

//TODO: make more efficent than randomly distributing
- (void)spawnRandomTile {
	BOOL spawned = FALSE;
	while (!spawned) {
		NSInteger randomRow = arc4random() % GRID_SIZE;
		NSInteger randomColumn = arc4random() % GRID_SIZE;
		BOOL positionFree = (_gridArray[randomColumn][randomRow] == _noTile);
		if (positionFree) {
			[self addTileAtColumn:randomColumn row:randomRow];
			spawned = TRUE;
		}
	}
}

- (void)spawnStartTiles {
    for (int i = 0; i < START_TILES; i++) {
        [self spawnRandomTile];
    }
}

- (void)addTileAtColumn:(NSInteger)column row:(NSInteger)row {
	Tile *tile = (Tile*) [CCBReader load:@"Tile"];
	_gridArray[column][row] = tile;
	tile.scale = 0.f;
	[self addChild:tile];
	tile.position = [self positionForColumn:column row:row];
    //TODO: sort out timing
	CCActionDelay *delay = [CCActionDelay actionWithDuration:0.3f];
	CCActionScaleTo *scaleUp = [CCActionScaleTo actionWithDuration:0.2f scale:1.f];
	CCActionSequence *sequence = [CCActionSequence actionWithArray:@[delay, scaleUp]];
	[tile runAction:sequence];
}

- (CGPoint)positionForColumn:(NSInteger)column row:(NSInteger)row {
	NSInteger x = _tileMarginHorizontal + column * (_tileMarginHorizontal + _columnWidth);
	NSInteger y = _tileMarginVertical + row * (_tileMarginVertical + _columnHeight);
	return CGPointMake(x,y);
}

@end
