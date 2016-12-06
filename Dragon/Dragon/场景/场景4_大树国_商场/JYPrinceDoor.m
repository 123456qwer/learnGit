//
//  JYPrinceDoor.m
//  Dragon
//
//  Created by 吴冬 on 16/12/5.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//


@implementation JYPrinceDoor
{
    SKSpriteNode *_bg;
}

- (void)didMoveToView:(SKView *)view
{
    if ([self initWithCreateKey]) {
        [self _createNodes];
    }
    
    [self changePlayerPosition];
}

- (void)_createNodes
{
    self.physicsWorld.contactDelegate = self;
    
    [self setFrame];
    
    if ([kDeviceVersion floatValue] < 8.0) {
        
    }else{
        _bg = (SKSpriteNode *)[self childNodeWithName:@"bg"];
    }
    
    //设置主角
    [self setPlayerType:@"left"];
    [_bg addChild:self.player];
    
    //墙
    [self createWalls:8 superSence:_bg];
    
    //怪物
    [self setMonsterWithSuperSence:_bg imageNames:@[@"史莱姆.png",@"蝙蝠.png",@"史莱姆.png"]];
    
    //JJC_left2
    [self setchangeSenceWithSuperNode:_bg key:kSence_JJC_left2];
    
    
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKSpriteNode * A = (SKSpriteNode *)contact.bodyA.node;
    //SKSpriteNode * B = (SKSpriteNode *)contact.bodyB.node;
    
    if ([A.userData objectForKey:kSence_JJC_left2]) {
        
        [self presentSceneWithPosition:CGPointMake(235,230) scenePosition:CGPointMake(0, 0) texture:self.dic_player[@"down"][0] key:kSence_JJC_left2 tra:nil];
    }
    
   
}

@end
