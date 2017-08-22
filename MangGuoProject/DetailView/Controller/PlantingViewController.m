//
//  PlantingViewController.m
//  MangGuoProject
//
//  Created by lijunjie on 2017/8/12.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "PlantingViewController.h"
#import "SGPageView.h"
#import "HomeTableViewCell.h"
#import "ThirdViewCell.h"
#import "PlantModel.h"
#import "MeetingCell.h"
#import "NativeWebViewController.h"
@interface PlantingViewController ()<SGPageTitleViewDelegate,UITableViewDelegate,UITableViewDataSource,BackBtnDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSString *caizhaiType;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation PlantingViewController
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    BackBtn *backbtn=[[BackBtn alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    backbtn.delegate=self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backbtn];

    self.title=@"种植技术";
    
    NSArray *titleArr = @[@"育苗嫁接",@"虫害防治", @"浇水施肥", @"其他养护",];
    
    SGPageTitleView *pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, kScreen_Width, 45) delegate:self titleNames:titleArr];
    pageTitleView.titleColorStateSelected=[UIColor colorWithHexString:@"0x8fce47"];
    pageTitleView.indicatorColor=[UIColor colorWithHexString:@"0x8fce47"];
    pageTitleView.selectedIndex = 0;
    pageTitleView.indicatorStyle=SGIndicatorTypeEqual;
    [self.view addSubview:pageTitleView];
    [self setUI];
}
-(void)goback{
    [self.navigationController popViewControllerAnimated:NO];
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
    PlantModel *model=_dataArray[indexPath.row];
    MeetingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[MeetingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [cell updatawithPlantModel:model];
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)viewWillAppear:(BOOL)animated{
    [self.rdv_tabBarController setTabBarHidden:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PlantModel *model=_dataArray[indexPath.row];
    NativeWebViewController *nv=[[NativeWebViewController alloc]init];
    nv.news_id=model.cat_id;
    nv.urlLeft=@"technology_detailai";
    nv.urlRight=@"tid";
    [self.navigationController pushViewController:nv animated:NO];
    
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)getData{
    /**种植技术**/
    [kNetManager PlantData:self.caizhaiType Success:^(id responseObject) {
        NSLog(@"品种荟萃数据%@",responseObject);
        if ([responseObject[@"status"] integerValue]==100) {
            NSArray *dataarray=responseObject[@"datas"];
         
            NSMutableArray *muAarray=[NSMutableArray array];
            for (NSDictionary *dict in dataarray) {
                PlantModel *model = [[PlantModel alloc] init];
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
        self.caizhaiType=@"41";
    }else if(selectedIndex==1){
        self.caizhaiType=@"42";
    }else if(selectedIndex==2){
        self.caizhaiType=@"43";
    }else if(selectedIndex==3){
        self.caizhaiType=@"44";
    }
    [self getData];
    NSLog(@"%ld",selectedIndex);
    
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
