//
//  ERGBackground.m
//  Endless Runner
//
//  Created by Eric Owle on 2/20/14.
//  Copyright (c) 2014 Growl. All rights reserved.
//

#import "ERGBackground.h"

@implementation ERGBackground
+ (ERGBackground *)generateNewBackground
{
  ERGBackground *background = [[ERGBackground alloc] initWithImageNamed:@"background.png"];
  background.anchorPoint = CGPointMake(0, 0);
  background.name = backgroundName;
  background.position = CGPointMake(0,0);
  return background;
}
@end
