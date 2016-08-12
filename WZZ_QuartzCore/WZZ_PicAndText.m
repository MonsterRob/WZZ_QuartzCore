//
//  WZZ_PicAndText.m
//  WZZ_QuartzCore
//
//  Created by 王召洲 on 16/8/11.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "WZZ_PicAndText.h"

@interface WZZ_PicAndText ()

@end

@implementation WZZ_PicAndText

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *str = @"\t在中国组合的6轮技术动作中，最为出色的当属第5跳，林跃和陈艾森两人拿到了106.56的高分。就连BBC的解说员，都不得不为两人的完美发挥而叹服：“天呐！这是怎样的一跳！我不知道该说什么了……完美的一跳！";
    CGSize size = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:30]}];
    NSLog(@"%@",NSStringFromCGSize(size));
    
    //
 CGRect rect= [str boundingRectWithSize:CGSizeMake(self.view.bounds.size.width-100, MAXFLOAT) options:
               (NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:25]} context:nil];
    CGSize size1 = CGSizeMake(ceil(rect.size.width), ceil(rect.size.height));
    
    NSLog(@"%@",NSStringFromCGSize(size1));
    
    NSLog(@"%@",NSStringFromCGRect(rect));
    

    UILabel *label = [[UILabel alloc]init];
    
    label.frame = CGRectMake(0, 100, size1.width+30 , size1.height+20);
    label.text = str;
    label.numberOfLines = 0;
    [self.view addSubview:label];
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
