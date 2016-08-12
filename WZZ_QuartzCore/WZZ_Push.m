//
//  WZZ_Push.m
//  WZZ_QuartzCore
//
//  Created by 王召洲 on 16/8/12.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "WZZ_Push.h"

@interface WZZ_Push ()
@property (strong,nonatomic) UIDynamicAnimator * animator;
@end

@implementation WZZ_Push

-(UIDynamicAnimator *)animator {
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
        
    }
    return _animator;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *item = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    item.center = self.view.center;
    item.backgroundColor = [UIColor colorWithRed: arc4random_uniform(256)/255.0  green:arc4random_uniform(256)/255.0 blue: arc4random_uniform(256)/255.0 alpha:1 ];
    [self.view addSubview:item];
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint prePoint = [touch previousLocationInView:self.view];
    CGPoint nowPoint = [touch locationInView:self.view];
    
    //NSLog(@"%@ %@",NSStringFromCGPoint(prePoint),NSStringFromCGPoint(nowPoint));
    // 创建一个向量
    CGVector vector = CGVectorMake(nowPoint.x-prePoint.x, nowPoint.y-prePoint.y);
    [self.animator removeAllBehaviors];
    
    UIPushBehavior *tuidao = [[UIPushBehavior alloc]initWithItems:self.view.subviews mode:(UIPushBehaviorModeInstantaneous)];
    tuidao.pushDirection = vector;
    
    UIDynamicItemBehavior *itemB = [[UIDynamicItemBehavior alloc]initWithItems:self.view.subviews];
    itemB.friction = 2;
    itemB.density = 3;
    itemB.resistance = 2;
    
    [self.animator addBehavior:itemB];
    [self.animator addBehavior:tuidao];
    
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
