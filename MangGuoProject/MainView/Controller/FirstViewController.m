//
//  FirstViewController.m
//  MangGuoProject
//
//  Created by lijunjie on 2017/6/13.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "FirstViewController.h"
#import "MessageScrollerView.h"
#import "HomeTableViewCell.h"
#import "HomeModel.h"
#import "NativeWebViewController.h"
#import "EatingViewController.h"
#import "MeetingViewController.h"
#import "PlantingViewController.h"
#import "SearchViewController.h"
#import "TourismListViewController.h"
@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource,SearchViewDelegate>
@property(nonatomic, strong)UIImageView *navBarHairlineImageView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *bannalArray;
@property(nonatomic,strong)SDCycleScrollView *sdview;
@end

@implementation FirstViewController
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}
-(NSMutableArray *)bannalArray{
    if (!_bannalArray) {
        _bannalArray=[NSMutableArray array];
    }
    return _bannalArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"芒果熟了";
    
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    btn.imageEdgeInsets=UIEdgeInsetsMake(0, -10, 0, 0);
    [btn setImage:[UIImage imageNamed:@"home_search"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(leftBarClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle = NO;
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    self.view =_tableView;
//    _navBarHairlineImageView= [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    [self setTop];
    [self getHomeData];
    
    NSLog(@"用户id:%@",[DEFAULTS objectForKey:@"userId"]);
}
- (void)headerRereshing{
    [self getHomeData];
    [self.tableView.header endRefreshing];
    
}
-(void)pushview:(NSString *)uid{
    NativeWebViewController *nv=[[NativeWebViewController alloc]init];
    nv.news_id=uid;;
    nv.urlLeft=@"meettings";
    nv.urlRight=@"id";
    [self.navigationController pushViewController:nv animated:NO];
}
-(void)leftBarClick{
//    CustomWebViewController *webVC=[[CustomWebViewController alloc]init];
//    webVC.webUrl=@"http://mgsl.zilankeji.com/H5/Index/search";
//    UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:webVC];
   // [self presentViewController:webVC animated:NO completion:nil];
    SearchViewController *sv=[[SearchViewController alloc]init];

    [self.navigationController pushViewController:sv animated:NO];
}
-(void)getHomeData{
    [kNetManager getHomeData:^(id responseObject) {
        NSLog(@"首页数据%@",responseObject);
        if ([responseObject[@"code"] integerValue]==1) {
            NSArray *dataarray=responseObject[@"data"][@"topline"];
            NSArray *bannals=responseObject[@"data"][@"banner"];
            NSMutableArray *muAarray=[NSMutableArray array];
            NSMutableArray *mubannerAarray=[NSMutableArray array];
            for (NSDictionary *dict in dataarray) {
                HomeModel *model = [[HomeModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [muAarray addObject:model];
            }
            for (NSDictionary *dict in bannals) {
                NSString *bannerImg=dict[@"path"];
                [mubannerAarray addObject:bannerImg];
            }
             _sdview.imageURLStringsGroup=mubannerAarray;
            _bannalArray =[mubannerAarray mutableCopy];
            _dataArray =[muAarray mutableCopy];
            [self.tableView reloadData];
            
        }

    } Failure:^(NSError *error) {
        
    }];
    
}
-(void)setTop{
     CGFloat btnwidth=(kScreen_Width-80)/5;
    UIView *topview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Width/1.85+20+btnwidth+85)];
 //   NSArray *array=@[@"http://pic64.nipic.com/file/20150417/18138004_120854303000_2.jpg",@"http://img003.hc360.cn/y1/M05/86/BC/wKhQc1SbHVmEPAOdAAAAAHoW85k104.jpg"];
    SDCycleScrollView *sdc=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Width/1.85) imageURLStringsGroup:nil];
    sdc.autoScrollTimeInterval=4.0;
    [topview addSubview:sdc];
    self.sdview=sdc;
    self.tableView.tableHeaderView=topview;
    
   
    NSArray *btnTitle=@[@"大会活动",@"吃法大全",@"产地分布",@"种植技术",@"田东旅游"];
    for (int i=0; i<5; i++) {
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(10+(btnwidth+15)*i, kScreen_Width/1.85+20, btnwidth, btnwidth)];
        btn.tag=i;
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"home%d",i]] forState:UIControlStateNormal];
        [topview addSubview:btn];
        [btn addTarget:self action:@selector(topImgClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *btnLabel=[[UILabel alloc]initWithFrame:CGRectMake(10+(btnwidth+15)*i, kScreen_Width/1.85+20+btnwidth+5, btnwidth, 20)];
        btnLabel.font=[UIFont systemFontOfSize:11];
        btnLabel.text=btnTitle[i];
        btnLabel.textAlignment=NSTextAlignmentCenter;
        [topview addSubview:btnLabel];
    }
    
    UIView *sepview=[[UIView alloc]initWithFrame:CGRectMake(0, kScreen_Width/1.85+20+btnwidth+40, kScreen_Width, 10)];
    sepview.backgroundColor=[UIColor colorWithHexString:@"0xf0eff4"];
    [topview addSubview:sepview];
    
    UIView *shuView=[[UIView alloc]initWithFrame:CGRectMake(15,kScreen_Width/1.85+20+btnwidth+60,2, 15)];
    shuView.backgroundColor=[UIColor colorWithHexString:@"0x8fce47"];
    [topview addSubview:shuView];
    
    UILabel *celltopLab=[[UILabel alloc]initWithFrame:CGRectMake(25,kScreen_Width/1.85+20+btnwidth+50, kScreen_Width-25, 35)];
    celltopLab.font=[UIFont systemFontOfSize:15];
    celltopLab.text=@"芒果头条";
    [topview addSubview:celltopLab];

}
-(void)topImgClick:(UIButton *)sender{
    if (sender.tag==0) {
        MeetingViewController *ev=[[MeetingViewController alloc]init];
        [self.navigationController pushViewController:ev animated:NO];
        return;
    }
    if (sender.tag==1) {
        EatingViewController *ev=[[EatingViewController alloc]init];
        [self.navigationController pushViewController:ev animated:NO];
        return;
    }
    if (sender.tag==3) {
        PlantingViewController *ev=[[PlantingViewController alloc]init];
        [self.navigationController pushViewController:ev animated:NO];
        return;
    }
    if (sender.tag==4) {
        TourismListViewController *ev=[[TourismListViewController alloc]init];
        [self.navigationController pushViewController:ev animated:NO];
        return;
    }
    NSArray *weburlArray=@[@"meetting",@"eatway",@"park",@"zhongzhi",@"scenic"];
    CustomWebViewController *webVC=[[CustomWebViewController alloc]init];
    webVC.webUrl=[NSString stringWithFormat:@"http://mgsl.zilankeji.com/H5/Index/%@",weburlArray[sender.tag]];
   // UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:webVC];
    [self presentViewController:webVC animated:NO completion:nil];

}
-(void)viewWillAppear:(BOOL)animated{
      self.navigationController.navigationBar.hidden =NO;
     [self.rdv_tabBarController setTabBarHidden:NO];
}
/*-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeModel *model=_dataArray[indexPath.row];
    CustomWebViewController *webVC=[[CustomWebViewController alloc]init];
    webVC.webUrl=[NSString stringWithFormat:@"http://mgsl.zilankeji.com/H5/detail/detail?news_id=%@&cat=%@",model.news_id,model.cat];
//    webVC.shareImg=model.logo_image;
//    webVC.shareTitle=model.news_name;
//    webVC.shareContent=model.excerpt;
//    UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:webVC];
    [self presentViewController:webVC animated:NO completion:nil];
}*/
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeModel *model=_dataArray[indexPath.row];
    NativeWebViewController *nv=[[NativeWebViewController alloc]init];
    nv.news_id=model.news_id;
    nv.urlLeft=@"meettings";
    nv.urlRight=@"id";
    [self.navigationController pushViewController:nv animated:NO];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeModel *model=_dataArray[indexPath.row];
    NSLog(@"model:%@",model);
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[HomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
       
                }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    [cell updatawithModel:model];
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  140;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
