//
//  GameOverScene.m
//  DaveTheWhale
//
//  Created by Jem Tucker on 29/05/2014.
//  Copyright (c) 2014 Chalk on Board. All rights reserved.
//

#import "GameOverScene.h"
#import "IntroScene.h"
#import "GameScene.h"
#import "Singleton.h"

@implementation GameOverScene
{
    NSInteger _score;
    Singleton *_singleton;
}

+ (GameOverScene *)scene
{
	return [[self alloc] init];
}

- (id)init
{
    self = [super init];
    if (!self) return(nil);
    
    
    _singleton = [Singleton singleton];
    _score = _singleton.score;
    
    CCSprite *background = [CCSprite spriteWithImageNamed:@"background.png"];
    background.anchorPoint = ccp(0, 0);
    background.position = ccp(0,0);
    [self addChild:background];
    
    CCLabelTTF *label1 = [CCLabelTTF labelWithString:@"Game Over" fontName:@"undergramo" fontSize:20.0f];
    label1.color = [CCColor whiteColor];
    label1.position = ccp(self.contentSize.width/2, self.contentSize.height/16 * 14);
    [self addChild:label1];
    
    if (!_score) {
        _score = 0;
    }
    
    CCLabelTTF *labelScore = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", (int)_score] fontName:@"Whale Watching" fontSize:100.f];
    labelScore.color = [CCColor whiteColor];
    labelScore.position = ccp(self.contentSize.width/2, self.contentSize.height/16 * 10);
    [self addChild:labelScore];
    
    CCButton *playButton = [CCButton buttonWithTitle:@"Play Again" fontName:@"Whale Watching" fontSize:50.0f];
    playButton.position = ccp(self.contentSize.width/2, self.contentSize.height/ 16 * 7);
    [playButton setTarget:self selector:@selector(onPlayClicked:)];
    [self addChild:playButton];
    
    CCButton *scoreButton = [CCButton buttonWithTitle:@"Menu" fontName:@"Whale Watching" fontSize:50.0f];
    scoreButton.position = ccp(self.contentSize.width/2, self.contentSize.height / 16 * 5);
    [scoreButton setTarget:self selector:@selector(onReturnClicked:)];
    [self addChild:scoreButton];
    
	return self;
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onPlayClicked:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[GameScene scene]
                               withTransition:[CCTransition transitionCrossFadeWithDuration:1.0f]];
}

- (void)onReturnClicked:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene] withTransition: [CCTransition transitionCrossFadeWithDuration:1.f]];
}

// -----------------------------------------------------------------------
@end
