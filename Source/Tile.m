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
        self.value = [NSNumber numberWithInteger:[self makeTileValueProportionaltoGoal:5]];
    }
    return self;
}

- (NSInteger)makeTileValueProportionaltoGoal:(NSInteger)goal {
    NSInteger proportionalTileValue = [NSNumber numberWithUnsignedInt:arc4random_uniform(goal) + 1].integerValue;
    
    return proportionalTileValue;
}

- (void)updateValueDisplay {
    _valueLabel.string = [NSString stringWithFormat:@"%d", self.value.intValue];
}

- (void)highlightSelectedTile {
    [_backgroundNode setColor:[CCColor colorWithRed:0.6f green:0.3f blue:0.4f alpha:1.0f ]];
}

- (void)unhighlightSelectedTile {
    [_backgroundNode setColor:[CCColor colorWithRed:0.77f green:0.28f blue:0.25f alpha:1.0f]];
}

@end
