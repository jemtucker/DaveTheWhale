//
//  InfoScene.m
//  DaveTheWhale
//
//  Created by Charlie on 6/3/14.
//  Copyright (c) 2014 Chalk on Board. All rights reserved.
//

#import "InfoScene.h"
#import "IntroScene.h"

@implementation InfoScene

+ (InfoScene *)scene
{
	return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    CCSprite *background = [CCSprite spriteWithImageNamed:@"backgroundinfo.png"];
    background.anchorPoint = ccp(0, 0);
    background.position = ccp(0,0);
    [self addChild:background];
    
    CCLabelTTF *line1 = [CCLabelTTF labelWithString:@"Tap The Top Half" fontName:@"Whale Watching" fontSize:50.f];
    line1.position = ccp(self.contentSize.width/2, self.contentSize.height /16 * 14);
    
    CCLabelTTF *line2 = [CCLabelTTF labelWithString:@"To Go Up" fontName:@"Whale Watching" fontSize:50.f];
    line2.position = ccp(self.contentSize.width/2, self.contentSize.height /16 * 12);
    
    CCLabelTTF *line3 = [CCLabelTTF labelWithString:@"And The Bottom Half" fontName:@"Whale Watching" fontSize:50.f];
    line3.position = ccp(self.contentSize.width/2, self.contentSize.height /16 * 10);
    
    CCLabelTTF *line4 = [CCLabelTTF labelWithString:@"To Go Down" fontName:@"Whale Watching" fontSize:50.f];
    line4.position = ccp(self.contentSize.width/2, self.contentSize.height /16 * 8);
    
    CCLabelTTF *line5 = [CCLabelTTF labelWithString:@"DON'T HIT THE MINES" fontName:@"Whale Watching" fontSize:50.f];
    line5.position = ccp(self.contentSize.width/2, self.contentSize.height /16 * 6);
    
    [self addChild:line1];
    [self addChild:line2];
    [self addChild:line3];
    [self addChild:line4];
    [self addChild:line5];

    
    CCButton *menuButton = [CCButton buttonWithTitle:@"Menu" fontName:@"Whale Watching" fontSize:50.0f];
    menuButton.position = ccp(self.contentSize.width/2, self.contentSize.height/ 16 * 3);
    [menuButton setTarget:self selector:@selector(onMenuClicked:)];
    [self addChild:menuButton];
    
    
	return self;
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onMenuClicked:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionCrossFadeWithDuration:1.0f]];
}


// -----------------------------------------------------------------------

@end
