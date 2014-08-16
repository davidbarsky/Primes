//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "Grid.h"

@implementation MainScene {
	Grid *_grid;
}

- (void)play {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

- (void)endGame {
    CCScene *mainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
}

- (void)didLoadFromCCB {
    [_grid addObserver:self forKeyPath:@"goal" options:0 context:NULL];
    _roundGoalLabel.string = [NSString stringWithFormat:@"%ld", (long)_grid.goal];
    
    [_grid addObserver:self forKeyPath:@"movesMadeThisRound" options:0 context:NULL];
    _roundScoreLabel.string = [NSString stringWithFormat:@"%ld", (long)_grid.movesMadeThisRound];
    
//    [_grid addObserver:self forKeyPath:@"liveScoreCount" options:0 context:NULL];
//    _currentScoreLabel.string = [NSString stringWithFormat:@"%ld", (long)_grid.liveScoreCount];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"goal"]) {
        _roundGoalLabel.string = [NSString stringWithFormat:@"%ld", (long)_grid.goal];
    }
    
    if ([keyPath isEqualToString:@"movesMadeThisRound"]) {
        _roundScoreLabel.string = [NSString stringWithFormat:@"%ld", (long)_grid.movesMadeThisRound];
    }
    
//    if ([keyPath isEqualToString:@"currentSum"]) {
//        _currentScoreLabel.string = [NSString stringWithFormat:@"%ld", (long)_grid.liveScoreCount];
//    }
}

- (void)dealloc {
    [_grid removeObserver:self forKeyPath:@"goal"];
    [_grid removeObserver:self forKeyPath:@"movesMadeThisRound"];
//    [_grid removeObserver:self forKeyPath:@"liveScoreCount"];
}

@end
