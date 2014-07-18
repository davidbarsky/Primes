//
//  Grid.h
//  Primes
//
//  Created by David Barsky on 7/14/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNodeColor.h"

@interface Grid : CCNodeColor

@property (nonatomic, assign) NSInteger currentSum;
@property (nonatomic, assign) NSInteger goal;
@property (nonatomic, strong) NSMutableArray *tileValuesToCombine;

@end
