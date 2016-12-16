//
//  Singleton.h
//  DaveTheWhale
//
//  Created by Jem Tucker on 30/05/2014.
//  Copyright (c) 2014 Chalk on Board. All rights reserved.
//

#import "cocos2d.h"
#import "cocos2d-ui.h"

@interface Singleton : NSObject

+ (Singleton *)singleton;
- (void)setScore: (NSInteger *)score;
- (NSInteger *)score;

@end
