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
      
        self.score = 0;
        self.scoreLabel = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
        self.scoreLabel.fontSize = 15;
        self.scoreLabel.color = [UIColor whiteColor];
        self.scoreLabel.position = CGPointMake(20, 300);
        self.scoreLabel.zPosition = 100;
      
        [self addChild:self.scoreLabel];
      
        SKAction *tempAction = [SKAction runBlock:^{
          self.scoreLabel.text = [NSString stringWithFormat:@"%3.2f", self.score];
        }];
      
        SKAction *waitAction = [SKAction waitForDuration:0.2];
        [self.scoreLabel runAction:[SKAction repeatActionForever:[SKAction sequence:@[tempAction, waitAction]]]];
      
        [self addChild:self.currentBackground];
        [self addChild:player];
    }
    
    return self;
}


-(void)handleSwipeRight:(UIGestureRecognizer *)recognizer {
  if(recognizer.state == UIGestureRecognizerStateRecognized) {
    backgroundMoveSpeed += 50;
  }
}

-(void)handleSwipeLeft:(UIGestureRecognizer *)recognizer {
  if(recognizer.state == UIGestureRecognizerStateRecognized) {
    backgroundMoveSpeed -= 50;
  }
}

-(void)didMoveToView:(SKView *)view {
  UISwipeGestureRecognizer *swiper = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight:)];
  swiper.direction = UISwipeGestureRecognizerDirectionRight;
  [view addGestureRecognizer:swiper];
  
  UISwipeGestureRecognizer *swiperTwo = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeft:)];
  swiperTwo.direction = UISwipeGestureRecognizerDirectionLeft;
  [view addGestureRecognizer:swiperTwo];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *touch = [touches anyObject];
  SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:[touch locationInNode:self]];
  
  if(touchedNode.name == playerName){
    ERGPlayer *player = (ERGPlayer *) touchedNode;
    player.selected = YES;
    return;
  }

  SKAction *moveUp = [SKAction moveBy:CGVectorMake(0, 100) duration:0.8];
  SKAction *moveDown = [SKAction moveBy:CGVectorMake(0, -100) duration:0.6];
  SKAction *seq = [SKAction sequence:@[moveUp, moveDown]];
  ERGPlayer *player = (ERGPlayer *)[self childNodeWithName:playerName];
  [player runAction:seq];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *touch = [touches anyObject];
  
  ERGPlayer *player = (ERGPlayer *)[self childNodeWithName:playerName];
  if(player.selected) {
    player.position = [touch locationInNode:self];
  }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  ERGPlayer *player = (ERGPlayer *)[self childNodeWithName:playerName];
  
  if(player.selected) {
    player.selected = NO;
  }
}

-(void)update:(CFTimeInterval)currentTime {
  CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;
  self.lastUpdateTimeInterval = currentTime;
  if(timeSinceLast > 1) {
    timeSinceLast = 1.0 / 60.0;
  }
  
  [self enumerateChildNodesWithName:backgroundName usingBlock:^(SKNode *node, BOOL *stop) {
    node.position = CGPointMake(node.position.x - backgroundMoveSpeed * timeSinceLast, node.position.y);
    
    if(node.position.x < - (node.frame.size.width + 100)) {
      [node removeFromParent];
    }
    
    if(self.currentBackground.position.x < -500) {
      ERGBackground *temp = [ERGBackground generateNewBackground];
      temp.position = CGPointMake(self.currentBackground.position.x + self.currentBackground.frame.size.width, 0);
      [self addChild:temp];
      self.currentBackground = temp;
    }
  }];
  
  self.score += backgroundMoveSpeed * timeSinceLast / 100;
}

@end
