//
//  FourthViewController.m
//  MangGuoProject
//
//  Created by lijunjie on 2017/6/13.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "FourthViewController.h"
#import "SGPageView.h"
#import "HomeTableViewCell.h"
#import "FourthViewCell.h"
#import "FourthModel.h"
#import "LoginViewController.h"
#import "SearchViewController.h"
@interface FourthViewController ()<SGPageTitleViewDelegate,UITableViewDelegate,UITableViewDataSource,webdelegate>
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton *pubbtn;
@property(nonatomic,strong)UIButton *bigBackBtn;
@end

@implementation FourthViewController
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    btn.imageEdgeInsets=UIEdgeInsetsMake(0, -10, 0, 0);
    [btn setImage:[UIImage imageNamed:@"home_search"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(leftBarClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    UIButton *pubbtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    _pubbtn=pubbtn;
    pubbtn.titleLabel.font=[UIFont systemFontOfSize:16];
    pubbtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [pubbtn setTitle:@"发布" forState:UIControlStateNormal];
    [pubbtn setTitleColor:[UIColor colorWithHexString:@"0x8fce47"] forState:UIControlStateNormal];
    [pubbtn addTarget:self action:@selector(rightBarClick) forControlEvents:UIControlEventTouchUpInside];
     self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:pubbtn];
 
   
    self.title=@"订购需求";
    NSArray *titleArr = @[@"默认排序",@"按需求量", @"按价格"];
    
    SGPageTitleView *pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, kScreen_Width, 45) delegate:self titleNames:titleArr];
    pageTitleView.titleColorStateSelected=[UIColor colorWithHexString:@"0x8fce47"];
    pageTitleView.indicatorColor=[UIColor colorWithHexString:@"0x8fce47"];
    pageTitleView.selectedIndex = 0;
    pageTitleView.indicatorStyle=SGIndicatorTypeEqual;
    [self.view addSubview:pageTitleView];
    [self setUI];
}
-(void)viewWillAppear:(BOOL)animated{
    NSString *role=[DEFAULTS objectForKey:@"role"];
    if([role integerValue]==7){
        _pubbtn.hidden=NO;
    }else{
        _pubbtn.hidden=YES;
    }
     [self.rdv_tabBarController setTabBarHidden:NO];

}
-(void)leftBarClick{
    SearchViewController *sv=[[SearchViewController alloc]init];
    
    [self.navigationController pushViewController:sv animated:NO];
    
}
-(void)rightBarClick{
    if(![DEFAULTS objectForKey:@"userId"]){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登录提醒" message:@"你尚未登录，请登录" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            LoginViewController *login = [[LoginViewController alloc]init];
            CATransition * animation = [CATransition animation];
            animation.duration = 0.5;    //  时间
            animation.type = @"pageCurl";
            animation.type = kCATransitionPush;
            animation.subtype = kCATransitionFromRight;
            
            [self.view.window.layer addAnimation:animation forKey:nil];
            [self presentViewController: login animated:YES completion:nil];
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [alertController addAction:okAction];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];

    }else{
        CustomWebViewController *webVC=[[CustomWebViewController alloc]init];
        webVC.delegate=self;
        webVC.webUrl=[NSString stringWithFormat:@"http://mgsl.zilankeji.com/H5/my/addorder?uid=%@",[DEFAULTS objectForKey:@"userId"]];
//        UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:webVC];
        [self presentViewController:webVC animated:NO completion:nil];
    }
}
-(void)pubresult:(NSString *)weburl{
    NSLog(@"yyyy:%@",weburl);
    NSString *pubimg;
    if ([weburl integerValue]==0) {
        pubimg=@"pubfaul";
    }else if ([weburl integerValue]==1){
        pubimg=@"pubsuccess";
    }
    UIButton *bigBackBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, -20, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height+64+20)];
    bigBackBtn.backgroundColor=[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
    self.bigBackBtn=bigBackBtn;
    [self.rdv_tabBarController.view addSubview:bigBackBtn];
    [bigBackBtn addTarget:self action:@selector(clickEmpt) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *bgView = [[UIImageView alloc]init];
    [bigBackBtn addSubview:bgView];
    bgView.image=[UIImage imageNamed:pubimg];
    bgView.frame=CGRectMake(50, (kScreen_Height-((kScreen_Width-100)/1.8))/2, kScreen_Width-100, (kScreen_Width-100)/1.8);
    [self getData];
    
}
-(void)clickEmpt
{
    [self getData];
    [self.bigBackBtn removeFromSuperview];
}
-(void)getData{
    [kNetManager dinggouData:self.dingType uid:[DEFAULTS objectForKey:@"userId"] Success:^(id responseObject) {
        NSLog(@"订购需求数据%@",responseObject);
        if ([responseObject[@"code"] integerValue]==1) {
            NSArray *dataarray=responseObject[@"data"];
            NSMutableArray *muAarray=[NSMutableArray array];
            for (NSDictionary *dict in dataarray) {
                FourthModel *model = [[FourthModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [muAarray addObject:model];
            }
            _dataArray =[muAarray mutableCopy];
            [self.tableView reloadData];
        }
    } Failure:^(NSError *error) {
        
    }];
}
-(void)setUI{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 45, kScreen_Width, kScreen_Height-108-45) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle = NO;
    
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    [self.view addSubview: _tableView];
    UIView *topview=[[UIView alloc]initWithFrame:CGRectMake(0, 45, kScreen_Width, 20)];
    topview.backgroundColor=[UIColor colorWithHexString:@"0xf1f1f1"];
    self.tableView.tableHeaderView=topview;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FourthModel *model=_dataArray[indexPath.row];
    FourthViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[FourthViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [cell updatawithModel:model];
     cell.selectionStyle =UITableViewCellSelectionStyleNone;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  140;
}
- (void)headerRereshing{
    [self getData];
    [self.tableView.header endRefreshing];
    
}
- (void)SGPageTitleView:(SGPageTitleView *)SGPageTitleView selectedIndex:(NSInteger)selectedIndex{
    if (selectedIndex==0) {
        self.dingType=@"add_time";
    }else if(selectedIndex==1){
        self.dingType=@"number";
    }else if(selectedIndex==2){
        self.dingType=@"price";
    }
    [self getData];
    NSLog(@"%ld",selectedIndex);
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FourthModel *model=_dataArray[indexPath.row];
    CustomWebViewController *webVC=[[CustomWebViewController alloc]init];
    webVC.webUrl=[NSString stringWithFormat:@"http://mgsl.zilankeji.com/H5/detail/orderdetail?oid=%@",model.oid];
//    webVC.shareImg=model.logo_image;
//    webVC.shareTitle=model.title;
    //webVC.shareContent=model.excerpt;
//    UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:webVC];
    [self presentViewController:webVC animated:NO completion:nil];

}
@end
