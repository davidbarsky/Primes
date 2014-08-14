//
//  Tile.h
//  Primes
//
//  Created by David Barsky on 7/14/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "Grid.h"

@interface Tile : CCNode

@property (nonatomic, strong) NSNumber* value;

@property (nonatomic, assign) BOOL mergedThisRound;

@property (nonatomic, assign) CGPoint tileLocation;

@property (nonatomic, weak) Grid* gridReference;

- (NSInteger)makeTileValueProportionaltoGoal:(NSInteger)goal;
- (void)updateValueDisplay;
- (void)highlightSelectedTile;
- (void)unhighlightSelectedTile;
- (void)animateTile;

@end
