//
//  ERGPlayer.m
//  Endless Runner
//
//  Created by Eric Owle on 2/20/14.
//  Copyright (c) 2014 Growl. All rights reserved.
//

#import "ERGPlayer.h"

@implementation ERGPlayer
 -(instancetype)init
 {
  self = [super initWithImageNamed:@"character.png"];
  {
    self.name = playerName;
  }
  
  return self;
 }
@end
