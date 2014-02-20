//
//  ERGMyScene.m
//  Endless Runner
//
//  Created by Eric Owle on 2/20/14.
//  Copyright (c) 2014 Growl. All rights reserved.
//

#import "ERGMyScene.h"

@implementation ERGMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        countLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        countLabel.text = @"0";
        countLabel.fontSize = 30;
        countLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        
        [self addChild:countLabel];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
  
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if(fabsf(location.x - countLabel.position.x) < 15.0 &&
           fabsf(location.y - countLabel.position.y) < 15.0)
        {
          int count = [countLabel.text intValue];
          count++;
          countLabel.text = [NSString stringWithFormat:@"%d", count];
          countLabel.position = CGPointMake((float)rand() / RAND_MAX * CGRectGetMaxX(self.frame), CGRectGetMaxY(self.frame));
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
  countLabel.position = CGPointMake(countLabel.position.x, countLabel.position.y - 2);
  
  if(countLabel.position.y < - countLabel.frame.size.height)
  {
    countLabel.position = CGPointMake(countLabel.position.x, self.frame.size.height);
  }
}

@end
