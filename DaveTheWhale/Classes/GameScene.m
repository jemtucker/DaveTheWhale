//
//  GameScene.m
//  DaveTheWhale
//
//  Created by Jem Tucker on 27/05/2014.
//  Copyright Chalk on Board 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "GameScene.h"
#import "IntroScene.h"
#import "GameOverScene.h"
#import "Singleton.h"

#pragma mark - GameScene

@implementation GameScene
{
    CCSprite *_scrollingBackground1, *_scrollingBackground2;
    CCSprite *_whale;
    CCPhysicsNode *_physicsWorld;
    CCLabelTTF *_labelscore;
    NSInteger _score, _highScore;
}

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (GameScene *)scene
{
    return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init {
    self = [super init];
    if (!self) return(nil);
    
    self.userInteractionEnabled = YES;
    
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f]];
    [self addChild:background];
    
    _scrollingBackground1 = [CCSprite spriteWithImageNamed:@"background main.png"];
    _scrollingBackground1.anchorPoint = ccp(0, 0);
    _scrollingBackground1.position  = ccp(0,0);
    [self addChild:_scrollingBackground1];
    _scrollingBackground2 = [CCSprite spriteWithImageNamed:@"background main.png"];
    _scrollingBackground2.anchorPoint = ccp(0, 0);
    _scrollingBackground2.position = ccp(_scrollingBackground1.contentSize.width, 0);
    [self addChild:_scrollingBackground2];
    _physicsWorld = [CCPhysicsNode node];
    _physicsWorld.gravity = ccp(0,-10);
    _physicsWorld.debugDraw = NO;
    _physicsWorld.collisionDelegate = self;
    [self addChild:_physicsWorld];
    
    _score = 0;
    _highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"high_score"];
    _labelscore = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", (int)_score] fontName:@"Whale Watching" fontSize:40.0f];
    _labelscore.position = ccp(self.contentSize.width / 2, self.contentSize.height / 8 * 7);
    [self addChild:_labelscore];
    
    
    
    
    
    _whale = [CCSprite spriteWithImageNamed:@"whale.png"];
    _whale.scale = 0.4f;
    _whale.position = ccp(self.contentSize.width / 3, self.contentSize.height / 16*10);
    _whale.physicsBody = [CCPhysicsBody bodyWithCircleOfRadius:_whale.contentSize.height/1.9 andCenter:ccp(_whale.anchorPoint.x + _whale.contentSize.width/8 * 5, _whale.anchorPoint.y + _whale.contentSize.height/2)];
    _whale.physicsBody.collisionGroup = @"whaleGroup";
    _whale.physicsBody.collisionType = @"whaleCollision";
    [_physicsWorld addChild:_whale];
    
    CCButton *backButton = [CCButton buttonWithTitle:@"Return" fontName:@"Whale Watching" fontSize:40.0f];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.85f, 0.95f); // Top Right of screen
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton];

	return self;
}

- (void)scrollBackground:(CCTime)delta {
    _scrollingBackground1.position = ccp( _scrollingBackground1.position.x - 0.7, _scrollingBackground1.position.y );
    _scrollingBackground2.position = ccp( _scrollingBackground2.position.x - 0.7, _scrollingBackground2.position.y );
    
    if ( _scrollingBackground1.position.x < -_scrollingBackground1.contentSize.width) {
        _scrollingBackground1.position = ccp(_scrollingBackground2.position.x + _scrollingBackground2.contentSize.width, _scrollingBackground1.position.y );
    }
    if ( _scrollingBackground2.position.x < -_scrollingBackground2.contentSize.width) {
        _scrollingBackground2.position = ccp(_scrollingBackground1.position.x + _scrollingBackground2.contentSize.width, _scrollingBackground2.position.y );
    }
}

- (void)updateWhale:(CCTime)delta {
    //ceiling and floor
    if (_whale.position.y >= self.contentSize.height - _whale.contentSize.height/8) {
        _whale.position = ccp(_whale.position.x, self.contentSize.height - _whale.contentSize.height/8 - 1);
        _whale.physicsBody.velocity = ccp(0, 0);
    } else if (_whale.position.y <= 150 + _whale.contentSize.height/8) {
        _whale.position = ccp(_whale.position.x, 150 + _whale.contentSize.height/8 + 1);
        _whale.physicsBody.velocity = ccp(0, 0);
    }
    
    //gravity
    if  (_whale.position.y > self.contentSize.height/16*10) {
        [_whale.physicsBody applyForce:ccp(0, -30.f)];
    } else if (_whale.position.y < self.contentSize.height/16*10) {
        [_whale.physicsBody applyForce:ccp(0, 30.f)];
    }
}

