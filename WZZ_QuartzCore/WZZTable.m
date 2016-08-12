//
//  WZZTable.m
//  WZZ_QuartzCore
//
//  Created by 王召洲 on 16/8/10.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "WZZTable.h"
#import "WZZ_shadow.h"
#import "WZZ_3DTransform.h"
#import "WZZ_BasicAnimation.h"
#import "WZZ_KeyframeAnimation.h"
#import "WZZ_EmitterAnimation.h"
#import "WZZ_DynamicAnimation.h"
#import "WZZ_Firework.h"
#import "WZZ_ShapeLayer.h"
#import "WZZ_PicAndText.h"
#import "WZZ_Gravity.h"
#import "WZZ_Collision.h"
#import "WZZ_Snap.h"
#import "WZZ_Attachment.h"
#import "WZZ_Push.h"
#import "WZZ_Cradle.h"
@interface WZZTable ()
@property (strong,nonatomic) NSMutableArray * VCArr;
@end

@implementation WZZTable
-(NSMutableArray *)VCArr {
    if (!_VCArr) {
        _VCArr = [NSMutableArray arrayWithObjects:@"WZZ_shadow",@"WZZ_3DTransform",@"WZZ_BasicAnimation",@"WZZ_KeyframeAnimation",@"WZZ_EmitterAnimation",@"WZZ_DynamicAnimation",@"WZZ_ShapeLayer",@"WZZ_Firework",@"WZZ_PicAndText",@"WZZ_Gravity",@"WZZ_Collision",@"WZZ_Snap",@"WZZ_Attachment",@"WZZ_Push",@"WZZ_Cradle", nil];
    }
    return _VCArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CC"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.VCArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CC" forIndexPath:indexPath];
    cell.textLabel.text = self.VCArr[indexPath.row];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Class cls = NSClassFromString(self.VCArr[indexPath.row]);
    UIViewController *VC = [[cls alloc]init];
    
    VC.navigationItem.title = self.VCArr[indexPath.row];
    VC.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
    
    [self.navigationController pushViewController:VC animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
