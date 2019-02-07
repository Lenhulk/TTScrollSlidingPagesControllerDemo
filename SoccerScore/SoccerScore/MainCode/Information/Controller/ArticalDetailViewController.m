//
//  ArticalDetailViewController.m
//  k3
//
//  Created by Neo on 2018/2/5.
//  Copyright © 2018年 Neo. All rights reserved.
//

#import "ArticalDetailViewController.h"
#import <AFNetworking.h>

@interface ArticalDetailViewController () <UIWebViewDelegate>
@property (nonatomic, weak) UIWebView *webView;
@end

@implementation ArticalDetailViewController


- (void)setDocid:(NSString *)docid{
    _docid = docid;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"新闻详情";

    
    NSString *urlStr = @"http://c.m.163.com/nc/article/<ID>/full.html";
    urlStr = [urlStr stringByReplacingOccurrencesOfString:@"<ID>" withString:self.docid];

//    [NSURLRequest allowsAnyHTTPSCertificateForHost:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];

    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//                NTLog(@"%@", dict);
            [self dealWithArticalDictionary:dict];
        } else {
            NTLog(@"ERROR=%@", error.localizedDescription);
        }
    }];
    [dataTask resume];

}

- (void)dealWithArticalDictionary:(NSDictionary *)dict{

    NSString *path = [[NSBundle mainBundle] bundlePath];
    path = [path stringByAppendingString:@"/"];
    NSURL *baseUrl = [NSURL URLWithString:path];

    NSDictionary *artDic = dict[self.docid];
    NSString *title = artDic[@"title"];
    NSString *body = artDic[@"body"];
    body = [body stringByReplacingOccurrencesOfString:@"网易" withString:@"本站记者挖"];
    NSString *ptime = artDic[@"ptime"];
    NSArray *imgs = artDic[@"img"];
    for (NSDictionary *imgD in imgs) {
        // 替换图片
        NSString *ref = imgD[@"ref"];
        NSString *src = imgD[@"src"];
        NSString *alt = imgD[@"alt"];
        NSString *imgHtml = [NSString stringWithFormat:@"<div class=\"img\" style='text-align:center;'><img style='width:90%%; height:auto; margin:0 auto;' src='%@'><p style='color:grey; font-size:13px;'>%@</p></img></div>", src, alt];
        body = [body stringByReplacingOccurrencesOfString:ref withString:imgHtml];
    }
    NSString *titleHtml = [NSString stringWithFormat:@"<div class=\"mainTitle\">%@</div>", title];
    NSString *ptimeHtml = [NSString stringWithFormat:@"<div class=\"publishTime\">%@</div>", ptime];
    //引入外部文件
//    NSString *cssPath = [[NSBundle mainBundle] pathForResource:@"newsDetail" ofType:@"css"];  //TIPS:必须是URL不是PATH
    NSURL *cssUrl = [[NSBundle mainBundle] URLForResource:@"newsDetail" withExtension:@"css"];
    NSString *cssHtml = [NSString stringWithFormat:@"<link href=\"%@\" rel=\"stylesheet\">", cssUrl];
//    NSURL *jsUrl = [[NSBundle mainBundle] URLForResource:@"newsDetail" withExtension:@"js"];
//    NSString *jsHtml = [NSString stringWithFormat:@"<script src=\"%@\"></script>", jsUrl];

    NSString *html = [NSString stringWithFormat:@"<html><head>%@</head><body style='font-family: arial;'>%@%@%@</body></html>", cssHtml, titleHtml, ptimeHtml, body];

    dispatch_async(dispatch_get_main_queue(), ^{
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_W, kSCREEN_H-kAPPTOPS_H)];
        webView.backgroundColor = [UIColor whiteColor];
        webView.dataDetectorTypes = UIDataDetectorTypeNone;
        webView.delegate = self;
        [self.view addSubview:webView];
        self.webView = webView;
        [webView loadHTMLString:html baseURL:baseUrl];
    });

}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
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
