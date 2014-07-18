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

@property (nonatomic, strong) NSNumber *value;

// to access *value, use 'self.value.intValue'

@property (nonatomic, copy) Grid *gridReference;

- (void)updateValueDisplay;

@end
