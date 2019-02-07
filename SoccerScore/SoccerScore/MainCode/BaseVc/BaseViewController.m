//
//  BaseViewController.m
//  app28
//
//  Created by Neo on 2017/11/1.
//  Copyright © 2017年 Neo. All rights reserved.
//

#import "BaseViewController.h"
//#import "CopyRightView.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 默认背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置statusBar
    [self setNeedsStatusBarAppearanceUpdate];
    [self setStatusBarBackgroundColor:[AppUtils dominantColor]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    // 隐藏分割线
    self.navLine = [self findHairLineImgvUnder:self.navigationController.navigationBar];
    self.navLine.hidden = YES;

    // 设置CR
//    CopyRightView *crView = [[CopyRightView alloc] initWithFrame:CGRectMake(0, kSCREEN_H-kAPPTOPS_H-kTABBAR_H-kCopyright_H, kSCREEN_W, kCopyright_H)];
//    [self.view addSubview:crView];

}

// 寻找导航栏分割线
- (UIImageView *)findHairLineImgvUnder:(UIView *)view{
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subView in view.subviews) {
        UIImageView *imgv = [self findHairLineImgvUnder:subView];
        if (imgv) {
            return imgv;
        }
    }
    return nil;
}


// POP动画
-(void)viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        // back button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
        CATransition *anim = [CATransition animation];
        anim.type = @"cube";
        anim.subtype = kCATransitionFromLeft;
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        anim.duration = 0.3;
        [self.navigationController.view.layer addAnimation:anim forKey:nil];
    }
    [super viewWillDisappear:NO];
}


-(void)viewWillAppear:(BOOL)animated{
    [self preferredStatusBarStyle];
//    [self setStatusBarBackgroundColor:[UIColor whiteColor]];
}

// 设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {

    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
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
