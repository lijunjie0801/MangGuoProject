//
//  MeetingViewController.m
//  MangGuoProject
//
//  Created by lijunjie on 2017/8/12.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "MeetingViewController.h"
#import "MeetingModel.h"
#import "MeetingCell.h"
#import "NativeWebViewController.h"
@interface MeetingViewController ()<UITableViewDelegate,UITableViewDataSource,BackBtnDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSArray *bannalArray;
@property(nonatomic,strong)SDCycleScrollView *sdview;

@end

@implementation MeetingViewController
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}
//-(NSMutableArray *)bannalArray{
//    if (!_bannalArray) {
//        _bannalArray=[NSMutableArray array];
//    }
//    return _bannalArray;
//}
- (void)headerRereshing{
    [self getMeetingData];
    [self.tableView.header endRefreshing];
    
}
-(void)getMeetingData{
    [kNetManager getMeetingData:^(id responseObject) {
            NSLog(@"responseObject:%@",responseObject);
        if ([responseObject[@"status"] integerValue]==100) {
            NSArray *dataarray=responseObject[@"datas"][@"info"];
          //  NSArray *bannals=responseObject[@"data"][@"banner"];
            NSMutableArray *muAarray=[NSMutableArray array];
            for (NSDictionary *dict in dataarray) {
                MeetingModel *model = [[MeetingModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [muAarray addObject:model];
            }
            NSLog(@"dataarray:%@",dataarray);
            _bannalArray=responseObject[@"datas"][@"banner"];
            _sdview.imageURLStringsGroup=_bannalArray;
            //_bannalArray =[mubannerAarray mutableCopy];
            _dataArray =[muAarray mutableCopy];
            
            [self.tableView reloadData];
            
        }
    } Failure:^(NSError *error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"大会活动";
    BackBtn *backbtn=[[BackBtn alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    backbtn.delegate=self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backbtn];

    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle = NO;
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    self.view =_tableView;
    
    SDCycleScrollView *sdc=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Width/1.85) imageURLStringsGroup:nil];
    //[topview addSubview:sdc];
    sdc.autoScrollTimeInterval=4.0;
    self.sdview=sdc;
    self.tableView.tableHeaderView=sdc;
    
    [self getMeetingData];

    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MeetingModel *model=_dataArray[indexPath.row];
    NativeWebViewController *nv=[[NativeWebViewController alloc]init];
    nv.news_id=model.news_id;
    nv.urlLeft=@"meettings";
    nv.urlRight=@"id";
    [self.navigationController pushViewController:nv animated:NO];

}
-(void)viewWillAppear:(BOOL)animated{
    [self.rdv_tabBarController setTabBarHidden:YES];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MeetingModel *model=_dataArray[indexPath.row];
    NSLog(@"model:%@",model);
    MeetingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[MeetingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
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
