//
//  JJC_right.m
//  Dragon
//
//  Created by 吴冬 on 16/12/1.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//


@implementation JJC_right
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
    [self createWalls:34 superSence:_bg];
    
    //JJC
    [self setchangeSenceWithSuperNode:_bg key:kSence_JJC];

    //怪物
    [self setMonsterWithSuperSence:_bg imageNames:@[@"史莱姆.png",@"蝙蝠.png",@"史莱姆.png"]];

}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
 
    SKSpriteNode * A = (SKSpriteNode *)contact.bodyA.node;
    //    SKSpriteNode * B = (SKSpriteNode *)contact.bodyB.node;
    
    if ([A.userData objectForKey:kSence_JJC])
    {
        
        [self presentSceneWithPosition:CGPointMake(1700, 1000) scenePosition:CGPointMake(0, 0) texture:self.dic_player[@"down"][0] key:kSence_JJC tra:nil];
    }
    
    else if([A.userData objectForKey:kSence_JJC_left]){
        
      
        
    }
}

@end
