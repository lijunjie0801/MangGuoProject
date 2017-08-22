//
//  EatingViewController.m
//  MangGuoProject
//
//  Created by lijunjie on 2017/8/12.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "EatingViewController.h"
#import "EatModel.h"
#import "MeetingCell.h"
#import "NativeWebViewController.h"
@interface EatingViewController ()<UITableViewDelegate,UITableViewDataSource,BackBtnDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *bannalArray;
@property(nonatomic,strong)SDCycleScrollView *sdview;
@end

@implementation EatingViewController

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
- (void)headerRereshing{
    [self getEatData];
    [self.tableView.header endRefreshing];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"吃法大全";
    BackBtn *backbtn=[[BackBtn alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    backbtn.delegate=self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backbtn];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle = NO;
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    self.view =_tableView;

    [self getEatData];
}
-(void)getEatData{
    [kNetManager getEatingData:^(id responseObject) {
        
        if ([responseObject[@"status"] integerValue]==100) {
            NSArray *dataarray=responseObject[@"datas"];
            NSLog(@"eat:%@",dataarray);
            NSMutableArray *muAarray=[NSMutableArray array];
            for (NSDictionary *dict in dataarray) {
                EatModel *model = [[EatModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [muAarray addObject:model];
            }
            _dataArray=[muAarray mutableCopy];
            NSLog(@"dataarray:%@",dataarray);
            [self.tableView reloadData];
            
        }

    } Failure:^(NSError *error) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EatModel *model=_dataArray[indexPath.row];
    NativeWebViewController *nv=[[NativeWebViewController alloc]init];
    nv.news_id=model.eat_id;
    nv.urlLeft=@"eat_detailai";
    nv.urlRight=@"eid";
    [self.navigationController pushViewController:nv animated:NO];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self.rdv_tabBarController setTabBarHidden:YES];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EatModel *model=_dataArray[indexPath.row];
    NSLog(@"model:%@",model);
    MeetingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[MeetingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    [cell updatawithEatModel:model];
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  140;
}

-(void)goback{
    [self.navigationController popViewControllerAnimated:NO];
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
