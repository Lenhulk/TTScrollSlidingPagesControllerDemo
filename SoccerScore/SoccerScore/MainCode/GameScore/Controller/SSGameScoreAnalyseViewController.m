//
//  SSGameScoreAnalyseViewController.m
//  SoccerScore
//
//  Created by 大雄 on 2018/7/1.
//  Copyright © 2018年 大雄. All rights reserved.
//

#import "SSGameScoreAnalyseViewController.h"
#import "SSGamescoreModel.h"
#import <UIImageView+WebCache.h>
#import "NSString+Base64.h"

@interface SSGameScoreAnalyseViewController () <UITableViewDelegate, UITableViewDataSource>
{
    SSGameAnalyzeType _anlyType;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSNumber *matchId;

@property (weak, nonatomic) IBOutlet UILabel *scoreLb;
@property (weak, nonatomic) IBOutlet UIImageView *homeTeamLogo;
@property (weak, nonatomic) IBOutlet UIImageView *awayTeamLogo;
@property (weak, nonatomic) IBOutlet UILabel *homeTeamName;
@property (weak, nonatomic) IBOutlet UILabel *awayTeamName;

@end

@implementation SSGameScoreAnalyseViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil matchId:(NSNumber *)matchId{
    if (self = [super initWithNibName:nibNameOrNil bundle:nil]) {
        self.matchId = matchId;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"分析&赔率";
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    //TODO: ?两队基本内容
    NSDictionary *teamAway = self.model.bfZqTeamAway;
    _awayTeamName.text = teamAway[@"gs"];
    [_awayTeamLogo sd_setImageWithURL:[NSURL URLWithString:teamAway[@"flags"]] placeholderImage:[UIImage imageNamed:@"football"]];
    NSDictionary *teamHome = self.model.bfZqTeamHome;
    _homeTeamName.text = teamHome[@"g"];
    [_homeTeamLogo sd_setImageWithURL:[NSURL URLWithString:teamHome[@"flag"]] placeholderImage:[UIImage imageNamed:@"football"]];
    
    _scoreLb.text = [NSString stringWithFormat:@"%@ - %@", self.model.homeScore, self.model.awayScore];
    
    //TODO: 加载赔率
//    _anlyType = SSGameAnalyzeTypeYapan;
//    NSString *rawObjStr = [NSString stringWithFormat:@"{\"oddsType\":\"%ld\",\"matchId\":%@}", _anlyType, self.model.matchId];
//    rawObjStr = [rawObjStr q_base64Encode];
//    NSDictionary *parm = @{@"object":@"eyJvZGRzVHlwZSI6IjEiLCJtYXRjaElkIjoxNTAwODkyfQ==",
//                           @"sign":@"3d0e79b3733b969c25b249ef12f4f5ef"};
//    [[NTNetManager sharedManager] postDataWithType:NTRequestTypeGameOddsData parameters:parm success:^(NSDictionary *dictArr) {
//
//    } failure:^(NSError *error) {
//
//    }];
    
    //TODO: 加载分析
    _anlyType = SSGameAnalyzeTypeHistory;
    NSString *rawObjstr = [NSString stringWithFormat:@"{\"matchId\":%@}", self.model.matchId];
    rawObjstr = [rawObjstr q_base64Encode];
    NSDictionary *parm = @{@"object":rawObjstr, @"sign":@"00e69c7a057d4c90858e0e131a59ced7"};
    [[NTNetManager sharedManager] postDataWithType:NTRequestTypeGameAnalyzeHistory parameters:parm success:^(NSDictionary *twoTeamDict) {
        
    } failure:^(NSError *error) {
        
    }];
}


- (IBAction)tapDetailSwitchBtn:(UIButton *)sender {
    NSLog(@"点击了什么鬼:%ld", sender.tag);
    //TODO: 根据点击的 获取网络请求 刷新tableView
}

- (IBAction)SegcValueChange:(UISegmentedControl *)sender {
    NSLog(@"点击了切换:%ld", sender.selectedSegmentIndex);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TABLEVIEW
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = [AppUtils ramdomColor];
    return cell;
}

@end
