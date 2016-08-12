//
//  WZZ_Attachment.m
//  WZZ_QuartzCore
//
//  Created by 王召洲 on 16/8/12.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "WZZ_Attachment.h"

@interface WZZ_Attachment ()
@property (strong,nonatomic) UIDynamicAnimator * animator;
@property (weak,nonatomic) NSArray  * items;
@end

@implementation WZZ_Attachment
-(UIDynamicAnimator *)animator {
    if (_animator == nil) {
        _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    }
    return _animator;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (int i = 0; i < 5; i++)
    {
        UIView *item = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        
        if (i == 0) {
            UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
            [item addGestureRecognizer:pan];
        }
        
        item.layer.cornerRadius = 25;
        item.center = CGPointMake(70+i*60, self.view.center.y+300);
        item.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
        [self.view addSubview:item];
    }
    self.items = self.view.subviews;
    
}
-(void)pan:(UIPanGestureRecognizer *)sender {
    
    [self.animator removeAllBehaviors];
    
    CGPoint point = [sender locationInView:self.view];
    UIDynamicBehavior *control = [[UIDynamicBehavior alloc]init];
    
    UIAttachmentBehavior *att;
    for (int i = 0; i <5 ; i++) {
        if (i == 0) {
            att = [[UIAttachmentBehavior alloc]initWithItem:self.items[i] attachedToAnchor:point];
            att.length = 1;
        }
        else {
            att = [[UIAttachmentBehavior alloc]initWithItem:self.items[i] attachedToItem:self.items[i-1]];
            att.length = 60;
        }
        att.damping = 0.5;
        att.frequency = 3;
        
        [control addChildBehavior:att];
    }
    
    [self.animator addBehavior:control];
    
    UIGravityBehavior *gra = [[UIGravityBehavior alloc]initWithItems:self.items];
    
    [control addChildBehavior:gra];
    [self.animator addBehavior:control];
    
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
