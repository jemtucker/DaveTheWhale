//
//  GameScene.h
//  DaveTheWhale
//
//  Created by Jem Tucker on 27/05/2014.
//  Copyright Chalk on Board 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "cocos2d.h"
#import "cocos2d-ui.h"

// -----------------------------------------------------------------------

/**
 *  The main scene
 */
@interface GameScene : CCScene <CCPhysicsCollisionDelegate>

// -----------------------------------------------------------------------

+ (GameScene *)scene;
- (id)init;

// -----------------------------------------------------------------------
@end