//
//  BaseNavigationController.m
//  app28
//
//  Created by Neo on 2017/11/1.
//  Copyright © 2017年 Neo. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()
@end

@implementation BaseNavigationController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 完全不透明
    self.navigationBar.translucent = NO;
    
    // 禁止屏幕边缘滑动（影响过渡动画）
    self.interactivePopGestureRecognizer.enabled = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

//// PUSH转场动画
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    CATransition *anim = [CATransition animation];
    anim.type = @"cube";
    anim.subtype = kCATransitionFromRight;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.duration = 0.3;
    [self.view.layer addAnimation:anim forKey:nil];
    
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:NO];

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
