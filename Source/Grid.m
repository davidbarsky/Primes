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
    // for creating/accessing tiles on grid
    CGFloat _columnWidth;
	CGFloat _columnHeight;
	CGFloat _tileMarginVertical;
	CGFloat _tileMarginHorizontal;

    // for creating the tiles on the grid
    NSMutableArray *_gridArray;
    NSNull *_noTile;
    
    // for touch handling
    NSMutableSet *_touchedTileSet;
}

static const NSInteger MIN_ACCEPTED_TILES = 2;
static const NSInteger GRID_SIZE = 6;
static const NSInteger MAX_MOVE_COUNT = 5;

#pragma mark - Game setup

- (void)didLoadFromCCB {

    [self setupBackground];
    self.userInteractionEnabled = true;
    
    _touchedTileSet = [NSMutableSet set];
    _tileValuesToCombine = [NSMutableArray array];
    
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
}

- (void)setupBackground {
    // loads tile to read dimensions.
	Tile *tile = (Tile*)[CCBReader load:@"Tile"];
    tile.gridReference = self;
	_columnWidth = tile.contentSize.width;
	_columnHeight = tile.contentSize.height;
    
        // hotfix to prevent crashing. Bug in Cocos2dX
        [tile performSelector:@selector(cleanup)];
    
    _tileMarginHorizontal = (self.contentSize.width - (GRID_SIZE * _columnWidth)) / (GRID_SIZE+1);
    _tileMarginVertical = (self.contentSize.height - (GRID_SIZE * _columnHeight)) / (GRID_SIZE+1);
    
	float x = _tileMarginHorizontal;
	float y = _tileMarginVertical;

	for (int i = 0; i < GRID_SIZE; i++) {
		x = _tileMarginHorizontal;
		for (int j = 0; j < GRID_SIZE; j++) {
			CCNodeColor *backgroundTile = [CCNodeColor nodeWithColor:[CCColor grayColor]];
			backgroundTile.contentSize = CGSizeMake(_columnWidth, _columnHeight);
			backgroundTile.position = ccp(x, y);
			[self addChild:backgroundTile];
			x+= _columnWidth + _tileMarginHorizontal;
		}
		y += _columnHeight + _tileMarginVertical;
	}
}

# pragma mark - Touch Handlers

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint touchInWorld = [touch locationInNode:self];
    float cellSize = self.contentSize.height/GRID_SIZE;

    NSValue *val = [NSValue valueWithCGPoint:CGPointMake(floorf(touchInWorld.x/cellSize), floorf(touchInWorld.y/cellSize))];

    [_touchedTileSet addObject:val];
}

- (void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchInWorld = [touch locationInNode:self];
    float cellSize = self.contentSize.height/GRID_SIZE;
    
    NSValue *val = [NSValue valueWithCGPoint:CGPointMake(floorf(touchInWorld.x/cellSize), floorf(touchInWorld.y/cellSize))];
    
    [_touchedTileSet addObject:val];
}

- (void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    if ([_touchedTileSet count] >= MIN_ACCEPTED_TILES) {
         [self addTileValues];
    }
}

# pragma mark - Gameplay

- (void)addTileValues {
    for (NSValue *val in _touchedTileSet) {
        [_tileValuesToCombine addObject:val];
    }
    
    NSInteger currentSum = 0;
    
    for (int i = 0; i < [_tileValuesToCombine count]; i++) {
        NSNumber *value = [_tileValuesToCombine objectAtIndex:i];
        
        CGPoint point = value.CGPointValue;
        
        NSInteger x = point.x;
        NSInteger y = point.y;
        
        Tile *tempTile = _gridArray[x][y];
        
        currentSum += tempTile.value.intValue;
    }
    
    if (currentSum == self.goal) {
        self.score++;
        self.movesMadeThisRound++;
    }
    
    [self replaceTappedTiles];
    [self resetRoundVariables];
    
    if (self.movesMadeThisRound == MAX_MOVE_COUNT) {
        [self endGame];
    }
    
    NSLog(@"currentSum: %ld", (long)currentSum);
    NSLog(@"After: %ld", (long)self.score);
    NSLog(@"Goal is: %ld", (long)self.goal);
}

- (void)replaceTappedTiles {
    CCActionRemove *remove = [CCActionRemove action];

    for (NSValue *val in _touchedTileSet) {
        CGPoint p = [val CGPointValue];
        
        NSInteger x = p.x;
        NSInteger y = p.y;
        
        Tile *tileToRemove = _gridArray[x][y];
        _gridArray[x][y] = _noTile;
        
        [tileToRemove runAction:remove];
        [self addTileAtColumn:x row:y];
    }
}

- (void)resetRoundVariables {
    [_tileValuesToCombine removeAllObjects];
    [_touchedTileSet removeAllObjects];
}

# pragma mark - Tile Spawners

- (void)spawnStartTiles {
    for (int i = 0; i < GRID_SIZE; i++) {
        for (int j = 0; j < GRID_SIZE; j++) {
            [self addTileAtColumn:i row:j];
        }
    }
}

- (void)addTileAtColumn:(NSInteger)column row:(NSInteger)row {
	Tile *tile = (Tile*) [CCBReader load:@"Tile"];
    tile.gridReference = self;
	_gridArray[column][row] = tile;
	tile.scale = 0.f;
    CGPoint tileLocationInArray = CGPointMake(column, row);
    [tile setTileLocation:tileLocationInArray];
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


# pragma mark - End Game Conditions

- (void)endGame {
    GameEnd *gameEndPopover = (GameEnd *)[CCBReader load:@"GameEnd"];
    gameEndPopover.positionType = CCPositionTypeNormalized;
    gameEndPopover.position = ccp(0.5, 0.5);
    gameEndPopover.zOrder = INT_MAX;

    [gameEndPopover setFinalScore:(self.score)];
    
    [self addChild:gameEndPopover];
}

@end
