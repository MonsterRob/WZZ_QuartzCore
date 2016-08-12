//
//  WZZ_BasicAnimation.m
//  WZZ_QuartzCore
//
//  Created by 王召洲 on 16/8/10.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "WZZ_BasicAnimation.h"

#import <QuartzCore/QuartzCore.h>

@interface WZZ_BasicAnimation ()
@property (strong,nonatomic) CALayer * actor;
@end

@implementation WZZ_BasicAnimation

-(CALayer *)actor {
    if (_actor == nil) {
        _actor = [CALayer layer];
        _actor.frame = CGRectMake(30, 94, 200, 200);
        _actor.backgroundColor = [UIColor blueColor].CGColor;
    }
    return _actor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view.layer addSublayer:self.actor];
    [self setControl];
}
-(void)setControl {
    for (int i = 0; i < 4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.tag = i+1;
        btn.frame = CGRectMake(0, 0, 100, 50);
        btn.center = CGPointMake(self.view.center.x,self.view.center.y + i* 80);
        btn.backgroundColor = [UIColor blackColor];
        btn.layer.cornerRadius = 20;
        
        switch (i) {
            case 0:
                [btn setTitle:@"圆角" forState:UIControlStateNormal];
                break;
            case 1:
                [btn setTitle:@"透明度" forState:UIControlStateNormal];
                break;
            case 2:
                [btn setTitle:@"Z旋转" forState:UIControlStateNormal];
                break;
            case 3:
                [btn setTitle:@"弹簧" forState:UIControlStateNormal];
                break;
                
            default:
                break;
        }
        [btn addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}
-(void)btnTap:(UIButton *)sender {
    //[self.actor removeAllAnimations];// 将原有动画移除
    
    // 移除动画 动画产生的效果也移除
    
    if (sender.tag == 1) {
        
        CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
        basic.fromValue = (id)[NSNumber numberWithFloat:0];
        basic.toValue = [NSNumber numberWithFloat:100];
        basic.duration = 5;
        basic.removedOnCompletion = NO;
        basic.fillMode =kCAFillModeForwards;
        [self.actor addAnimation:basic forKey:nil];
    }
    else if (sender.tag == 2) {
        
        CABasicAnimation *alpha = [CABasicAnimation animationWithKeyPath:@"opacity"];
        alpha.duration = 5;
        alpha.fromValue = [NSNumber numberWithFloat:1];
        alpha.toValue = [NSNumber numberWithFloat:0];
        [self.actor addAnimation:alpha forKey:nil];
    }
    else if (sender.tag == 3) {
        CABasicAnimation *z = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        z.fromValue = @(0);
        z.toValue = @(M_PI);
        z.duration = 5;
        [self.actor addAnimation:z forKey:nil];
    }
    else if (sender.tag == 4) {
        CASpringAnimation *s = [CASpringAnimation animationWithKeyPath:@"transform.scale.y"];
        s.fromValue = [NSNumber numberWithFloat:self.actor.contentsScale];
        s.toValue = [NSNumber numberWithFloat:self.actor.contentsScale*0.2];
        s.mass = 1;
        s.damping = 0.6;
        s.initialVelocity = -5;
        s.stiffness = 5;
        s.duration = s.settlingDuration;
        
        [self.actor addAnimation:s forKey:nil];
    }
    
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
