//
//  JYBookLibrary.m
//  Dragon
//
//  Created by 吴冬 on 16/12/6.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//


@implementation JYBookLibrary

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
    [self createWalls:10 superSence:_bg];
    
    //怪物
    [self setMonsterWithSuperSence:_bg imageNames:@[@"史莱姆.png",@"蝙蝠.png",@"史莱姆.png"]];
    
    //middle
    [self setchangeSenceWithSuperNode:_bg key:kSence_treeMiddle];
    
#warning 这里增加书的碰撞检测
    
}

- (BOOL)moveActionWithkey:(NSString *)key
                        x:(CGFloat )x
                        y:(CGFloat )y
{
    
    
    BOOL isCut = [super moveActionWithkey:key x:x y:y];
    
    CGFloat spriteX = 0;
    CGFloat spriteY = 0;
    
    spriteX = self.player.position.x ;
    spriteY = self.player.position.y ;
    

    if (!isCut) {
        
        if (spriteY > kScreenHeight / 4.0 && spriteY < kScreenHeight + kScreenHeight / 2.0) {
            _bg.position = CGPointMake(0, _bg.position.y - y);
        }
        
        NSLog(@"%lf,%lf",kScreenHeight,kScreenWidth);
        NSLog(@"1:%lf,1:%lf",self.screenHeight,self.screenWidth);
        //边界
        if (_bg.position.y <= -self.screenHeight ) {
            _bg.position = CGPointMake(0, -self.screenHeight);
        }else if(_bg.position.y >= 0){
            _bg.position = CGPointMake(0, 0);
        }
    }
    
    
    
    return NO;
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKSpriteNode * A = (SKSpriteNode *)contact.bodyA.node;
    //SKSpriteNode * B = (SKSpriteNode *)contact.bodyB.node;
    
    if ([A.userData objectForKey:kSence_treeMiddle]) {
        
        [self presentSceneWithPosition:CGPointMake(365,165) scenePosition:CGPointMake(0, 0) texture:self.dic_player[@"down"][0] key:kSence_treeMiddle tra:nil];
    }
    
   
}


@end
