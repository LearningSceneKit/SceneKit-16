//
//  ViewController.m
//  SceneKit-16场景切换
//
//  Created by ShiWen on 2017/7/24.
//  Copyright © 2017年 ShiWen. All rights reserved.
//

#import "ViewController.h"

#import <SceneKit/SceneKit.h>

#import <SpriteKit/SpriteKit.h>


@interface ViewController ()
@property (nonatomic,strong)SCNView *mScnView;
@property (nonatomic,strong)SCNScene *firstScene,*secScene;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mScnView];
//    创建相机
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = [SCNCamera camera];
    cameraNode.position = SCNVector3Make(0, 0, 30);
    cameraNode.camera.automaticallyAdjustsZRange = YES;
    [self.firstScene.rootNode addChildNode:cameraNode];
    
//    创建地板
    SCNNode *floorNode = [SCNNode nodeWithGeometry:[SCNFloor floor]];
    floorNode.physicsBody = [SCNPhysicsBody staticBody];
    floorNode.position = SCNVector3Make(0, -10, 0);
    floorNode.geometry.firstMaterial.diffuse.contents = @"floor.jpg";
    [self.mScnView.scene.rootNode addChildNode:floorNode];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//   转换场景时使用的方式
    SKTransition *transition = [SKTransition doorsOpenHorizontalWithDuration:1];
//    SKTransition *transition = [SKTransition doorwayWithDuration:1];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.mScnView];
    if (((int)point.x)%2 == 0) {
//        转换
        [self.mScnView presentScene:self.secScene withTransition:transition incomingPointOfView:nil completionHandler:nil];
        return;
    }
    [self.mScnView presentScene:self.firstScene withTransition:transition incomingPointOfView:nil completionHandler:nil];
    
}

-(SCNScene *)firstScene{
    if (!_firstScene) {
        _firstScene = [SCNScene scene];

    }
    return _firstScene;
}

-(SCNScene *)secScene{
    if (!_secScene) {
        _secScene = [SCNScene sceneNamed:@"hero.dae"];
        
    }
    return _secScene;
}
-(SCNView*)mScnView{
    if (!_mScnView) {
        _mScnView = [[SCNView alloc] initWithFrame:self.view.bounds];
        _mScnView.backgroundColor = [UIColor blackColor];
        _mScnView.scene = self.firstScene;
//        _mScnView.allowsCameraControl = YES;
    }
    return _mScnView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
