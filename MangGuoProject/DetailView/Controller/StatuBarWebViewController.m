//
//  StatuBarWebViewController.m
//  MangGuoProject
//
//  Created by lijunjie on 2017/6/28.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "StatuBarWebViewController.h"
#import "WebViewJS.h"
@interface StatuBarWebViewController ()<BackBtnDelegate,UIWebViewDelegate,WebViewJSDelegate>
@property (nonatomic,strong) UIWebView *webview;
@property (nonatomic,strong) UINavigationItem * navigationBarTitle;
@property(nonatomic, strong) WebViewJS *WebviewJs;
@property(nonatomic,strong)UIButton *bigBackBtn;

@end

@implementation StatuBarWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [ZZLProgressHUD showHUDWithMessage:@"正在加载"];
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0,20, kScreen_Width, kScreen_Height-20)];
    _webview=webview;
    webview.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    webview.scalesPageToFit = YES;
    webview.backgroundColor = [UIColor whiteColor];
    NSURL *url=[NSURL URLWithString:self.webUrl];
    [webview loadRequest:[NSURLRequest requestWithURL:url]];
    webview.allowsInlineMediaPlayback = YES;
    webview.mediaPlaybackRequiresUserAction = NO;
    webview.delegate=self;
    self.WebviewJs = [[WebViewJS alloc] init];
    self.WebviewJs.delegate = self;
    [self.view addSubview:webview];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [ZZLProgressHUD popHUD];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [ZZLProgressHUD popHUD];
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"obj"]=self.WebviewJs;
}
-(void)gobackJS{
    if ([self.webview canGoBack]) {
        [self.webview goBack];
    }else{
        [self dismissViewControllerAnimated:NO completion:nil];
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
