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

// to access *value, use 'self.value.intValue'
// value is being used to access
@property (nonatomic, strong) NSNumber* value;

@property (nonatomic, assign) BOOL mergedThisRound;

@property (nonatomic, copy) Grid *gridReference;

- (void)updateValueDisplay;

@end
