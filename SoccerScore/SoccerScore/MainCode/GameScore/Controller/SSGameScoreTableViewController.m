//
//  SSGameScoreTableViewController.m
//  SoccerScore
//
//  Created by 大雄 on 2018/6/27.
//  Copyright © 2018年 大雄. All rights reserved.
//

#import "SSGameScoreTableViewController.h"
#import "SSGamescoreGunqiuCell.h"
#import "SSGamescoreModel.h"
#import <MJRefresh.h>
#import "SSGamescoreDateHeader.h"

#import "SSGameScoreAnalyseViewController.h"

#define kGunqiuCell @"SSGamescoreGunqiuCell"

@interface SSGameScoreTableViewController ()
@property (nonatomic, strong) NSArray *objcArr;
@end

@implementation SSGameScoreTableViewController

- (instancetype)initWithType:(SSGameScoreType)type{
    self = [super init];
    self.gstype = type;
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [AppUtils lightGrayBgColor];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_W, 5)]; //顶部间距
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:kGunqiuCell bundle:nil] forCellReuseIdentifier:kGunqiuCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"SSGamescoreDateHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:@"SSGamescoreDateHeader"];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestDataAndReload];
    }];
    
    
    
    [self requestDataAndReload];
    
}

- (void)requestDataAndReload{
    NSDictionary *parm;
    if (self.gstype == SSGameScoreTypeGunqiu) {
        parm = @{@"object":@"eyJjb3VudFBlclBhZ2UiOjIwLCJzZW5kVHlwZSI6IjQiLCJpc1BhZ2UiOiIyIiwibGVhZ3VlSWRzIjpudWxsLCJwYWdlTm8iOjF9",
                 @"sign":@"1368ec3f877e033398aa2aa2ff0c9fd7"
                 };
    } else if (self.gstype == SSGameScoreTypeJishi) {
        parm = @{@"object":@"eyJjb3VudFBlclBhZ2UiOjIwLCJzZW5kVHlwZSI6IjEiLCJpc1BhZ2UiOiIyIiwibGVhZ3VlSWRzIjpudWxsLCJwYWdlTm8iOjF9",
                 @"sign":@"ec9bfc3be755aced4825c9a4f03c506c"
                 };
    } else if (self.gstype == SSGameScoreTypeWanchang) {
        parm = @{@"object":@"eyJjb3VudFBlclBhZ2UiOjIwLCJzZW5kVHlwZSI6IjIiLCJpc1BhZ2UiOiIyIiwiZml4RGF5cyI6MCwibGVhZ3VlSWRzIjpudWxsLCJwYWdlTm8iOjF9",
                 @"sign":@"468a9fe586393de9f26cf3f2af618618"
                 };
    } else {
        parm = @{@"object":@"eyJjb3VudFBlclBhZ2UiOjIwLCJzZW5kVHlwZSI6IjMiLCJpc1BhZ2UiOiIyIiwiZml4RGF5cyI6MywibGVhZ3VlSWRzIjpudWxsLCJwYWdlTm8iOjF9",
                 @"sign":@"7d8fc0c64d42585ba922200ab4f4e4ad"
                 };
    }
    
    [[NTNetManager sharedManager] postDataWithType:NTRequestTypeGamesScoreList parameters:parm success:^(NSArray *dictArr) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSArray *objcArr = [SSGamescoreModel mj_objectArrayWithKeyValuesArray:dictArr];
        self.objcArr = objcArr;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
        
        // 根据数据类型改文件名 -> 保存缓存
        NSString *filePath;
        if (self.gstype == SSGameScoreTypeGunqiu) {
            filePath = [kCachePath stringByAppendingPathComponent:@"gunqiu.plist"];
        } else if (self.gstype == SSGameScoreTypeJishi) {
            filePath = [kCachePath stringByAppendingPathComponent:@"jishi.plist"];
        } else if (self.gstype == SSGameScoreTypeWanchang) {
            filePath = [kCachePath stringByAppendingPathComponent:@"wanchang.plist"];
        } else {
            filePath = [kCachePath stringByAppendingPathComponent:@"saicheng.plist"];
        }
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        if ([fileMgr fileExistsAtPath:filePath]) {
            [fileMgr createFileAtPath:filePath contents:nil attributes:nil];
        }
        [NSKeyedArchiver archiveRootObject:objcArr toFile:filePath];
        
        
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:@"网络错误 稍后尝试" toView:self.view];
        
        
        // 获取缓存的数据
        NSString *filePath;
        if (self.gstype == SSGameScoreTypeGunqiu) {
            filePath = [kCachePath stringByAppendingPathComponent:@"gunqiu.plist"];
        } else if (self.gstype == SSGameScoreTypeJishi) {
            filePath = [kCachePath stringByAppendingPathComponent:@"jishi.plist"];
        } else if (self.gstype == SSGameScoreTypeWanchang) {
            filePath = [kCachePath stringByAppendingPathComponent:@"wanchang.plist"];
        } else {
            filePath = [kCachePath stringByAppendingPathComponent:@"saicheng.plist"];
        }
        self.objcArr = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        [self.tableView reloadData];
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objcArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 128;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSGamescoreGunqiuCell *cell = [tableView dequeueReusableCellWithIdentifier:kGunqiuCell forIndexPath:indexPath];
    cell.model = self.objcArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SSGamescoreModel *model = self.objcArr[indexPath.row];
//    SSGameScoreAnalyseViewController *aVc = [[SSGameScoreAnalyseViewController alloc] initWithNibName:@"SSGameScoreAnalyseViewController" matchId:model.matchId];
    SSGameScoreAnalyseViewController *aVc = [[SSGameScoreAnalyseViewController alloc] initWithNibName:@"SSGameScoreAnalyseViewController" bundle:nil];
    aVc.model = model;
    [self.navigationController pushViewController:aVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.gstype == SSGameScoreTypeGunqiu || self.gstype == SSGameScoreTypeJishi) {
        return 0;
    } else {
        return 30;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.gstype == SSGameScoreTypeGunqiu || self.gstype == SSGameScoreTypeJishi) {
        return nil;
    }
    SSGamescoreDateHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SSGamescoreDateHeader"];
    if (self.gstype == SSGameScoreTypeWanchang) {
        header.isWanchang = YES;
    } else if (self.gstype == SSGameScoreTypeSaicheng) {
        header.isWanchang = NO;
    }
    return header;
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
