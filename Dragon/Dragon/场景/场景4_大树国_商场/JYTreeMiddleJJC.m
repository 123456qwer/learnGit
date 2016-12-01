//
//  JYTreeMiddleJJC.m
//  Dragon
//
//  Created by 吴冬 on 16/9/12.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//


@implementation JYTreeMiddleJJC
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
    [self _setBg:[UIImage imageNamed:@"大树中部_竞技场.png"]];
    
  
    
    if ([kDeviceVersion floatValue] < 8.0) {
        
    }else{
        _bg = (SKSpriteNode *)[self childNodeWithName:@"bg"];
    }
    //设置主角
    [self setPlayerType:@"left"];
    [_bg addChild:self.player];
    
    //墙壁
    [self createWalls:12 superSence:_bg];
    
    //大树国中部node
    [self setchangeSenceWithSuperNode:_bg key:kSence_treeMiddle];
    
    //大树国顶部node
    [self setchangeSenceWithSuperNode:_bg key:kSence_treeTop];
    
    //JJC里边
    [self setchangeSenceWithSuperNode:_bg key:kSence_JJC];
    
    //怪物
    [self setMonsterWithSuperSence:_bg imageNames:@[@"史莱姆.png",@"蝙蝠.png",@"史莱姆.png"]];
}



#pragma mark 碰撞检测
- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKSpriteNode * A = (SKSpriteNode *)contact.bodyA.node;
    //SKSpriteNode * B = (SKSpriteNode *)contact.bodyB.node;
    
    if ([A.userData objectForKey:kSence_treeMiddle]) {
        
        [self presentSceneWithPosition:CGPointMake(135 + self.player.size.width / 2.0 + 5,self.screenHeight - self.player.size.height / 2.0 - 5) scenePosition:CGPointMake(0, 0) texture:self.dic_player[@"down"][0] key:kSence_treeMiddle tra:nil];
    }
    
    else if([A.userData objectForKey:kSence_treeTop]){
    
        [self presentSceneWithPosition:CGPointMake(135 + self.player.size.width / 2.0 + 5,self.player.size.height / 2.0 + 5) scenePosition:CGPointMake(0, 0) texture:self.dic_player[@"up"][0] key:kSence_treeTop tra:nil];
        
    }
    
    else if([A.userData objectForKey:kSence_JJC]){
    
        [self presentSceneWithPosition:CGPointMake(1000, 30) scenePosition:CGPointMake(-667, 0) texture:self.dic_player[@"up"][0] key:kSence_JJC tra:nil];
        
    }
}


- (BOOL)moveActionWithkey:(NSString *)key x:(CGFloat)x y:(CGFloat)y
{
    BOOL isCut = [super moveActionWithkey:key x:x y:y];
    
    if (isCut) {
        return NO;
    }
    
    // NSLog(@"%lf",self.player.position.x);
    
    _bg.position = CGPointMake(_bg.position.x - x, _bg.position.y);
    
    if (_bg.position.x < - self.screenWidth || self.player.position.x > self.screenWidth + self.screenWidth / 2.0) {
        _bg.position = CGPointMake(- self.screenWidth, _bg.position.y);
    }else if(_bg.position.x > 0 || self.player.position.x < self.screenWidth / 2.0){
        _bg.position = CGPointMake(0, _bg.position.y);
    }
    
  
    return YES;
    
}

@end
