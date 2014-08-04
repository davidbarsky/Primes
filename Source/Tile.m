//
//  Tile.m
//  Primes
//
//  Created by David Barsky on 7/14/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Tile.h"

@implementation Tile {
    CCLabelTTF *_valueLabel;
    CCNodeColor *_backgroundNode;
}

- (void)didLoadFromCCB {
    [self updateValueDisplay];
}

- (id)init {
    if (self = [super init]) {
        self.value = [NSNumber numberWithUnsignedInt:arc4random_uniform(9) + 1];
    }
    return self;
}

- (void)updateValueDisplay {
    _valueLabel.string = [NSString stringWithFormat:@"%d", self.value.intValue];
}

@end
