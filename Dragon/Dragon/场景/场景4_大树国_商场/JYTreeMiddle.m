//
//  JYTreeMiddle.m
//  Dragon
//
//  Created by 吴冬 on 16/9/9.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//


@implementation JYTreeMiddle
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
    [self createWalls:14 superSence:_bg];
    
    //怪物
    [self setMonsterWithSuperSence:_bg imageNames:@[@"史莱姆.png",@"蝙蝠.png",@"史莱姆.png"]];
    
    //JJC
    [self setchangeSenceWithSuperNode:_bg key:kSence_treeMiddleJJC];
    
    //bottom
    [self setchangeSenceWithSuperNode:_bg key:kSence_treeBottom];
    
    //JYWell
    [self setchangeSenceWithSuperNode:_bg key:kSence_well];
    
    //JYBookLibrary
    [self setchangeSenceWithSuperNode:_bg key:kSence_bookLibrary];
    
    //JYStore
    [self setchangeSenceWithSuperNode:_bg key:kSence_store];
    
    //JYBigStore
    [self setchangeSenceWithSuperNode:_bg key:kSence_BigStore];
    
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKSpriteNode * A = (SKSpriteNode *)contact.bodyA.node;
    //SKSpriteNode * B = (SKSpriteNode *)contact.bodyB.node;
    
    if ([A.userData objectForKey:kSence_treeBottom])
    {
        
        [self presentSceneWithPosition:CGPointMake(135 + self.player.size.width / 2.0 + 5, self.screenHeight - self.player.size.height ) scenePosition:CGPointMake(0, 0) texture:self.dic_player[@"down"][0] key:kSence_treeBottom tra:nil];
    }
    
    else if([A.userData objectForKey:kSence_treeMiddleJJC])
    {
        
        [self presentSceneWithPosition:CGPointMake(135 + self.player.size.width / 2.0 + 5, self.player.size.height / 2.0 + 5) scenePosition:CGPointMake(0, 0) texture:self.dic_player[@"up"][0] key:kSence_treeMiddleJJC tra:nil];
    }
   
    else if([A.userData objectForKey:kSence_well])
    {
        
        [self presentSceneWithPosition:CGPointMake(300, 700) scenePosition:CGPointMake(0, -375) texture:self.dic_player[@"up"][0] key:kSence_well tra:nil];
    }
    
    else if([A.userData objectForKey:kSence_bookLibrary])
    {
        
        [self presentSceneWithPosition:CGPointMake(365, 30) scenePosition:CGPointMake(0, 0) texture:self.dic_player[@"up"][0] key:kSence_bookLibrary tra:nil];
    }
    
    else if([A.userData objectForKey:kSence_store])
    {
        
        [self presentSceneWithPosition:CGPointMake(365, 30) scenePosition:CGPointMake(0, 0) texture:self.dic_player[@"up"][0] key:kSence_store tra:nil];
    }
    
    else if([A.userData objectForKey:kSence_BigStore])
    {
        
        [self presentSceneWithPosition:CGPointMake(30, 585) scenePosition:CGPointMake(0, 0) texture:self.dic_player[@"right"][0] key:kSence_BigStore tra:nil];
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
    
    if (_bg.position.x < - self.screenWidth || self.player.position.x > self.screenWidth + self.screenWidth - 200) {
        _bg.position = CGPointMake(- self.screenWidth, _bg.position.y);
    }else if(_bg.position.x > 0 || self.player.position.x < self.screenWidth / 2.0){
        _bg.position = CGPointMake(0, _bg.position.y);
    }
    
    
    return YES;
    
}




@end
