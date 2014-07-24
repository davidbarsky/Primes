//
//  GameEnd.m
//  Primes
//
//  Created by David Barsky on 7/24/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameEnd.h"

@implementation GameEnd {
    CCLabelTTF *_finalScoreLabel;
}

- (void)newGame {
    CCScene *mainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
}

- (void)setFinalScore:(NSInteger)score {
    _finalScoreLabel.string = [NSString stringWithFormat:@"%ld", (long)score];
}

@end
