//
//  WZZ_Collision.m
//  WZZ_QuartzCore
//
//  Created by 王召洲 on 16/8/12.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "WZZ_Collision.h"

@interface WZZ_Collision ()
{
    CGPoint p1;
    CGPoint p2;
}
@property (strong,nonatomic) UIDynamicAnimator * animator;
@property (weak,nonatomic) NSArray  * items;
@end

@implementation WZZ_Collision
-(UIDynamicAnimator *)animator {
    if (_animator == nil) {
        _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    }
    return _animator;
}
-(void)setVisualLine {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:p1];
    [path addLineToPoint:p2];
    
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.path = path.CGPath;
    
    shape.lineWidth = 5;
    shape.strokeColor = [UIColor blackColor].CGColor;
    [self.view.layer addSublayer:shape];
}
-(void)addVisualArc {
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:100 startAngle:0 endAngle:M_PI clockwise:YES];
    [path addArcWithCenter:self.view.center radius:100 startAngle:M_PI endAngle:0 clockwise:NO];
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.frame = self.view.bounds;
    
    shape.path = path.CGPath;
    
    
    
    
    shape.lineWidth = 3;
    shape.strokeColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:shape];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    p1 = CGPointMake(100, 400);
    p2 = CGPointMake(300, 500);
    //[self setVisualLine];
    [self addVisualArc];
    
    
    for (int i = 0; i < 5; i++) {
        UIView *item = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        
        item.layer.cornerRadius = 25;
        item.center = CGPointMake(30+i*60, 80+i*70);
        item.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
        [self.view addSubview:item];
    }
    
    self.items = self.view.subviews;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.animator removeAllBehaviors];
    
    UIGravityBehavior *gra = [[UIGravityBehavior alloc]initWithItems:self.items];
    UICollisionBehavior *col = [[UICollisionBehavior alloc]initWithItems:self.items];
    // 碰撞模式
    col.collisionMode = UICollisionBehaviorModeEverything;
    // 将参考边界转换为碰撞边界
    col.translatesReferenceBoundsIntoBoundary = YES;
    
    [col addBoundaryWithIdentifier:@"Y" fromPoint:p1 toPoint:p2];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:100 startAngle:0 endAngle:M_PI clockwise:YES];
    [path addArcWithCenter:self.view.center radius:100 startAngle:M_PI endAngle:0 clockwise:NO];
   
   [col addBoundaryWithIdentifier:@"Y" forPath:path];

    // 只有UIDynamicBehavior 或者它的自定义子类才可以使用addChild方法
    UIDynamicBehavior *control = [[UIDynamicBehavior alloc]init];
    [control addChildBehavior:gra];
    [control addChildBehavior:col];

    UIDynamicItemBehavior *itemB = [[UIDynamicItemBehavior alloc]initWithItems:self.items];
    //itemB.allowsRotation = YES;// 允许旋转
    itemB.angularResistance = 0.2;
    itemB.elasticity = 1;// 弹性系数
    itemB.density = 0.5;// 相对密度
    
//    for (int i = 0; i <self.items.count; i++) {
//        // 添加旋转角度
//        [itemB addAngularVelocity:M_PI_4 + i * 5 * M_PI/180 forItem:self.items[i]];
//    }
    
    
    [control addChildBehavior:itemB];
    
    [self.animator addBehavior:control];
    
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
