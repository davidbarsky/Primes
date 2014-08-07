//
//  Grid.h
//  Primes
//
//  Created by David Barsky on 7/14/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNodeColor.h"
#import <POP/POP.h>

@class MainScene;

@interface Grid : CCNodeColor

@property (nonatomic, assign) NSInteger goal; // used to set a goal per round
@property (nonatomic, assign) NSInteger score; // your total score.
@property (nonatomic, assign) NSInteger movesMadeThisRound; // should reset each round

@property (nonatomic, strong) NSMutableArray *tileValuesToCombine; // values that need to be combined

@property (nonatomic, assign) NSInteger roundNumber; // used to access array
@property (nonatomic, assign) NSInteger roundMaxMoveCount; // assigned each round to 

- (void)addTileValues;

@end