- (void)sendMine:(CCTime) delta {
    CCSprite *mine1 = [CCSprite spriteWithImageNamed:@"mine1.png"];
    mine1.scale = 0.5f;
    CCSprite *mine2 = [CCSprite spriteWithImageNamed:@"mine1.png"];
    mine2.scale = 0.5f;
    
    int random = (arc4random() % 3) + 1;
    
    if (random == 1) {
        mine1.position = ccp(self.contentSize.width + mine1.contentSize.width, self.contentSize.height / 16 * 14);
        mine2.position = ccp(self.contentSize.width + mine1.contentSize.width, self.contentSize.height / 16 * 10);
    } else if (random == 2) {
        mine1.position = ccp(self.contentSize.width + mine1.contentSize.width, self.contentSize.height / 16 * 14);
        mine2.position = ccp(self.contentSize.width + mine1.contentSize.width, self.contentSize.height / 16 * 6);
    } else if (random == 3) {
        mine1.position = ccp(self.contentSize.width + mine1.contentSize.width, self.contentSize.height / 16 * 10);
        mine2.position = ccp(self.contentSize.width + mine1.contentSize.width, self.contentSize.height / 16 * 6);
    }
    mine1.physicsBody = [CCPhysicsBody bodyWithCircleOfRadius:mine1.contentSize.width/2.0f andCenter:ccp(mine1.anchorPoint.x + mine1.contentSize.width/2, mine1.anchorPoint.y + mine1.contentSize.height/2)];
    mine1.physicsBody.velocity = ccp(-155, 0);
    mine1.physicsBody.collisionGroup = @"mineGroup";
    mine1.physicsBody.collisionType = @"mineCollision";
    mine1.physicsBody.affectedByGravity = NO;
    mine2.physicsBody = [CCPhysicsBody bodyWithCircleOfRadius:mine2.contentSize.width/2.0f andCenter:ccp(mine2.anchorPoint.x + mine2.contentSize.width/2, mine2.anchorPoint.y + mine2.contentSize.height/2)];
    mine2.physicsBody.velocity = ccp(-155, 0);
    mine2.physicsBody.collisionGroup = @"mineGroup";
    mine2.physicsBody.collisionType = @"mineCollision";
    mine2.physicsBody.affectedByGravity = NO;
    [_physicsWorld addChild:mine1];
    [_physicsWorld addChild:mine2];
    
    CCNode *goal = [CCNode node];
    goal.position = ccp(mine1.position.x, 0);
    goal.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, CGSizeMake(10, self.contentSize.height)} cornerRadius:0];
    goal.physicsBody.sensor = YES;
    goal.physicsBody.affectedByGravity = NO;
    goal.physicsBody.velocity = ccp(-155,0);
    goal.physicsBody.collisionGroup = @"mineGroup";
    goal.physicsBody.collisionType = @"goalCollision";
    [_physicsWorld addChild:goal];
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair mineCollision:(CCNode *)mine whaleCollision:(CCNode *)whale {
    if (_score > _highScore) {
        [[NSUserDefaults standardUserDefaults] setInteger:_score forKey:@"high_score"];
    }
    Singleton *singleton = [Singleton singleton];
    singleton.score = _score;
    [[CCDirector sharedDirector] replaceScene:[GameOverScene scene] withTransition: [CCTransition transitionCrossFadeWithDuration:1.f]];
    return YES;
}

- (BOOL)ccPhysicsCollisionBegin: (CCPhysicsCollisionPair *)pair goalCollision:(CCNode *)goal whaleCollision: (CCNode *)whale {
    [goal removeFromParent];
    _score++;
    _labelscore.string = [NSString stringWithFormat:@"%d",(int) _score];
    return YES;
}

- (float)randomTime {
    int randomN = (arc4random() % 50) + 1;
    float rT = 1.f / randomN;
    return rT;
    
}

// -----------------------------------------------------------------------

- (void)dealloc
{
    // clean up code goes here
}

// -----------------------------------------------------------------------
#pragma mark - Enter & Exit
// -----------------------------------------------------------------------

- (void)onEnter
{
    // always call super onEnter first
    [super onEnter];
    [self schedule:@selector(scrollBackground:) interval:0.005];
    [self schedule:@selector(updateWhale:) interval:0.005];
    [self schedule:@selector(sendMine:) interval: 3.4 + [self randomTime]];
    
    // In pre-v3, touch enable and scheduleUpdate was called here
    // In v3, touch is enabled by setting userInterActionEnabled for the individual nodes
    // Per frame update is automatically enabled, if update is overridden
    
}

// -----------------------------------------------------------------------

- (void)onExit
{
    // always call super onExit last
    [super onExit];
}

// -----------------------------------------------------------------------
#pragma mark - Touch Handler
// -----------------------------------------------------------------------

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLoc = [touch locationInNode:self];
    
    if(touchLoc.y > self.contentSize.height/2) {
        [_whale.physicsBody applyImpulse:ccp(0.0f,70.0f)];
    } else {
        [_whale.physicsBody applyImpulse:ccp(0.0f, -70.0f)];
    }
    
    
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onBackClicked:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionCrossFadeWithDuration:1.0f]];
}

// -----------------------------------------------------------------------
@end
