//
//  Grid.h
//  Primes
//
//  Created by David Barsky on 7/14/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNodeColor.h"

@class MainScene;

@interface Grid : CCNodeColor

@property (nonatomic, assign) NSInteger goal;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, assign) NSInteger timeLeft;
@property (nonatomic, assign) NSInteger movesMadeThisRound;

@property (nonatomic, strong) NSMutableArray *tileValuesToCombine;

@property (nonatomic, assign) NSInteger roundNumber;
@property (nonatomic, assign) NSInteger roundMaxMoveCount;

- (void)addTileValues;

@end