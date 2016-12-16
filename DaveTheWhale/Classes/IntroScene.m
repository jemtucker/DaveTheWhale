//
//  IntroScene.m
//  DaveTheWhale
//
//  Created by Jem Tucker on 27/05/2014.
//  Copyright Chalk on Board 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Import the interfaces
#import "IntroScene.h"
#import "GameScene.h"
#import "HighScoreScene.h"
#import "InfoScene.h"

// -----------------------------------------------------------------------
#pragma mark - IntroScene
// -----------------------------------------------------------------------

@implementation IntroScene

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (IntroScene *)scene
{
	return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    [audio playBg:@"background-music-aac.caf" loop:TRUE];
    
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    CCSprite *background = [CCSprite spriteWithImageNamed:@"background.png"];
    background.anchorPoint = ccp(0, 0);
    background.position = ccp(0,0);
    [self addChild:background];
    
    CCLabelTTF *label1 = [CCLabelTTF labelWithString:@"DAVE" fontName:@"undergramo" fontSize:20.0f];
    label1.color = [CCColor whiteColor];
    label1.position = ccp(self.contentSize.width/2, self.contentSize.height/16 * 14);
    CCLabelTTF *label2 = [CCLabelTTF labelWithString:@"THE" fontName:@"undergramo" fontSize:20.0f];
    label2.color = [CCColor whiteColor];
    label2.position = ccp(self.contentSize.width/2, self.contentSize.height/16 * 13);
    CCLabelTTF *label3 = [CCLabelTTF labelWithString:@"WHALE" fontName:@"undergramo" fontSize:20.0f];
    label3.color = [CCColor whiteColor];
    label3.position = ccp(self.contentSize.width/2, self.contentSize.height/16 * 12);
    [self addChild:label1];
    [self addChild:label2];
    [self addChild:label3];
    
    CCButton *playButton = [CCButton buttonWithTitle:@"Play" fontName:@"Whale Watching" fontSize:50.0f];
    playButton.position = ccp(self.contentSize.width/2, self.contentSize.height/ 16 * 9);
    [playButton setTarget:self selector:@selector(onPlayClicked:)];
    [self addChild:playButton];
    
    CCButton *scoreButton = [CCButton buttonWithTitle:@"High Score" fontName:@"Whale Watching" fontSize:50.0f];
    scoreButton.position = ccp(self.contentSize.width/2, self.contentSize.height / 16 * 7);
    [scoreButton setTarget:self selector:@selector(onHighScoreClicked:)];
    [self addChild:scoreButton];
    
    CCButton *infoButton = [CCButton buttonWithTitle:@"Instructions" fontName:@"Whale Watching" fontSize:50.f];
    infoButton.position = ccp(self.contentSize.width/2, self.contentSize.height/ 16 * 5);
    [infoButton setTarget:self selector:@selector(onInfoClicked:)];
    [self addChild:infoButton];
    
    
	return self;
    
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onPlayClicked:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[GameScene scene]
                               withTransition:[CCTransition transitionCrossFadeWithDuration:1.0f]];
}

- (void)onHighScoreClicked:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[HighScoreScene scene] withTransition:[CCTransition transitionCrossFadeWithDuration:1.0f]];
    
}

- (void)onInfoClicked:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[InfoScene scene] withTransition:[CCTransition transitionCrossFadeWithDuration:1.0f]];
}

// -----------------------------------------------------------------------
@end
