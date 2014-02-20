//
//  ERGMyScene.h
//  Endless Runner
//

//  Copyright (c) 2014 Growl. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class ERGBackground;

@interface ERGMyScene : SKScene
  @property (strong, nonatomic) SKLabelNode *countLabel;
  @property (strong, nonatomic) ERGBackground *currentBackground;
  @property (assign) CFTimeInterval lastUpdateTimeInterval;
@end
