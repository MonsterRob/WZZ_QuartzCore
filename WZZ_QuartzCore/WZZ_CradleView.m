//
//  WZZ_CradleView.m
//  WZZ_QuartzCore
//
//  Created by 王召洲 on 16/8/12.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "WZZ_CradleView.h"

#define BALLSIZE 50
@interface WZZ_CradleView ()
@property (strong,nonatomic) NSMutableArray * anchors;
@property (strong,nonatomic) NSMutableArray * balls;
@property (strong,nonatomic) UIDynamicAnimator * animator;
@property (strong,nonatomic) UIPushBehavior * push;
@end

@implementation WZZ_CradleView

-(UIDynamicAnimator *)animator {
    if (_animator == nil) {
        _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self];
    }
    return _animator;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self configAnchors];
        [self configBalls];
        [self addBehaviorForBalls];
    }
    return self;
}

-(void)configAnchors {
    _anchors = [NSMutableArray array];
    
    for (int i = 0; i < 5; i++) {
        UIView *anchor = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        anchor.layer.cornerRadius = 5;
        anchor.backgroundColor = [UIColor redColor];
        anchor.center = CGPointMake(80+ i* BALLSIZE, 200);
        NSValue *v = [NSValue valueWithCGPoint:anchor.center];
        [_anchors addObject:v];
        [self addSubview:anchor];
    }
    
}
-(void)configBalls {
    _balls = [NSMutableArray array];
    for (int i = 0; i< 5; i++) {
        UIView *ball = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BALLSIZE, BALLSIZE)];
        ball.backgroundColor = [UIColor colorWithRed: arc4random_uniform(256)/255.0  green:arc4random_uniform(256)/255.0 blue: arc4random_uniform(256)/255.0 alpha:1 ];
        ball.layer.cornerRadius = BALLSIZE/2.0;
        ball.center = CGPointMake(80+ i* BALLSIZE, 500);
        // 添加手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
        [ball addGestureRecognizer:pan];
        // 添加观察者
        [ball addObserver:self forKeyPath:@"center" options:(NSKeyValueObservingOptionNew) context:nil];
        
        [self addSubview:ball];
        [_balls addObject:ball];
    }
    
    
}
-(void)addBehaviorForBalls {
    // 重力 吸附 碰撞
    UIDynamicBehavior *control = [[UIDynamicBehavior alloc]init];
    [self addAttachmentsFor:control];
    [control addChildBehavior:[self creatCollison]];
    [control addChildBehavior:[self creatGravity]];
    //========================================================//
    UIDynamicItemBehavior *itemB = [[UIDynamicItemBehavior alloc]initWithItems:self.balls];
    itemB.elasticity = 1;
    itemB.density = 0.3;
    itemB.allowsRotation = NO;
    [control addChildBehavior:itemB];
    //=======================================================//
    [self.animator addBehavior:control];
}
// 碰撞
-(UIDynamicBehavior *)creatCollison {
    
    UICollisionBehavior *coll = [[UICollisionBehavior alloc]initWithItems:self.balls];
    return coll;
}
// 重力
-(UIGravityBehavior *)creatGravity {
    UIGravityBehavior *gra = [[UIGravityBehavior alloc]initWithItems:self.balls];
    return gra;
}

// 创建单个吸附行为
-(UIDynamicBehavior *)creatAttachmentFor:(nonnull id <UIDynamicItem>)item toanchorPoint:(NSValue *)pointValue {
    
    UIAttachmentBehavior *att = [[UIAttachmentBehavior alloc]initWithItem:item attachedToAnchor:pointValue.CGPointValue];
    return att;
    
}
// 创建5对吸附行为
-(void)addAttachmentsFor:(UIDynamicBehavior *)control {
    
    for (int i = 0; i < 5; i++) {
        [control addChildBehavior:[self creatAttachmentFor:self.balls[i] toanchorPoint:self.anchors[i]]];
    }
}


-(void)pan:(UIPanGestureRecognizer *)sender {
    
    // 只能在手势开始的时候添加push
    if (sender.state == UIGestureRecognizerStateBegan) {
        _push = [[UIPushBehavior alloc]initWithItems:@[sender.view]mode:(UIPushBehaviorModeContinuous)];
        [self.animator addBehavior:_push];
    }
    
    _push.pushDirection = CGVectorMake([sender translationInView:self].x/10, 0);
    
    // 手势结束移除push
    if (sender.state == UIGestureRecognizerStateEnded) {
        [self.animator removeBehavior:_push];
        _push = nil;
    }
}
- (void)drawRect:(CGRect)rect {
    
    for (int i = 0; i < 5; i ++) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        NSValue *v = self.anchors[i];
        CGPoint point = v.CGPointValue;
        UIView *ball = self.balls[i];
        
        [path moveToPoint:point];
        [path addLineToPoint:ball.center];
        [[UIColor blackColor] setStroke];
        path.lineWidth = 2;
        [path stroke];
    }
    
}
// KVO 设计模式
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    [self setNeedsDisplay];
}
// 记得移除观察者
-(void)dealloc {
    
    for (UIView *ball in self.balls) {
        [ball removeObserver:self forKeyPath:@"center"];
    }
    
}
@end
