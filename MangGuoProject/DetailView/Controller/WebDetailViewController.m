//
//  WebDetailViewController.m
//  MangGuoProject
//
//  Created by lijunjie on 2017/6/23.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "WebDetailViewController.h"
#import "WebViewJS.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
@interface WebDetailViewController ()<BackBtnDelegate,UIWebViewDelegate,WebViewJSDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong) UIWebView *webview;
@property (nonatomic,strong) UINavigationItem * navigationBarTitle;
@property(nonatomic, strong) WebViewJS *WebviewJs;
@property(nonatomic,strong)UIButton *bigBackBtn;

@end

@implementation WebDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [ZZLProgressHUD showHUDWithMessage:@"正在加载"];
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0,0, kScreen_Width, kScreen_Height)];
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
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 20)];
    statusBarView.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:statusBarView];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.rdv_tabBarController setTabBarHidden:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//{
//    return YES;
//}
-(void)gobackJS{
    if ([self.webview canGoBack]) {
        if ([self.title isEqualToString:@"添加果园"]||[self.title isEqualToString:@"我的订购"]) {
            [self.navigationController popViewControllerAnimated:NO];
        }else{
            [self.webview goBack];
        }
    }else{
        [self.navigationController popViewControllerAnimated:NO];
    }
    
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
-(void)goback{
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"toSencondCtr" object:nil];
    if ([self.webview canGoBack]) {
        if ([self.title isEqualToString:@"添加果园"]) {
            [self dismissViewControllerAnimated:NO completion:nil];
        }else{
            [self.webview goBack];
        }
    }else{
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}
-(UIButton *)SetShareBtn
{
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    btn.imageEdgeInsets=UIEdgeInsetsMake(2, 2, 2, 2);
    [btn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [btn addTarget:self action:@selector(showShareView) forControlEvents:UIControlEventTouchUpInside];
    return btn;
    
}
-(void)showShareView{

        UIButton *bigBackBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, -20, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height+64+20)];
        //bigBackBtn.backgroundColor=[UIColor colorWithColor:[UIColor blackColor] alpha:0.4];
        bigBackBtn.backgroundColor=[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
        self.bigBackBtn=bigBackBtn;
        [self.navigationController.view addSubview:bigBackBtn];
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
            shareLabel.font=[UIFont systemFontOfSize:15];
            shareLabel.text=titleArray[i];
            shareLabel.textAlignment=NSTextAlignmentCenter;
            [bgView addSubview:shareLabel];
        }
    UIView *sepview=[[UIView alloc]initWithFrame:CGRectMake(0, 148, kScreen_Width, 1)];
    sepview.backgroundColor=[UIColor colorWithHexString:@"f1f1f1"];
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

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //判断是否是单击
//    if (navigationType == UIWebViewNavigationTypeLinkClicked)
//    {
//        NSURL *url = [request URL];
//        CustomWebViewController *cv=[[CustomWebViewController alloc]init];
//        cv.webUrl=[url absoluteString];
////        
//        [self presentViewController:cv animated:NO
//                         completion:nil];
//    //     [self dismissViewControllerAnimated:YES completion:nil];
////        [self.navigationController pushViewController:cv animated:NO];
//        return NO;
//    }
    return YES;
    
}

-(void)clickEmpt
{
    [self.bigBackBtn removeFromSuperview];
}

@end
