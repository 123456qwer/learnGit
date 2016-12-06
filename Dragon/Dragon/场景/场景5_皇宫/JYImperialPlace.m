//
//  TEXT.m
//  Dragon
//
//  Created by 吴冬 on 16/9/13.
//  Copyright © 2016年 北京金源互动科技有限公司. All rights reserved.
//


static NSString *key_imperial2 = @"key_imperial1";
static NSString *key_imperial1 = @"key_imperial1";

@implementation JYImperialPlace
{
    SKSpriteNode *_imperialBG;
    int       _changePlayerY;
}



- (void)_setBg:(UIImage *)bgImage
{
    SKTexture *t = [SKTexture textureWithImage:bgImage];
    
    _imperialBG = [SKSpriteNode spriteNodeWithTexture:t];
//    _imperialBG.xScale = 2.0;
//    _imperialBG.yScale = 2.0;
    _imperialBG.position = CGPointMake(0, 0);
    _imperialBG.anchorPoint = CGPointMake(0, 0);
    _imperialBG.zPosition = kZposition_player - 5;
    
    [self addChild:_imperialBG];
}

- (void)didMoveToView:(SKView *)view
{
    
    if ([self initWithCreateKey]) {
        
        [self _createNodes];
    }
    
    [self changePlayerPosition];
    
    
    _imperialBG.position = self.scenePoint;
    
}

- (void)_createNodes
{
    self.physicsWorld.contactDelegate = self;
    
    [self setFrame];
    
    if ([kDeviceVersion floatValue] < 8.0) {
        [self _setBg:[UIImage imageNamed:@"拼接皇宫"]];
    }else{
        _imperialBG = (SKSpriteNode *)[self childNodeWithName:@"_imperialBG"];
    }
    
    //设置主角
    [self setPlayerType:@"left"];
    [_imperialBG addChild:self.player];
    
    //pastureland
    [self setchangeSenceWithSuperNode:_imperialBG key:kSence_monsterPastureland];
    
    //Collection
    [self setchangeSenceWithSuperNode:_imperialBG key:kSence_imperialCollection];
    
    //prison
    [self setchangeSenceWithSuperNode:_imperialBG key:kSence_prison1];
    
    //TreeTop
    [self setchangeSenceWithSuperNode:_imperialBG key:kSence_treeTop];
    
    
      [self setMonsterWithSuperSence:_imperialBG imageNames:@[@"史莱姆.png",@"蝙蝠.png",@"史莱姆.png"]];
}


//重写move方法
- (BOOL)moveActionWithkey:(NSString *)key
                        x:(CGFloat )x
                        y:(CGFloat )y
{
    
   BOOL isCut = [super moveActionWithkey:key x:x y:y];
    
    CGFloat spriteX = 0;
    CGFloat spriteY = 0;
    
    spriteX = self.player.position.x ;
    spriteY = self.player.position.y ;

//    self.player.position = CGPointMake(spriteX, spriteY);
//    [self changePlayerPic:key];
    
    
    
    if (!isCut) {
       
        if (spriteY > kScreenHeight / 4.0 && spriteY < kScreenHeight + kScreenHeight / 2.0) {
            _imperialBG.position = CGPointMake(0, _imperialBG.position.y - y);
        }
        
        NSLog(@"%lf,%lf",kScreenHeight,kScreenWidth);
        NSLog(@"1:%lf,1:%lf",self.screenHeight,self.screenWidth);
        //边界
        if (_imperialBG.position.y <= -self.screenHeight ) {
            _imperialBG.position = CGPointMake(0, -self.screenHeight);
        }else if(_imperialBG.position.y >= 0){
            _imperialBG.position = CGPointMake(0, 0);
        }
    }

       
 
    return NO;
}

#pragma mark 触碰
- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKSpriteNode * A = (SKSpriteNode *)contact.bodyA.node;
    //SKSpriteNode * B = (SKSpriteNode *)contact.bodyB.node;
    
    if ([A.userData objectForKey:kSence_treeTop])
    {
        
        [self presentSceneWithPosition:CGPointMake(325, 130) scenePosition:CGPointMake(0, 0) texture:self.dic_player[@"down"][0]  key:kSence_treeTop tra:nil];
    }
    
    else if([A.userData objectForKey:kSence_imperialCollection])
    {
        
        [self presentSceneWithPosition:CGPointMake(self.player.size.width / 2.0 + 10, 245) scenePosition:CGPointMake(0, 0) texture:self.dic_player[@"right"][0] key:kSence_imperialCollection tra:nil];
    }
   
    else if([A.userData objectForKey:kSence_monsterPastureland])
    {
        
        [self presentSceneWithPosition:CGPointMake(self.screenWidth + 440,120)scenePosition:CGPointMake(0, 0)  texture:self.dic_player[@"left"][0] key:kSence_monsterPastureland tra:nil];
    }
    
    else if([A.userData objectForKey:kSence_prison1])
    {
        
        [self presentSceneWithPosition:CGPointMake(230,120)scenePosition:CGPointMake(0, 0)  texture:self.dic_player[@"right"][0] key:kSence_prison1 tra:nil];
    }
 
}

@end
