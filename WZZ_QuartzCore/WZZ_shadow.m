//
//  WZZ_shadow.m
//  WZZ_QuartzCore
//
//  Created by 王召洲 on 16/8/10.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "WZZ_shadow.h"

@interface WZZ_shadow ()
@property (strong,nonatomic) UIImageView * imgV;
@end

@implementation WZZ_shadow

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setControl];
    [self setImgBoard];
    
}
-(void)setImgBoard {
    self.imgV.layer.borderWidth = 4;
    self.imgV.layer.borderColor = [UIColor blackColor].CGColor;
}
-(void)setUI {
    _imgV = [[UIImageView alloc]initWithFrame:CGRectMake(30, 80, self.view.bounds.size.width-60, 300)];
    
    UIImage *img = [UIImage imageNamed:@"5.jpg"];
    _imgV.image = img;
    _imgV.layer.masksToBounds = YES;
    [self.view addSubview:self.imgV];
    
    for (int i = 0; i < 5; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
        label.center = CGPointMake(40, self.view.center.y+60 + i*40);
        switch (i) {
            case 0:
                label.text =@"透明度";
                break;
            case 1:
                label.text =@"阴影颜色";
                break;
            case 2:
                label.text =@"偏移量";
                break;
            case 3:
                label.text =@"圆角";
                break;
            case 4:
                label.text =@"图片圆角";
                break;
                
            default:
                break;
        }
        
        [self.view addSubview:label];

    }
}
-(void)setControl {
    for (int i = 0; i < 5; i++) {
        UISlider *sl = [[UISlider alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width*0.6, 8)];
        sl.center = CGPointMake(self.view.center.x, self.view.center.y +60+ i * 40);
        sl.tag = i+1;
        [sl addTarget:self action:@selector(sliderSL:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:sl];
    }
}

-(void)sliderSL :(UISlider *)sender {
    switch (sender.tag) {
        case 1:
            self.imgV.layer.shadowOpacity = sender.value;
            break;
        case 2:
            self.imgV.layer.shadowColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1].CGColor;
            break;
        case 3:
            
            self.imgV.layer.shadowOffset = CGSizeMake(-20*sender.value, 20*sender.value);
            break;
        case 4:
            
            self.imgV.layer.shadowRadius = sender.value *20;
            break;
        case 5:
            self.imgV.layer.cornerRadius = sender.value * _imgV.image.size.width;
            break;
            
        default:
            break;
    }
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
