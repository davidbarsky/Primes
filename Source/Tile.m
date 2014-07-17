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

- (id)init {
    if (self = [super init]) {
        // activates touches
        self.userInteractionEnabled = TRUE;
    }
    return self;
}

-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    NSLog(@"Tile was touched!");
}

@end
