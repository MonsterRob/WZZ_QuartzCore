//
//  WZZ_EmitterAnimation.m
//  WZZ_QuartzCore
//
//  Created by 王召洲 on 16/8/10.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "WZZ_EmitterAnimation.h"

@interface WZZ_EmitterAnimation ()

@end

@implementation WZZ_EmitterAnimation

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imgV.image = [UIImage imageNamed:@"snow_back.jpg"];
    [self.view addSubview:imgV];

    // 创建发射源
    CAEmitterLayer *snowEmitter = [CAEmitterLayer layer];
    // 指定发射源的大小
    snowEmitter.emitterSize = CGSizeMake(self.view.bounds.size.width, 2);
    // 指定发射源位置
    snowEmitter.position =CGPointMake(self.view.center.x, -20);
    //指定发射源发射模式
    snowEmitter.emitterMode = kCAEmitterLayerSurface;
    //指定发射源形状
    snowEmitter.emitterShape = kCAEmitterLayerRectangle;
    snowEmitter.renderMode = kCAEmitterLayerAdditive;
    
    // 控制cell阴影
    snowEmitter.shadowOffset = CGSizeMake(0, 7);
    snowEmitter.shadowRadius = 4;
    snowEmitter.shadowColor = [UIColor grayColor].CGColor;
    snowEmitter.shadowOpacity = 1;
    

    // 创建发射粒子
    CAEmitterCell *snow = [CAEmitterCell emitterCell];
   // 粒子产生速率
    snow.birthRate = 3;
     // 粒子的平均生命周期
    snow.lifetime = 25;
    // 粒子生命周期范围
    snow.lifetimeRange =5; // 实际生命周期在 2~8秒之间
    
    // 控制发射方向与范围
    snow.emissionLongitude =M_PI_2;// 发射方向
    snow.emissionRange = M_PI_2*0.5;// 发射范围
    snow.velocity = 10;// 平均速度
    snow.velocityRange = 3;// 速度范围
    snow.yAcceleration = 3;//y轴加速度
    
   
    // 控制颜色
    snow.color = [UIColor colorWithRed:1 green:1 blue:1 alpha:1].CGColor;
//    snow.redRange = 0.3;
//    snow.blueRange = 0.2;
//    snow.greenRange = 0.2;
//    snow.alphaRange = 0.3;
//    
//    snow.redSpeed = 0.1;
//    snow.greenSpeed = -0.2;
//    snow.blueSpeed = -0.2;
    snow.alphaSpeed = -0.01;
    
    // 控制旋转
    snow.spin = 0;
    snow.spinRange = M_PI_2;
    
    
    // 控制缩放
    snowEmitter.scale = 0.3;
    snow.scaleRange = 0.2;
    snow.scaleSpeed = 0.05;
    
    snow.contents = (__bridge id _Nullable)[UIImage imageNamed:@"snow"].CGImage;
    
    snowEmitter.emitterCells = @[snow];
    
    
    
    
    
    [self.view.layer addSublayer:snowEmitter];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated {
    //self.view.backgroundColor = [UIColor blackColor];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
