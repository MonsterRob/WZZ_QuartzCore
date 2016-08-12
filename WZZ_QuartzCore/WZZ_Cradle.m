//
//  WZZ_Cradle.m
//  WZZ_QuartzCore
//
//  Created by 王召洲 on 16/8/12.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "WZZ_Cradle.h"
#import "WZZ_CradleView.h"
@interface WZZ_Cradle ()

@end

@implementation WZZ_Cradle
-(void)loadView {
    self.view =[[ WZZ_CradleView alloc]initWithFrame:CGRectZero];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
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
