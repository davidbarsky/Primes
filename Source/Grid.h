//
//  Grid.h
//  Primes
//
//  Created by David Barsky on 7/14/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNodeColor.h"

@interface Grid : CCNodeColor

@property (nonatomic, assign) NSNumber* currentSum;
@property (nonatomic, assign) NSNumber* goal;
@property (nonatomic, assign) NSNumber* score;
@property (nonatomic, assign) NSNumber* timeLeft;

@property (nonatomic, strong) NSMutableArray *tileValuesToCombine;

@end
