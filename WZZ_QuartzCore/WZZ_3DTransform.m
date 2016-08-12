//
//  WZZ_3DTransform.m
//  WZZ_QuartzCore
//
//  Created by 王召洲 on 16/8/10.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "WZZ_3DTransform.h"

@interface WZZ_3DTransform ()
{
    CATransform3D pre;// 用来记录每次改变后的状态
}
@property (strong,nonatomic) CALayer * myLayer;
@end

@implementation WZZ_3DTransform

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setMyLayer];
    [self setLabel];
    [self setRotationControl];
}

-(void)setMyLayer {
    _myLayer = [CALayer layer];
    _myLayer.frame = CGRectMake(0, 64, 200, 100);
    _myLayer.backgroundColor = [UIColor redColor].CGColor;
    UIImage *img = [UIImage imageNamed:@"5.jpg"];
    NSLog(@"%@",NSStringFromCGPoint(_myLayer.position));
    // position.x = frame.origin.x + 0.5 * width;
    //position.y = frame.origin.y + 0.5 * height;
    
   // frame.origin.x = position.x- 0 * width;
    //frame.origin.y = position.y- 0 * width;
    
    //_myLayer.position = CGPointMake(0, 0);
    //_myLayer.position = self.view.center;
    // 0~1
    
    _myLayer.anchorPoint = CGPointMake(1, 1);
    _myLayer.position = self.view.center;
    
    NSLog(@"%@",NSStringFromCGPoint(_myLayer.position));
    
    _myLayer.contents = (__bridge id _Nullable)(img.CGImage);
    pre = _myLayer.transform;
    [self.view.layer addSublayer:_myLayer];
    
}
-(void)setLabel {
    for (int i = 0; i < 3; i ++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
        label.center = CGPointMake(40, self.view.center.y + 100 + i * 30);
        switch (i) {
            case 0:
                label.text = @"X";
                break;
            case 1:
                label.text = @"Y";
                break;
            case 2:
                label.text = @"Z";
                break;
                
            default:
                break;
        }
        [self.view addSubview:label];
    }
}
-(void)setRotationControl {
    for (int i = 0; i < 3; i++) {
        UISlider *SL = [[UISlider alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width*0.6, 8)];
        SL.center = CGPointMake(self.view.center.x, self.view.center.y + 100 + i * 30);
        SL.tag = i+1;
        [SL addTarget:self action:@selector(sliderSlide:) forControlEvents:UIControlEventValueChanged];
        [SL addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:SL];
        
    }
}
-(void)touchUp {
    NSLog(@"UP");
    pre = _myLayer.transform;
}
-(void)sliderSlide :(UISlider *)sender {
    
    switch (sender.tag) {
        case 1:
            
            self.myLayer.transform = CATransform3DRotate(pre, M_PI*2*sender.value, 1, 0, 0);
            break;
        case 2:
            self.myLayer.transform = CATransform3DRotate(pre, M_PI*2*sender.value, 0, 1, 0);
            
            break;
        case 3:
            self.myLayer.transform = CATransform3DRotate(pre, M_PI*2*sender.value, 0, 0, 1);
            break;
            
        default:
            break;
    }
    NSLog(@"%g",sender.value);
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
