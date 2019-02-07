//
//  SSInformationTableViewController.m
//  SoccerScore
//
//  Created by 大雄 on 2018/6/28.
//  Copyright © 2018年 大雄. All rights reserved.
//

#import "SSInformationTableViewController.h"
#import "SSInformationListCell.h"
#import "SSInformationModel.h"
#import <MJRefresh.h>
#import "ArticalDetailViewController.h"

#define kArticalSJB_Id      @"T1521013416394"
#define kArticalSport_id    @"T1348649079062"
#define kArticalYule_Id     @"T1348648517839"
#define kArticalNBA_Id      @"T1348649145984"
#define kInfoCell           @"SSInformationListCell"

@interface SSInformationTableViewController ()
{
    NSInteger _offset;
}
@property (nonatomic, strong) NSArray *objcArr;
@end

@implementation SSInformationTableViewController

- (instancetype)initWithType:(SSInfoType)type{
    self = [super init];
    self.iftype = type;
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(5, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [AppUtils lightGrayBgColor];
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:kInfoCell bundle:nil] forCellReuseIdentifier:kInfoCell];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self->_offset = 0;
        [self requestDataReloadWithOffset:0];
    }];
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        [self requestDataReloadWithOffset:self->_offset];
    }];
    
    [self.tableView.mj_header beginRefreshing];
}

// 获取TimeStamp
- (NSString *)currentTimeStr{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
//    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSTimeInterval time = [date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

// 刷新数据
- (void)requestDataReloadWithOffset:(NSInteger)offset{
    // 设置参数
    NSDictionary *parm;
//    NSString *timeStr = [[self currentTimeStr] substringToIndex:10];
    if (self.iftype == SSInfoTypeWorldCup) {
        parm = @{@"tid":kArticalSJB_Id,
                 @"from":kArticalSJB_Id,
                 @"passport":@"",
                 @"devId":@"Jd%2FzsrzB10102GBfQT5tSpscU1sMaTUAGei6ZbVPjoS94eqswG28dP%2BiO4J6zNTT",
                 @"version":@"37.2",
                 @"spever":@"false",
                 @"net":@"wifi",
                 @"lat":@"",
                 @"lon":@"",
                 @"ts":[self currentTimeStr],
                 @"sign":@"wrsnJndsTMxW5BUiWYRsU0%2BLzhpWP7NIKMG0f1KWQph48ErR02zJ6%2FKXOnxX046I",
                 @"encryption":@"1",
                 @"canal":@"appstore",
                 @"offset":@(offset),
                 @"size":@10,
                 @"fn":@"1"};
    } else if (self.iftype == SSInfoTypeSport) {
        parm = @{@"tid":kArticalSport_id,
                 @"from":kArticalSport_id,
                 @"passport":@"",
                 @"devId":@"Jd%2FzsrzB10102GBfQT5tSpscU1sMaTUAGei6ZbVPjoS94eqswG28dP%2BiO4J6zNTT",
                 @"version":@"37.2",
                 @"spever":@"false",
                 @"net":@"wifi",
                 @"lat":@"",
                 @"lon":@"",
                 @"ts":[self currentTimeStr],
                 @"sign":@"wrsnJndsTMxW5BUiWYRsU0%2BLzhpWP7NIKMG0f1KWQph48ErR02zJ6%2FKXOnxX046I",
                 @"encryption":@"1",
                 @"canal":@"appstore",
                 @"offset":@(offset),
                 @"size":@10,
                 @"fn":@"1"};
    } else if (self.iftype == SSInfoTypeYule) {
        parm = @{@"tid":kArticalYule_Id,
                 @"from":kArticalYule_Id,
                 @"passport":@"",
                 @"devId":@"Jd%2FzsrzB10102GBfQT5tSpscU1sMaTUAGei6ZbVPjoS94eqswG28dP%2BiO4J6zNTT",
                 @"version":@"37.2",
                 @"spever":@"false",
                 @"net":@"wifi",
                 @"lat":@"",
                 @"lon":@"",
                 @"ts":[self currentTimeStr],
                 @"sign":@"wrsnJndsTMxW5BUiWYRsU0%2BLzhpWP7NIKMG0f1KWQph48ErR02zJ6%2FKXOnxX046I",
                 @"encryption":@"1",
                 @"canal":@"appstore",
                 @"offset":@(offset),
                 @"size":@10,
                 @"fn":@"1"};
    } else {
        parm = @{@"from":kArticalNBA_Id,
                 @"passport":@"",
                 @"devId":@"Jd%2FzsrzB10102GBfQT5tSpscU1sMaTUAGei6ZbVPjoS94eqswG28dP%2BiO4J6zNTT",
                 @"version":@"37.2",
                 @"spever":@"false",
                 @"net":@"wifi",
                 @"lat":@"",
                 @"lon":@"",
                 @"ts":[self currentTimeStr],
                 @"sign":@"I9HkA9qcddNlIswxV%2B5Kg59pc4drtXjH%2BqHISjd4CNd48ErR02zJ6%2FKXOnxX046I",
                 @"encryption":@"1",
                 @"canal":@"appstore",
                 @"offset":@(offset),
                 @"size":@10,
                 @"fn":@"1"};
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    NTRequestType reqType;
    if (self.iftype == SSInfoTypeNBA) {
        // NBA 新闻URL不同
        reqType = NTRequestTypeMycmNewsList;
    } else {
        reqType = NTRequestTypeMyNewsList;
    }
    [[NTNetManager sharedManager] getDataWithType:reqType parameters:parm success:^(NSDictionary *objDict) {
        self->_offset += 10;
        NSMutableArray *responseArr = @[].mutableCopy;  //筛选后数组
        if (self.iftype == SSInfoTypeWorldCup) {
            // 根据文章类型不同获取不同文章
            responseArr = [objDict objectForKey:kArticalSJB_Id];
        } else if (self.iftype == SSInfoTypeSport) {
            responseArr = [objDict objectForKey:kArticalSport_id];
        } else if (self.iftype == SSInfoTypeYule){
            responseArr = [objDict objectForKey:kArticalYule_Id];
        } else {
            responseArr = [objDict objectForKey:kArticalNBA_Id];
        }
        
        NSMutableArray *processArr = [NSMutableArray array];
        for (NSDictionary *dict in responseArr) {
            SSInformationModel *model = [SSInformationModel mj_objectWithKeyValues:dict];
            // 筛选数据
            if (model.digest.length == 0) {
                continue;
            }
            if (model.skipType.length !=0 ) {
                continue;
            }
            if ([model.title containsString:@"预测"] || [model.title containsString:@"投注"]) {
                continue;
            }
            NSString *digestStr = model.digest;
            digestStr = [digestStr stringByReplacingOccurrencesOfString:@"网易" withString:@"本站"];
            model.digest = digestStr;
            [processArr addObject:model];
        }
        if (self->_offset > 10) {
            self.objcArr = [self.objcArr arrayByAddingObjectsFromArray:processArr.copy];
        } else {
            self.objcArr = processArr;
        }
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error.localizedDescription);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:@"网络错误 稍后尝试" toView:self.view];
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSInformationListCell *cell = [tableView dequeueReusableCellWithIdentifier:kInfoCell forIndexPath:indexPath];
    cell.model = self.objcArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 232;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ArticalDetailViewController *detailVc = [[ArticalDetailViewController alloc] init];
    SSInformationModel * model = self.objcArr[indexPath.row];
    detailVc.docid = model.docid;
    [self.navigationController pushViewController:detailVc animated:YES];
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
