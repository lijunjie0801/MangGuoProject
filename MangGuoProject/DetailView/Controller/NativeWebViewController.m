//
//  NativeWebViewController.m
//  MangGuoProject
//
//  Created by lijunjie on 2017/8/11.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "NativeWebViewController.h"
#import "YcKeyBoardView.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "WebViewJS.h"
@interface NativeWebViewController ()<BackBtnDelegate,UIWebViewDelegate,YcKeyBoardViewDelegate,WebViewJSDelegate>{
    NSString *replyType;
}
@property(nonatomic,strong)NSString *webDetail,*replyId;
@property(nonatomic,strong)UIWebView *webview;
@property(nonatomic,strong)UIView *bottomview;
@property (nonatomic,strong)YcKeyBoardView *key;
@property (nonatomic,strong)NSDictionary *jsonDict;
@property(nonatomic, strong) WebViewJS *WebviewJs;
@end

@implementation NativeWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BackBtn *backbtn=[[BackBtn alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    backbtn.delegate=self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backbtn];
    UIWebView* webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64-10)];
    self.webview=webView;
    webView.delegate=self;
    [self.view addSubview:webView];
    
    webView.backgroundColor = [UIColor clearColor];
    webView.allowsInlineMediaPlayback = YES;
    webView.mediaPlaybackRequiresUserAction = YES;
    self.webview.userInteractionEnabled=YES;
    [self getData];
    self.WebviewJs = [[WebViewJS alloc] init];
    self.WebviewJs.delegate = self;

   // [self setbottomview];

}
-(void)goback{
    [self.navigationController popViewControllerAnimated:NO];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.rdv_tabBarController setTabBarHidden:YES];
}
//-(void)webViewDidFinishLoad:(UIWebView *)webView
//{
//  //  [_weakProgressHUD hide:YES];
//    
//    // 禁止了弹出复制、粘贴功能
//    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
//    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
//    
//    
//    //获取网页的标题
//   // self.title = [self.webview stringByEvaluatingJavaScriptFromString:@"document.title"];
//      JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    //调用js
//    context[@"pnr"]=self.webview;
//    
//    
//}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
//    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];

    
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"obj"]=self.WebviewJs;

}
-(void)replyJS:(NSString *)replyId{
    _replyId=replyId;
    [self startReply];
}
-(void)viewWillDisappear:(BOOL)animated{
    [_bottomview removeFromSuperview];
    [_key removeFromSuperview];
}
-(void)setbottomview{
    // self.webview.userInteractionEnabled=YES;
    _bottomview=[[UIView alloc]initWithFrame:CGRectMake(0, kScreen_Height-46, kScreen_Width, 46)];
    _bottomview.backgroundColor= [UIColor colorWithRed:245/255.0 green:245/255.0 blue:244/255.0 alpha:1.0];
    [self.navigationController.view addSubview:_bottomview];
    // bottomview.userInteractionEnabled=NO;
    UIButton *replybtn=[[UIButton alloc]initWithFrame:CGRectMake(15, 7.5, kScreen_Width*2/3, 31)];
    [_bottomview addSubview:replybtn];
    replybtn.backgroundColor=[UIColor whiteColor];
    [replybtn setTitle:@"  写评论..." forState:UIControlStateNormal];
    [replybtn addTarget:self action:@selector(startComment) forControlEvents:UIControlEventTouchUpInside];
    [replybtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    replybtn.contentHorizontalAlignment=1;
    replybtn.layer.borderWidth=1.0;
    replybtn.layer.cornerRadius=7;
    replybtn.layer.borderColor= [UIColor colorWithHexString:@"0xeeeeee"].CGColor;
    
    UILabel *lb=[[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width*2/3+15, 0, kScreen_Width-(kScreen_Width*2/3+15), 46)];
    lb.text=@"发表";
    lb.textAlignment=NSTextAlignmentCenter;
    lb.textColor=[UIColor grayColor];
    [_bottomview addSubview:lb];
    

}
-(void)startComment{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    if(self.key==nil){
        self.key=[[YcKeyBoardView alloc]initWithFrame:CGRectMake(0, kScreen_Height-44, kScreen_Width, 44)];
        
    }
    replyType=@"0";
    self.key.delegate=self;
    [self.key.textView becomeFirstResponder];
    [self.rdv_tabBarController.view addSubview:self.key];
}
-(void)startReply{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    if(self.key==nil){
        self.key=[[YcKeyBoardView alloc]initWithFrame:CGRectMake(0, kScreen_Height-44, kScreen_Width, 44)];
        
    }
    replyType=@"1";
    self.key.delegate=self;
    [self.key.textView becomeFirstResponder];
    [self.rdv_tabBarController.view addSubview:self.key];
}
-(void)keyboardShow:(NSNotification *)note
{
    if ([replyType integerValue]==0) {
        self.key.label.text=@"请输入评论内容";
    }else{
        self.key.label.text=@"请输入回复内容";
    }
    
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat deltaY=keyBoardRect.size.height;
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        
        self.key.transform=CGAffineTransformMakeTranslation(0, -deltaY);
    }];
}
-(void)keyboardHide:(NSNotification *)note
{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        
        self.key.transform=CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
        self.key.textView.text=@"";
        [self.key removeFromSuperview];
    }];
    
}
-(void)keyBoardViewHide:(YcKeyBoardView *)keyBoardView textView:(UITextView *)contentView
{
    
    [contentView resignFirstResponder];
   //    [self.webview reload];
//    if ([self.commentType isEqualToString:@"1"]) {
//        [self classReply:contentView.text];
//    }else{
//        [self commentReply:contentView.text];
//    }
    
}
-(void)getData{

    NSString *path =[NSString stringWithFormat:@"http://mgsl.zilankeji.com/H5/detail/%@",self.urlLeft] ;
    
    if ([self.urlLeft isEqualToString:@"meettings"]) {
        self.title=@"大会活动详情";
        [self setbottomview];
    }
    if ([self.urlLeft isEqualToString:@"around_detailai"]) {
        self.title=@"田东旅游详情";
    }
    if ([self.urlLeft isEqualToString:@"technology_detailai"]) {
        self.title=@"种植技术详情";
    }
    if ([self.urlLeft isEqualToString:@"eat_detailai"]) {
        self.title=@"吃法大全详情";
    }

    //路径-+参数
    NSString *pathWithPhoneNum = [NSString stringWithFormat:@"%@?%@=%@",path,self.urlRight,self.news_id];
    
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
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            _jsonDict=jsonDict;
           
           [self.webview loadHTMLString:jsonDict[@"str"] baseURL:nil];
        }
    }];
    
    //开始任务
    [sessionTask resume];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)sendClassComment{
    NSLog(@"%@",self.key.textView.text);
    if (self.key.textView.text.length==0) {
        [JRToast showWithText:@"内容不能为空" duration:2.0];
        return;
    }
    [self.key removeFromSuperview];
    if ([replyType integerValue]==0) {

        [kNetManager submitComent:[DEFAULTS objectForKey:@"userId"] news_id:self.news_id content:self.key.textView.text Success:^(id responseObject) {
            NSLog(@"submit:%@",responseObject);
            if ([responseObject[@"status"] integerValue]==100) {
                [JRToast showWithText:@"评论成功" duration:1.0];
                [self getData];

            }
        } Failure:^(NSError *error) {
        
        }];
    }else{
        [kNetManager replyComment:[DEFAULTS objectForKey:@"userId"] news_id:self.news_id  content:self.key.textView.text f_id:_replyId Success:^(id responseObject) {
            [JRToast showWithText:@"回复成功" duration:1.0];
            [self getData];

        } Failure:^(NSError *error) {
            
        }];
    }
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
