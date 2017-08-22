//
//  EatNativeWebViewController.m
//  MangGuoProject
//
//  Created by lijunjie on 2017/8/12.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "EatNativeWebViewController.h"

@interface EatNativeWebViewController ()<BackBtnDelegate,UIWebViewDelegate>
@property(nonatomic,strong)NSString *webDetail;
@property(nonatomic,strong)UIWebView *webview;
@end

@implementation EatNativeWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BackBtn *backbtn=[[BackBtn alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    backbtn.delegate=self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backbtn];
    UIWebView* webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64)];
    self.webview=webView;
    webView.delegate=self;
    [self.view addSubview:webView];
    
    webView.backgroundColor = [UIColor clearColor];
    webView.allowsInlineMediaPlayback = YES;
    webView.mediaPlaybackRequiresUserAction = YES;
    [self getData];
    
}
-(void)goback{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.rdv_tabBarController setTabBarHidden:YES];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    
    
    //获取网页的标题
    self.title = [self.webview stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    //    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //    //调用js
    //    context[@"pnr"]=self.WebviewJs;
    
    
}

-(void)getData{
    
    NSString *path = @"http://mgsl.zilankeji.com/H5/detail/eat_detailai";
    
    //路径-+参数
    NSString *pathWithPhoneNum = [NSString stringWithFormat:@"%@?eid=%@",path,self.news_id];
    
    //中文编码
    NSString *urlPath = [pathWithPhoneNum stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    //URL
    NSURL *phoneURL = [NSURL URLWithString:urlPath];
    
    //请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:phoneURL];
    
    //请求方式
    [request setHTTPMethod:@"GET"];
    
    //    //请求头
    //    [request setValue:@"92b5787ecd17417b718a2aaedc7e6ce8" forHTTPHeaderField:@"apix-key"];
    
    //网络配置
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //网络会话
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    //任务
    NSURLSessionDataTask *sessionTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //回到主线程更新UI -> 撤销遮罩
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
        
        if (error) {
            
        }else{
            
            NSString *dataStr =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            _webDetail=dataStr;
            [self.webview loadHTMLString:self.webDetail baseURL:nil];
        }
    }];
    
    //开始任务
    [sessionTask resume];
    
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
