//
//  JYBigStore.m
//  Dragon
//
//  Created by 吴冬 on 16/12/6.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//

@implementation JYBigStore
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
    [self createWalls:33 superSence:_bg];
    
    //怪物
    [self setMonsterWithSuperSence:_bg imageNames:@[@"史莱姆.png",@"蝙蝠.png",@"史莱姆.png"]];
    
    //JJC_left2
    [self setchangeSenceWithSuperNode:_bg key:kSence_treeMiddle];
    
    
}

- (BOOL)moveActionWithkey:(NSString *)key x:(CGFloat)x y:(CGFloat)y
{
    BOOL isCut = [super moveActionWithkey:key x:x y:y];
    
    if (isCut) {
        return NO;
    }
    
    NSLog(@"%lf",self.player.position.y);

    NSLog(@"bg : %lf",_bg.position.y);
    
    _bg.position = CGPointMake(_bg.position.x - x, _bg.position.y - y);
    
    if (_bg.position.x < - 2 * self.screenWidth || self.player.position.x > kScreenWidth * 3 - 300) {
        _bg.position = CGPointMake(-2 * self.screenWidth, _bg.position.y);
    }else if(_bg.position.x > 0 || self.player.position.x < 300){
        _bg.position = CGPointMake(0, _bg.position.y);
    }
    
    if (_bg.position.y < -kScreenHeight || self.player.position.y > kScreenHeight * 2 - kScreenHeight / 2.0) {
        _bg.position = CGPointMake(_bg.position.x, -kScreenHeight);
    }else if(_bg.position.y > 0 || self.player.position.y < kScreenHeight / 2.0 -100){
        
        _bg.position = CGPointMake(_bg.position.x, 0);
    }
    
    return YES;
    
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKSpriteNode * A = (SKSpriteNode *)contact.bodyA.node;
    //SKSpriteNode * B = (SKSpriteNode *)contact.bodyB.node;
    NSLog(@"%lf",kScreenWidth * 3 - 60);
    if ([A.userData objectForKey:kSence_treeMiddle]) {
        
        [self presentSceneWithPosition:CGPointMake(kScreenWidth * 2 - 34,210) scenePosition:CGPointMake(0, 0) texture:self.dic_player[@"left"][0] key:kSence_treeMiddle tra:nil];
    }
  
}

@end
