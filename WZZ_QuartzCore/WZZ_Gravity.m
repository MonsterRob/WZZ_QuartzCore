//
//  WZZ_Gravity.m
//  WZZ_QuartzCore
//
//  Created by 王召洲 on 16/8/12.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "WZZ_Gravity.h"

@interface WZZ_Gravity ()
@property (strong,nonatomic) UIDynamicAnimator * animator;
@end

@implementation WZZ_Gravity

-(UIDynamicAnimator *)animator {
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    }
    return _animator;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *item1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    item1.tag = 1;
    item1.center = self.view.center;
    item1.backgroundColor = [UIColor redColor];
    [self.view addSubview:item1];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, 30);
    btn.backgroundColor = [UIColor blackColor];
    btn.tag =2;
    [self.view addSubview:btn];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(300, 0, 100, 30)];
    label.backgroundColor = [UIColor greenColor];
    label.tag = 3;
    [self.view addSubview:label];
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.animator removeAllBehaviors];
    
    // 1000p/s^2
    UIView *item1 = [self.view viewWithTag:1];
    UIView *item2 = [self.view viewWithTag:2];
    UIView *item3 = [self.view viewWithTag:3];
    
    UIGravityBehavior *gra1 = [[UIGravityBehavior alloc]initWithItems:@[item1]];
   // gra1.magnitude = 0.5;// 加速度系数
    //gra1.angle = -M_PI_2;// 加速度方向
    [gra1 setAngle:M_PI_4 magnitude:0.1];
    
    UIDynamicBehavior *be = [[UIDynamicBehavior alloc]init];
    [be addChildBehavior:gra1];
    
    
    
//    UIGravityBehavior *gra2 = [[UIGravityBehavior alloc]initWithItems:@[item2,item3]];
//    [be addChildBehavior:gra2];
    
    
    [self.animator addBehavior:be];
    //[self.animator addBehavior:gra2];
    
    
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
