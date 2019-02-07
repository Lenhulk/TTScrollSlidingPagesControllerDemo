//
//  BaseTabBarController.m
//  app28
//
//  Created by Neo on 2017/11/22.
//  Copyright © 2017年 Neo. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"


@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // TabBar有颜色时禁止透明
    self.tabBar.translucent = NO;
    
//    [self setupChildVCs];
    
}

/*
- (void)setupChildVCs{
    HomeViewController *home = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    [self setupNav:home title:@"好彩快三" tabBarIcon:@"appiiocn_shouye"];
    
//    UIViewController *vc = [[UIViewController alloc] init];
//    vc.view.backgroundColor = [AppUtils ramdomColor];
//    [self setupNav:vc title:@"投注站" tabBarIcon:@"menu-2"];

    InformationViewController *info = [[InformationViewController alloc] init];
    [self setupNav:info title:@"彩讯速递" tabBarIcon:@"appiiocn_zixun"];

    LotteryViewController *lottery = [[LotteryViewController alloc] initWithNibName:nil bundle:nil];
    [self setupNav:lottery title:@"开奖记录" tabBarIcon:@"appiiocn_jilu"];

    TrendViewController *trend = [[TrendViewController alloc] init];
    [self setupNav:trend title:@"走势图" tabBarIcon:@"appiiocn_zoushi"];
}
*/


- (void)setupNav:(UIViewController *)vc title:(NSString *)title tabBarIcon:(NSString *)imageName{
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    nav.tabBarItem.image = [UIImage imageNamed:imageName];
    nav.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_hui", imageName]];
//    nav.tabBarItem.imageInsets =UIEdgeInsetsMake(6, 0, -6, 0);  //无标题时偏移
    nav.tabBarItem.title = title==nil?@"":title;
    if (title != nil) {
        vc.navigationItem.title = title;
    }
    
    // 设置普通颜色、选中颜色
    NSDictionary *dictHome = [NSDictionary dictionaryWithObject:NTColor(122, 238, 255) forKey:NSForegroundColorAttributeName];
    [nav.tabBarItem setTitleTextAttributes:dictHome forState:UIControlStateSelected];
    NSDictionary *dictHome2 = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [nav.tabBarItem setTitleTextAttributes:dictHome2 forState:UIControlStateNormal];

    [self addChildViewController:nav];
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
