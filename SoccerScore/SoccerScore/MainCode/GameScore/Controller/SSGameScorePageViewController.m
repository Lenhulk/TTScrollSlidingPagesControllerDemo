//
//  SSGameScorePageViewController.m
//  SoccerScore
//
//  Created by 大雄 on 2018/6/27.
//  Copyright © 2018年 大雄. All rights reserved.
//

#import "SSGameScorePageViewController.h"
#import "TTUIScrollViewSlidingPages.h"
#import "TTSlidingPagesDataSource.h"
#import "TTSlidingPageDelegate.h"

#import "SSGameScoreTableViewController.h"

@interface SSGameScorePageViewController () <TTSlidingPagesDataSource, TTSlidingPageDelegate>
@property (strong, nonatomic) TTScrollSlidingPagesController *slider;
@end

@implementation SSGameScorePageViewController

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


#pragma mark - TTSlidingPages
#pragma mark TTSlidingPagesDataSource methods
-(int)numberOfPagesForSlidingPagesViewController:(TTScrollSlidingPagesController *)source{
    return 4; //just return 7 pages as an example
}

-(TTSlidingPage *)pageForSlidingPagesViewController:(TTScrollSlidingPagesController*)source atIndex:(int)index{
    UIViewController *viewController;
    if (index == 0){
        viewController = [[SSGameScoreTableViewController alloc] initWithType:SSGameScoreTypeGunqiu];
    } else if (index == 1){
        viewController = [[SSGameScoreTableViewController alloc] initWithType:SSGameScoreTypeJishi];
    } else if (index == 2) {
        viewController = [[SSGameScoreTableViewController alloc] initWithType:SSGameScoreTypeWanchang];
    } else {
        viewController = [[SSGameScoreTableViewController alloc] initWithType:SSGameScoreTypeSaicheng];
    }
    
    return [[TTSlidingPage alloc] initWithContentViewController:viewController];
}

-(TTSlidingPageTitle *)titleForSlidingPagesViewController:(TTScrollSlidingPagesController *)source atIndex:(int)index{
    
    TTSlidingPageTitle *title;
    //use a image as the header for the first page
    //        title= [[TTSlidingPageTitle alloc] initWithHeaderImage:[UIImage imageNamed:@"about-tomthorpelogo.png"]];

    switch (index) {
        case 0:
            title = [[TTSlidingPageTitle alloc] initWithHeaderText:@"滚球"];
            break;
        case 1:
            title = [[TTSlidingPageTitle alloc] initWithHeaderText:@"即时"];
            break;
        case 2:
            title = [[TTSlidingPageTitle alloc] initWithHeaderText:@"完场"];
            break;
        case 3:
            title = [[TTSlidingPageTitle alloc] initWithHeaderText:@"赛程"];
            break;
        default:
            title = [[TTSlidingPageTitle alloc] initWithHeaderText:[NSString stringWithFormat:@"Page %d", index+1]];
            break;
    }
    return title;
}

#pragma mark delegate
- (void)didScrollToViewAtIndex:(NSUInteger)index
{
    NSLog(@"scrolled to view");
}

- (void)didTapOnScrollTopView:(NSUInteger)index
{
    NSLog(@"tapped to view");
}

@end
