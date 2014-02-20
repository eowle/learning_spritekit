//
//  ERGMyScene.m
//  Endless Runner
//
//  Created by Eric Owle on 2/20/14.
//  Copyright (c) 2014 Growl. All rights reserved.
//

#import "ERGMyScene.h"
#import "ERGBackground.h"
#import "ERGPlayer.h"

@implementation ERGMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        self.currentBackground = [ERGBackground generateNewBackground];
        ERGPlayer *player = [[ERGPlayer alloc] init];
        player.position = CGPointMake(100, 68);
      
        [self addChild:self.currentBackground];
        [self addChild:player];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
}

-(void)update:(CFTimeInterval)currentTime {
  CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;
  self.lastUpdateTimeInterval = currentTime;
  if(timeSinceLast > 1) {
    timeSinceLast = 1.0 / 60.0;
  }
  
  [self enumerateChildNodesWithName:backgroundName usingBlock:^(SKNode *node, BOOL *stop) {
    node.position = CGPointMake(node.position.x - backgroundMoveSpeed * timeSinceLast, node.position.y);
  }];
}

@end
