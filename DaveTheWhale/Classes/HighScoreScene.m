//
//  HighScoreScene.m
//  DaveTheWhale
//
//  Created by Jem Tucker on 29/05/2014.
//  Copyright (c) 2014 Chalk on Board. All rights reserved.
//

#import "HighScoreScene.h"
#import "IntroScene.h"

@implementation HighScoreScene
{
    NSInteger *_score;
}

+ (HighScoreScene *)scene
{
	return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (!self) return(nil);
    
    _score = [[NSUserDefaults standardUserDefaults] integerForKey:@"high_score"];
    if (_score == nil) {
        _score = 0;
    }
    
    CCSprite *background = [CCSprite spriteWithImageNamed:@"background.png"];
    background.anchorPoint = ccp(0, 0);
    background.position = ccp(0,0);
    [self addChild:background];
    
    CCLabelTTF *labelScore = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%ld", (long)_score] fontName:@"Whale Watching" fontSize:100.f];
    labelScore.color = [CCColor whiteColor];
    labelScore.position = ccp(self.contentSize.width/2, self.contentSize.height/16 * 11);
    [self addChild:labelScore];
    
    CCButton *scoreButton = [CCButton buttonWithTitle:@"Menu" fontName:@"Whale Watching" fontSize:50.0f];
    scoreButton.position = ccp(self.contentSize.width/2, self.contentSize.height / 16 * 5);
    [scoreButton setTarget:self selector:@selector(onReturnClicked:)];
    [self addChild:scoreButton];
    
	return self;
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onReturnClicked:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene] withTransition: [CCTransition transitionCrossFadeWithDuration:1.f]];
}
@end
