//
//  MainScene.h
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface MainScene : CCNode

@property (nonatomic, strong) CCLabelTTF *roundScoreLabel;
@property (nonatomic, strong) CCLabelTTF *roundGoalLabel;
@property (nonatomic, strong) CCLabelTTF *currentScoreLabel;

@property (nonatomic, strong) CCLabelTTF *movesLabel;
@property (nonatomic, strong) CCLabelTTF *goalsLabel;

@end
