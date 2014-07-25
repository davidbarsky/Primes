//
//  Grid.m
//  Primes
//
//  Created by David Barsky on 7/14/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "Grid.h"
#import "Tile.h"
#import "GameEnd.h"

@implementation Grid {
	CGFloat _columnWidth;
	CGFloat _columnHeight;
	CGFloat _tileMarginVertical;
	CGFloat _tileMarginHorizontal;
    NSMutableArray *_gridArray;
    NSNull *_noTile;
}

@synthesize tileValuesToCombine = _tileValuesToCombine;

static const NSInteger GRID_SIZE = 5;
static const NSInteger START_TILES = 25;
static const NSInteger MAX_MOVE_COUNT = 30;

#pragma mark - Game setup

- (void)didLoadFromCCB {
	// initializations
    
    [self setupBackground];
    self.tileValuesToCombine = [NSMutableArray array];
    self.score = 0;
    
    _noTile = [NSNull null];
	_gridArray = [NSMutableArray array];
	for (int i = 0; i < GRID_SIZE; i++) {
		_gridArray[i] = [NSMutableArray array];
		for (int j = 0; j < GRID_SIZE; j++) {
			_gridArray[i][j] = _noTile;
		}
	}
    self.goal = [NSNumber numberWithUnsignedInt:arc4random_uniform(5) + 5].intValue;
    [self spawnStartTiles];
    NSLog(@"%ld", (long)_movesMadeThisRound);
}

- (void)setupBackground {
    // load tile to read dimenions. Remember, you never declared size of the tiles.
	Tile *tile = (Tile*)[CCBReader load:@"Tile"];
    tile.gridReference = self;
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

- (void)endGameConditions {
    if (_movesMadeThisRound == MAX_MOVE_COUNT ) {
        [self endGame];
    }
}

- (void)endGame {
    GameEnd *gameEndPopover = (GameEnd *)[CCBReader load:@"GameEnd"];
    gameEndPopover.positionType = CCPositionTypeNormalized;
    gameEndPopover.position = ccp(0.5, 0.5);
    gameEndPopover.zOrder = INT_MAX;
    [gameEndPopover setFinalScore:(self.score)];
}

# pragma mark - Gameplay

- (void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    [self addTileValues];
}

// gets values from array, and combines them.
//TODO: add support for additional operators.
- (void)addTileValues {
    
    NSLog(@"%@", _tileValuesToCombine);
    
    for (int i = 0; i < [_tileValuesToCombine count]; i++) {
        //TODO: wtf
        NSInteger value = [_tileValuesToCombine objectAtIndex:i];
        //self.score.intValue = self.score.intValue + value.intValue;
    }
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
    tile.gridReference = self;
	_gridArray[column][row] = tile;
	tile.scale = 0.f;
	[self addChild:tile];
	tile.position = [self positionForColumn:column row:row];
    //TODO: write better animations
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
