//
//  WZZ_Firework.m
//  WZZ_QuartzCore
//
//  Created by 王召洲 on 16/8/11.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "WZZ_Firework.h"

@interface WZZ_Firework ()
@property (strong,nonatomic) NSMutableArray * imgs;
@end

@implementation WZZ_Firework

-(NSMutableArray *)imgs {
    if (_imgs == nil) {
        _imgs = [NSMutableArray array];
    }
    return  _imgs;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *str;
    for (int i = 0; i < 4; i++) {
        
        switch (i) {
            case 0:
                str= @"恭";
                break;
            case 1:
                str= @"喜";
                break;
            case 2:
                str= @"發";
                break;
            case 3:
                str= @"財";
                break;
                
            default:
                break;
        }
        
        
        CGSize size = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:30]}];
        UIGraphicsBeginImageContext(size);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(ctx, [UIColor clearColor].CGColor);
        CGContextFillRect(ctx, CGRectMake(0, 0, size.width, size.height));
        [str drawAtPoint:CGPointMake(0, 0) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:30],NSForegroundColorAttributeName:[UIColor redColor]}];
        
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [self.imgs addObject:img];
        
    }
    
    NSLog(@"%ld",self.imgs.count);
    
    
    
    
    
    CAEmitterLayer *firework = [CAEmitterLayer layer];
    // 点状发射源可以不指定大小
    firework.position = CGPointMake(self.view.center.x, self.view.bounds.size.height - 100);
    firework.emitterShape = kCAEmitterLayerPoint;
    firework.emitterMode = kCAEmitterLayerPoints;
    firework.renderMode = kCAEmitterLayerAdditive;
    
    CAEmitterCell *ring = [CAEmitterCell emitterCell];
    ring.contents = (id)[UIImage imageNamed:@"FFRing"].CGImage;
    
    ring.birthRate = 1;
    ring.lifetime = 2.5;
    
    //发射方向
    ring.emissionLongitude = -M_PI_2;
    ring.emissionRange = M_PI_2;
    //发射速度
    ring.velocity = 100;
    ring.velocityRange = 50;
    ring.yAcceleration = -60;
    
    // 颜色控制
    ring.color = [UIColor whiteColor].CGColor;
    
    ring.redRange = 0.3;
    ring.blueRange = 0.3;
    ring.greenRange = 0.3;
    ring.alphaRange = 0.2;
    
    ring.redSpeed = 0.1;
    ring.blueSpeed = -0.1;
    ring.greenSpeed = 0.1;
    ring.alphaSpeed = -0.03;
    
    // 旋转
    
    // 缩放
    ring.scale = 0.2;
    
    // burst
    CAEmitterCell *burst = [CAEmitterCell emitterCell];
    
    burst.birthRate = 1;
    burst.lifetime = 0.3;
    burst.scale = 4;
    burst.beginTime = 2.4;
    
    
    
    
    
    //    CAEmitterCell *fire = [CAEmitterCell emitterCell];
    //
    //    fire.contents =(id) [UIImage imageNamed:@"FFTspark"].CGImage;
    //
    //    fire.birthRate = 1000;
    //    fire.lifetime = 3;
    //
    //    fire.velocity = 100;
    //    fire.yAcceleration = 75;
    //
    //    fire.emissionRange = M_PI;
    //    //fire.emissionLongitude = -M_PI_2;
    //
    //
    //
    //    fire.scale = 0.7;
    //    fire.scaleRange = 0.3;
    //    fire.scaleSpeed = -0.08;
    //    fire.color = [UIColor colorWithRed:0.8 green:0.5 blue:0.5 alpha:1].CGColor;
    //    fire.redRange = 0.2;
    //    fire.blueRange = 0.5;
    //    fire.greenRange = 0.5;
    //    //fire.alphaRange = 0.4;
    //   // fire.alphaSpeed = -0.05;
    
    //    fire.redSpeed = 0.1;
    //    fire.blueSpeed = -0.08;
    //    fire.greenSpeed = 0.1;
    //    fire.spin = 0;
    //    fire.spinRange = M_PI;
    NSMutableArray *cells = [NSMutableArray array];
    for (int i = 0; i< 4; i++) {
        CAEmitterCell *cell = [CAEmitterCell emitterCell];
        
        cell.birthRate = 4;
        cell.lifetime = 2;
        cell.emissionRange = M_PI*0.05;
        
        if (i < 2) {
            cell.emissionLongitude = -M_PI_2 - (30 + (1-i)*30) *M_PI/180;
        }
        else {
            cell.emissionLongitude = -M_PI_2 + (30 +(i-2)*30) *M_PI/180;
        }
        
        if ( i >=1 && i <= 2) {
            cell.velocity = 60;
        }
        else {
            cell.velocity = 100;
        }
        
        cell.yAcceleration = 75;
        cell.scale = 2;
        UIImage *img =self.imgs[i];
        cell.contents = (id)img.CGImage;
        
        [cells addObject:cell];
    }
    
    ring.emitterCells = @[burst];
    burst.emitterCells = cells;
    
    firework.emitterCells = @[ring];
    [self.view.layer addSublayer:firework];
    
//    for ( int i = 0; i < 4; i++) {
//        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(20+50*i, 150, 40, 40)];
//        imgV.image = self.imgs[i];
//        [self.view addSubview:imgV];
//    }
    
}

-(void)viewWillAppear:(BOOL)animated {
    self.view.backgroundColor = [UIColor blackColor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
