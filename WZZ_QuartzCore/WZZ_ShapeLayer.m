//
//  WZZ_ShapeLayer.m
//  WZZ_QuartzCore
//
//  Created by 王召洲 on 16/8/11.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "WZZ_ShapeLayer.h"

@interface WZZ_ShapeLayer ()

@end

@implementation WZZ_ShapeLayer

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 200, 80);
    btn.center = self.view.center;
    btn.backgroundColor = [UIColor redColor];
    CAShapeLayer *shape = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight) cornerRadii:CGSizeMake(30, 20)];
    shape.path = path.CGPath;
    
    btn.layer.mask = shape;
    [self.view addSubview:btn];
    
    
    
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
