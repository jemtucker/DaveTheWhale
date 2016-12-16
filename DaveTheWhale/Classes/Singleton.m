//
//  Singleton.m
//  DaveTheWhale
//
//  Created by Jem Tucker on 30/05/2014.
//  Copyright (c) 2014 Chalk on Board. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton

+ (Singleton *)singleton {
    static Singleton *singleton;
    
    @synchronized(self) {
        if(!singleton)
            singleton = [[Singleton alloc]init];
        return singleton;
    }
}

NSInteger *score;

- (NSInteger *)score {
    if(!score)
        score = 0;
    return score;
}

- (void)setScore: (NSInteger *)gameScore {
    score = gameScore;
}

@end
