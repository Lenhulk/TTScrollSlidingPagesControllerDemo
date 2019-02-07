//
//  SSInformationPageViewController.m
//  SoccerScore
//
//  Created by 大雄 on 2018/6/28.
//  Copyright © 2018年 大雄. All rights reserved.
//

#import "SSInformationPageViewController.h"
#import "TTUIScrollViewSlidingPages.h"
#import "TTSlidingPagesDataSource.h"
#import "TTSlidingPageDelegate.h"

#import "SSInformationTableViewController.h"

@interface SSInformationPageViewController ()<TTSlidingPagesDataSource, TTSlidingPageDelegate>
@property (strong, nonatomic) TTScrollSlidingPagesController *slider;
@end

@implementation SSInformationPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [AppUtils dominantColor];
    
#pragma mark 设置TTSlidingPageView
    //initial setup of the TTScrollSlidingPagesController.
    self.slider = [[TTScrollSlidingPagesController alloc] init];
    self.slider.titleScrollerInActiveTextColour = [UIColor lightGrayColor];
    self.slider.titleScrollerBottomEdgeColour = [UIColor darkGrayColor];
    self.slider.titleScrollerBottomEdgeHeight = 0.5;
    
    //set properties to customiser the slider. Make sure you set these BEFORE you access any other properties on the slider, such as the view or the datasource. Best to do it immediately after calling the init method.
    self.slider.titleScrollerBackgroundColour = [AppUtils dominantColor];
    self.slider.initialPageNumber = 0;
    self.slider.titleScrollerTriangleHidden = YES;
    //阴影
    //    self.slider.disableTitleScrollerShadow = YES;
    //    self.slider.disableTitleShadow = YES;
    self.slider.hideStatusBarWhenScrolling = NO;
    
    //    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7){
    //        self.slider.hideStatusBarWhenScrolling = YES;//this property normally only makes sense on iOS7+. See the documentation in TTScrollSlidingPagesController.h. If you wanted to use it in iOS6 you'd have to make sure the status bar overlapped the TTScrollSlidingPagesController.
    //    }
    
    //set the datasource.
    self.slider.dataSource = self;
    self.slider.delegate = self;
    
    //add the slider's view to this view as a subview, and add the viewcontroller to this viewcontrollers child collection (so that it gets retained and stays in memory! And gets all relevant events in the view controller lifecycle)
    self.slider.view.frame = self.view.bounds;
    [self.view addSubview:self.slider.view];
    [self addChildViewController:self.slider];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - TTSlidingPages
#pragma mark TTSlidingPagesDataSource methods
-(int)numberOfPagesForSlidingPagesViewController:(TTScrollSlidingPagesController *)source{
    return 4; //just return 7 pages as an example
}

-(TTSlidingPage *)pageForSlidingPagesViewController:(TTScrollSlidingPagesController*)source atIndex:(int)index{
    UIViewController *viewController;
    if (index == 0){
        viewController = [[SSInformationTableViewController alloc] initWithType:SSInfoTypeWorldCup];
    }
    else if (index == 1){
        viewController = [[SSInformationTableViewController alloc] initWithType:SSInfoTypeSport];
    }
    else if (index == 2) {
        viewController = [[SSInformationTableViewController alloc] initWithType:SSInfoTypeNBA];
    }
    else {
        viewController = [[SSInformationTableViewController alloc] initWithType:SSInfoTypeYule];
    }
    
    return [[TTSlidingPage alloc] initWithContentViewController:viewController];
}

-(TTSlidingPageTitle *)titleForSlidingPagesViewController:(TTScrollSlidingPagesController *)source atIndex:(int)index{
    
    TTSlidingPageTitle *title;
    
    switch (index) {
        case 0:
            title = [[TTSlidingPageTitle alloc] initWithHeaderText:@"世界杯"];
            break;
        case 1:
            title = [[TTSlidingPageTitle alloc] initWithHeaderText:@"体育"];
            break;
        case 2:
            title = [[TTSlidingPageTitle alloc] initWithHeaderText:@"NBA"];
            break;
        case 3:
            title = [[TTSlidingPageTitle alloc] initWithHeaderText:@"娱乐"];
            break;
        default:
            title = [[TTSlidingPageTitle alloc] initWithHeaderText:[NSString stringWithFormat:@"Page %d", index+1]];
            break;
    }
    return title;
}




@end
