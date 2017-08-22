
//
//  ThirdViewController.m
//  MangGuoProject
//
//  Created by lijunjie on 2017/6/13.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "ThirdViewController.h"
#import "SGPageView.h"
#import "HomeTableViewCell.h"
#import "ThirdViewCell.h"
#import "ThirdModel.h"
#import "SearchViewController.h"
@interface ThirdViewController ()<SGPageTitleViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation ThirdViewController
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
    self.title=@"品种荟萃";
    
    NSArray *titleArr = @[@"默认排序",@"按销量", @"按价格", @"按产量",];
    
    SGPageTitleView *pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, kScreen_Width, 45) delegate:self titleNames:titleArr];
    pageTitleView.titleColorStateSelected=[UIColor colorWithHexString:@"0x8fce47"];
    pageTitleView.indicatorColor=[UIColor colorWithHexString:@"0x8fce47"];
    pageTitleView.selectedIndex = 0;
    pageTitleView.indicatorStyle=SGIndicatorTypeEqual;
    [self.view addSubview:pageTitleView];
    [self setUI];
}
-(void)leftBarClick{
    SearchViewController *sv=[[SearchViewController alloc]init];
    
    [self.navigationController pushViewController:sv animated:NO];
    
}
-(void)viewWillAppear:(BOOL)animated{
     [self.rdv_tabBarController setTabBarHidden:NO];
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
    ThirdModel *model=_dataArray[indexPath.row];
    ThirdViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[ThirdViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [cell updatawithModel:model];
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
     cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  120;
}
- (void)headerRereshing{
    [self getData];
    [self.tableView.header endRefreshing];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)getData{
    [kNetManager pinzhongData:self.caizhaiType Success:^(id responseObject) {
        NSLog(@"品种荟萃数据%@",responseObject);
        if ([responseObject[@"code"] integerValue]==1) {
            NSArray *dataarray=responseObject[@"data"];
            NSMutableArray *muAarray=[NSMutableArray array];
            for (NSDictionary *dict in dataarray) {
                ThirdModel *model = [[ThirdModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [muAarray addObject:model];
            }
            _dataArray =[muAarray mutableCopy];
            [self.tableView reloadData];
        }

    } Failure:^(NSError *error) {
        
    }];
}
- (void)SGPageTitleView:(SGPageTitleView *)SGPageTitleView selectedIndex:(NSInteger)selectedIndex{
    if (selectedIndex==0) {
        self.caizhaiType=@"name";
    }else if(selectedIndex==1){
        self.caizhaiType=@"turnout";
    }else if(selectedIndex==2){
        self.caizhaiType=@"price";
    }else if(selectedIndex==3){
        self.caizhaiType=@"volume";
    }
    [self getData];
    NSLog(@"%ld",selectedIndex);
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ThirdModel *model=_dataArray[indexPath.row];
    CustomWebViewController *webVC=[[CustomWebViewController alloc]init];
    webVC.webUrl=[NSString stringWithFormat:@"http://mgsl.zilankeji.com/H5/detail/vay?vay_id=%@",model.vay_id];
//    webVC.shareImg=model.logo_image;
//    webVC.shareTitle=model.name;
    //webVC.shareContent=model.excerpt;
//    UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:webVC];
    [self presentViewController:webVC animated:NO completion:nil];
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
