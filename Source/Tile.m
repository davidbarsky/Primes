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
        // activates touches
        self.userInteractionEnabled = TRUE;
        self.value = [NSNumber numberWithUnsignedInt:arc4random()%10];
    }
    return self;
}

- (void)updateValueDisplay {
    _valueLabel.string = [NSString stringWithFormat:@"%d", self.value.intValue];
}

//- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
////    NSLog(@"TouchBegan, current tile value: %@ " ,self.value);
//    [self.gridReference.tileValuesToCombine addObject:self.value];
////
////    NSLog(@"touch began, array contains: %@", self.gridReference.tileValuesToCombine);
////    [self.gridReference addTileValues];
//}

@end
