//
//  WZZ_KeyframeAnimation.m
//  WZZ_QuartzCore
//
//  Created by 王召洲 on 16/8/10.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "WZZ_KeyframeAnimation.h"

@interface WZZ_KeyframeAnimation ()
@property (strong,nonatomic) UILabel * actor;
@end

@implementation WZZ_KeyframeAnimation
-(UILabel *)actor {
    if (_actor == nil) {
        _actor = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        _actor.center = self.view.center;
        _actor.backgroundColor = [UIColor redColor];
        _actor.layer.cornerRadius = 10;
        _actor.layer.position = CGPointMake(50, self.view.center.y);
    }
    return _actor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.actor];
    [self setUI];
    
}
-(void)setUI {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(20, 84, 100, 50);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
-(void)btnTap :(UIButton *)sender {
    // 关键帧动画
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];//
    // keyPath :
    // position bounds 。。。
    // transform.scale(x,y)
    // transform.rotation(x,y,z);
    //transform.translation(x,y);
    // 其他可动画属性 animatable properties
    
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(50, self.view.center.y)];
//    [path addQuadCurveToPoint:CGPointMake(350, self.view.center.y) controlPoint:CGPointMake(200, 50)];
//    keyAnimation.path = path.CGPath;// 动画路径
//    keyAnimation.duration = 5;
//    keyAnimation.removedOnCompletion = NO;// 是否在动画结束后移除动画
//    keyAnimation.fillMode = kCAFillModeForwards;// 保持动画最终状态
    CGPoint p1 = CGPointMake(0, 64);
    CGPoint p2 = CGPointMake(self.view.bounds.size.width, 64);
    CGPoint p3 = CGPointMake(100, 180);
    CGPoint p4 = CGPointMake(300, 400);
    
    NSValue *v1 = [NSValue valueWithCGPoint:p1];
    NSValue *v2 = [NSValue valueWithCGPoint:p2];

    NSValue *v3 = [NSValue valueWithCGPoint:p3];

    NSValue *v4 = [NSValue valueWithCGPoint:p4];

//    CGPoint k1 = self.actor.layer.position;
//    CGPoint k2 = CGPointMake(self.actor.layer.position.x+100, self.actor.layer.position.y);
//    NSValue *v1 = [NSValue valueWithCGPoint:k1];
//    NSValue *v2 = [NSValue valueWithCGPoint:k2];
    keyAnimation.values =@[v1,v2,v3,v4];// 帧
    keyAnimation.autoreverses = YES;// 按照原来路径倒着走
    keyAnimation.duration = 2;// 一次动画时长
    keyAnimation.repeatCount = MAXFLOAT;// 动画重复次数
    //keyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];// 事件函数
    [self.actor.layer addAnimation:keyAnimation forKey:nil];
    
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
