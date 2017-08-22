//
//  SecondViewController.m
//  MangGuoProject
//
//  Created by lijunjie on 2017/6/13.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "SecondViewController.h"
#import "UIViewAdditions.h"
#import "SencondDetailViewController.h"
#import "SendOtherViewController.h"
#import "LoginViewController.h"
@interface SecondViewController ()<HomeViewCellDelegate,sendOtherDelegate,webdelegate>
@property (nonatomic, strong) NSMutableArray *allVC;
@property (nonatomic, strong) SMPagerTabView *segmentView;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    self.view.backgroundColor = [UIColor whiteColor];
    _allVC = [NSMutableArray array];
    SencondDetailViewController *sv=[[SencondDetailViewController alloc]init];
    sv.delegate=self;
    sv.title=@"采摘计划";
    sv.type=@"0";
    [_allVC addObject:sv];

    SendOtherViewController *sv1=[[SendOtherViewController alloc]init];
    sv1.delegate=self;
    sv1.title=@"采摘通告";
    [_allVC addObject:sv1];

    self.segmentView.delegate = self;
    [_segmentView buildUI];
    [_segmentView.pubbtn setHidden:YES];
    
       [_segmentView selectTabWithIndex:0 animate:NO];
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
     NSString *role=[DEFAULTS objectForKey:@"role"];
    if([role integerValue]==4||[role integerValue]==6){
        [_segmentView.pubbtn setTitleColor:[UIColor colorWithHexString:@"0x8fce47"] forState:UIControlStateNormal];
        _segmentView.pubbtn.userInteractionEnabled=YES;
        
    }else{
        [_segmentView.pubbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _segmentView.pubbtn.userInteractionEnabled=NO;
    }
    [self.rdv_tabBarController setTabBarHidden:NO];
    

}
-(void)toweb:(NSString *)weburl{
    CustomWebViewController *webVC=[[CustomWebViewController alloc]init];
    webVC.webUrl=weburl;
   // UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:webVC];
    [self presentViewController:webVC animated:NO completion:nil];
}
-(void)towebview:(NSString *)weburl :(NSMutableDictionary *)dic{
    CustomWebViewController *webVC=[[CustomWebViewController alloc]init];
    webVC.webUrl=weburl;
//    UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:webVC];
    [self presentViewController:webVC animated:NO completion:nil];
}
-(void)search{
    SearchViewController *sv=[[SearchViewController alloc]init];
    
    [self.navigationController pushViewController:sv animated:NO];


}

-(void)publish{
        CustomWebViewController *webVC=[[CustomWebViewController alloc]init];
        webVC.webUrl=[NSString stringWithFormat:@"http://mgsl.zilankeji.com/H5/my/addplan?uid=%@",[DEFAULTS objectForKey:@"userId"]];
        webVC.delegate=self;
        [self presentViewController:webVC animated:NO completion:nil];
}
-(void)pubresult:(NSString *)weburl{
    //发送消息
   
    
  
}
-(void)toweb:(NSString *)weburl :(NSMutableDictionary *)dic{
    CustomWebViewController *webVC=[[CustomWebViewController alloc]init];
    webVC.webUrl=weburl;
//    webVC.shareImg=dic[@"shareImg"];
//    webVC.shareTitle=dic[@"shareTitle"];
//    webVC.shareContent=dic[@"shareContent"];
//    UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:webVC];
    [self presentViewController:webVC animated:NO completion:nil];
}
#pragma mark - DBPagerTabView Delegate
- (NSUInteger)numberOfPagers:(SMPagerTabView *)view {
    return [_allVC count];
}
- (UIViewController *)pagerViewOfPagers:(SMPagerTabView *)view indexOfPagers:(NSUInteger)number {
    return _allVC[number];
}

- (void)whenSelectOnPager:(NSUInteger)number {
    NSLog(@"页面 %lu",(unsigned long)number);
    if (number==0) {
        _segmentView.btn.hidden=NO;
        _segmentView.pubbtn.hidden=NO;
    }else{
        _segmentView.btn.hidden=YES;
        _segmentView.pubbtn.hidden=YES;
    }
}

#pragma mark - setter/getter
- (SMPagerTabView *)segmentView {
    if (!_segmentView) {
        self.segmentView = [[SMPagerTabView alloc]initWithFrame:CGRectMake(0, 22, self.view.width, self.view.height - 22)];
        [self.view addSubview:_segmentView];
    }
    return _segmentView;
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
