//
//  CustomWebViewController.m
//  MangGuoProject
//
//  Created by lijunjie on 2017/6/22.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "CustomWebViewController.h"
#import "WebViewJS.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "StatuBarWebViewController.h"
@interface CustomWebViewController ()<BackBtnDelegate,UIWebViewDelegate,WebViewJSDelegate,UIScrollViewDelegate>
@property (nonatomic,strong) UIWebView *webview;
@property (nonatomic,strong) UINavigationItem * navigationBarTitle;
@property(nonatomic, strong) WebViewJS *WebviewJs;
@property(nonatomic,strong)UIButton *bigBackBtn;
@property(nonatomic,strong)UIView *statusBarView;
@end

@implementation CustomWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 20)];
    _statusBarView=statusBarView;
    [self.view addSubview:statusBarView];
    BackBtn *backbtn=[[BackBtn alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    backbtn.delegate=self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backbtn];
    //[ZZLProgressHUD showHUDWithMessage:@"正在加载"];
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0,20, kScreen_Width, kScreen_Height-20)];
    _webview=webview;
    webview.scrollView.delegate=self;
    webview.scrollView.bounces=NO;
    webview.scrollView.contentSize =  CGSizeMake(kScreen_Width, 0);
 //   webview.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
 //   webview.scalesPageToFit = YES;
    webview.backgroundColor = [UIColor whiteColor];
    NSURL *url=[NSURL URLWithString:self.webUrl];
    [webview loadRequest:[NSURLRequest requestWithURL:url]];
    webview.allowsInlineMediaPlayback = YES;
//    webview.mediaPlaybackRequiresUserAction = NO;
    webview.delegate=self;
    self.WebviewJs = [[WebViewJS alloc] init];
    self.WebviewJs.delegate = self;
    [self.view addSubview:webview];

}
- (void) keyboardWillShow : (NSNotification*)notification {
    NSLog(@"123");
    _webview.scrollView.bounces=NO;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
   
     [self.view endEditing:YES];
}
-(UIView*)viewForZoomingInScrollView:(UIScrollView*)scrollView
{
    return nil;
}
-(void)gonavJS:(NSString *)url{
    NSLog(@"url:%@",url);
    StatuBarWebViewController *webVC=[[StatuBarWebViewController alloc]init];
    webVC.webUrl=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]; // UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:webVC];
    [self presentViewController:webVC animated:NO completion:nil];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    //[ZZLProgressHUD popHUD];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
   // [ZZLProgressHUD popHUD];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];

    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if ([self.title isEqualToString:@"搜索"]) {
        _statusBarView.backgroundColor=[UIColor colorWithHexString:@"0xfac600"];
    }else{
        _statusBarView.backgroundColor=[UIColor whiteColor];
    }
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"obj"]=self.WebviewJs;
}
//-(void)goback{
////    [[NSNotificationCenter defaultCenter] postNotificationName:@"toSencondCtr" object:nil];
//    if ([self.webview canGoBack]) {
//        [self.webview goBack];
//    }else{
//        [self dismissViewControllerAnimated:NO completion:nil];
//    }
//}
-(void)cancelJS{
    if ([self.webview canGoBack]) {
        [self.webview goBack];
    }else{
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}
-(void)subokJS:(NSString *)result{
    NSLog(@"%@",result);
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.delegate pubresult:result];
     [[NSNotificationCenter defaultCenter] postNotificationName:@"pubfresh" object:self userInfo:nil];
}
-(void)gobackJS{
    
    if ([self.webview canGoBack]) {
        if ([self.title isEqualToString:@"产地分布"]) {
             [self dismissViewControllerAnimated:NO completion:nil];
        }else{
            [self.webview goBack];
        }
    }else{
        [self dismissViewControllerAnimated:NO completion:nil];
    }

}
-(void)shareJS:(NSString *)shareImg andParem2:(NSString *)shareTitle andParam3:(NSString *)shareContent andParam4:(NSString *)shareUrl
{
    self.shareImg=shareImg;
    self.shareTitle=shareTitle;
    self.shareContent=shareContent;
    self.shareURL=shareUrl;
    [self showShareView];
}
-(void)showShareView{
    
    UIButton *bigBackBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, -20, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height+64+20)];
    //bigBackBtn.backgroundColor=[UIColor colorWithColor:[UIColor blackColor] alpha:0.4];
    bigBackBtn.backgroundColor=[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
    self.bigBackBtn=bigBackBtn;
    [self.webview addSubview:bigBackBtn];
    [bigBackBtn addTarget:self action:@selector(clickEmpt) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *bgView = [[UIView alloc]init];
    bgView.userInteractionEnabled=YES;
    bgView.backgroundColor=[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [bigBackBtn addSubview:bgView];
    bgView.frame=CGRectMake(0, kScreen_Height-200, kScreen_Width, 200);
    
    
    for (int i=0; i<4; i++) {
        UIButton *shareBtn=[[UIButton alloc]init];
        NSArray *imageArray=@[@"weixin",@"pengyouquan",@"weibo",@"qq"];
        NSArray *titleArray=@[@"好友",@"朋友圈",@"微博",@"QQ"];
        shareBtn.tag=i;
        [shareBtn setBackgroundImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [shareBtn addTarget:self action:@selector(shareCliCk:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:shareBtn];
        CGFloat btnwidth=(kScreen_Width-150)/4;
        shareBtn.frame=CGRectMake(30+(btnwidth+30)*i, 30, btnwidth, btnwidth);
        
        
        
        UILabel *shareLabel=[[UILabel alloc]initWithFrame:CGRectMake(30+(btnwidth+30)*i, 40+btnwidth, btnwidth, 20)];
        shareLabel.font=[UIFont systemFontOfSize:13];
        shareLabel.text=titleArray[i];
        shareLabel.textAlignment=NSTextAlignmentCenter;
        [bgView addSubview:shareLabel];
    }
    UIView *sepview=[[UIView alloc]initWithFrame:CGRectMake(0, 148, kScreen_Width, 1)];
    sepview.backgroundColor=[UIColor colorWithHexString:@"dfdfdf"];
    [bgView addSubview:sepview];
    UIButton *cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 150,kScreen_Width , 50)];
    [cancelBtn setTitle:@"取消分享" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(clickEmpt) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:cancelBtn];
}

-(void)shareCliCk:(UIButton *)sender{
    [self.bigBackBtn removeFromSuperview];
    SSDKPlatformType sharetype=SSDKPlatformTypeUnknown;
    if (sender.tag==0) {
        sharetype=SSDKPlatformSubTypeWechatSession;
    }else if(sender.tag==1){
        sharetype=SSDKPlatformSubTypeWechatTimeline;
    }else if(sender.tag==2){
        sharetype=SSDKPlatformTypeSinaWeibo;
    }else{
        sharetype=SSDKPlatformSubTypeQQFriend;
    }
    UIImage *image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.shareImg]]];
    NSArray *imgArr=@[image];
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:self.shareContent
                                     images:imgArr
                                        url:[NSURL URLWithString:self.webUrl]
                                      title:self.shareTitle
                                       type:SSDKContentTypeAuto];
    [ShareSDK share:sharetype
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error)
     {
         switch (state) {
             case SSDKResponseStateSuccess:
             {
                 NSLog(@"分享成功");
                 break;
             }
             case SSDKResponseStateFail:
             {
                 NSLog(@"分享失败");
                 break;
             }
             case SSDKResponseStateCancel:
             {
                 NSLog(@"分享取消");
                 break;
             }
             default:
                 break;
         }}];
}

-(void)clickEmpt
{
    [self.bigBackBtn removeFromSuperview];
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
