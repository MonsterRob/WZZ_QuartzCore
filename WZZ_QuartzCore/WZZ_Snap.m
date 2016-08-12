//
//  WZZ_Snap.m
//  WZZ_QuartzCore
//
//  Created by 王召洲 on 16/8/12.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "WZZ_Snap.h"

@interface WZZ_Snap ()
@property (strong,nonatomic) UIDynamicAnimator * animator;
@end

@implementation WZZ_Snap

-(UIDynamicAnimator *)animator {
    if (_animator == nil) {
        _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    }
    return _animator;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *item = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    item.center  = self.view.center;
    item.tag = 1;
    item.backgroundColor = [UIColor redColor];
    [self.view addSubview:item];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.animator removeAllBehaviors];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    UIView *item = [self.view viewWithTag:1];
    
    UISnapBehavior *snap = [[UISnapBehavior alloc]initWithItem:item snapToPoint:point];
    snap.damping = 0.5;
    [self.animator addBehavior:snap];
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
