//
//  SencondDetailViewController.m
//  MangGuoProject
//
//  Created by lijunjie on 2017/6/15.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "SencondDetailViewController.h"
#import "HomeTableViewCell.h"
#import "SGPageView.h"
#import "SecondModel.h"
@interface SencondDetailViewController ()<UITableViewDelegate,UITableViewDataSource,SGPageTitleViewDelegate>
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation SencondDetailViewController
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
  
    UIView *sview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 0.5)];
    sview.backgroundColor=[UIColor grayColor];
    [self.view addSubview:sview];
    self.caizhaiType=@"vay_id";
    [self setUI];
    [self getData];
}
-(void)viewWillAppear:(BOOL)animated{
    //接收消息
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pubfresh:) name:@"pubfresh" object:nil];
    [self getData];
}
-(void)pubfresh:(NSNotification*)notification{
    
}

-(void)getData{
    if ([self.type integerValue]==0) {
        [kNetManager getCaizhaiPlanData:self.caizhaiType Success:^(id responseObject) {
            NSLog(@"采摘数据%@",responseObject);
            if ([responseObject[@"code"] integerValue]==1) {
                NSArray *dataarray=responseObject[@"data"];
                NSMutableArray *muAarray=[NSMutableArray array];
                for (NSDictionary *dict in dataarray) {
                    SecondModel *model = [[SecondModel alloc] init];
                    [model setValuesForKeysWithDictionary:dict];
                    [muAarray addObject:model];
                }
                _dataArray =[muAarray mutableCopy];
                [self.tableView reloadData];
            }
        } Failure:^(NSError *error) {
            
        }];

    }else{
        [kNetManager getCaizhaiNotiData:^(id responseObject) {
            NSLog(@"采摘通告数据%@",responseObject);
            if ([responseObject[@"code"] integerValue]==1) {
//                NSArray *dataarray=responseObject[@"data"];
//                NSMutableArray *muAarray=[NSMutableArray array];
//                for (NSDictionary *dict in dataarray) {
//                    SecondModel *model = [[SecondModel alloc] init];
//                    [model setValuesForKeysWithDictionary:dict];
//                    [muAarray addObject:model];
//                }
//                _dataArray =[muAarray mutableCopy];
//                [self.tableView reloadData];
            }

        } Failure:^(NSError *error) {
            
        }];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   SecondModel *model=_dataArray[indexPath.row];
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:model.logo_image forKey:@"shareImg"];
     [dic setValue:model.name forKey:@"shareTitle"];
     [dic setValue:model.except forKey:@"shareContent"];
    NSString *string=[NSString stringWithFormat:@"http://mgsl.zilankeji.com/H5/detail/plan?plan_id=%@",model.pluck_id];
    //[self.delegate toweb:string];
    [self.delegate toweb:string :dic];
}
-(void)setUI{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 45, kScreen_Width, kScreen_Height-108) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle = NO;
    
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    [self.view addSubview: _tableView];
    
    NSArray *titleArr = @[@"按品种", @"按时间", @"按产地"];
    
    SGPageTitleView *pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, kScreen_Width, 45) delegate:self titleNames:titleArr];
    pageTitleView.titleColorStateSelected=[UIColor colorWithHexString:@"0x8fce47"];
    pageTitleView.indicatorColor=[UIColor colorWithHexString:@"0x8fce47"];
    pageTitleView.selectedIndex = 0;
    pageTitleView.indicatorStyle=SGIndicatorTypeEqual;
   
    UIView *topview=[[UIView alloc]initWithFrame:CGRectMake(0, 45, kScreen_Width, 20)];
    topview.backgroundColor=[UIColor colorWithHexString:@"0xf1f1f1"];
    self.tableView.tableHeaderView=topview;
    if ([self.type isEqualToString:@"0"]) {
         [self.view addSubview:pageTitleView];
        _tableView.frame=CGRectMake(0, 45, kScreen_Width, kScreen_Height-108-45);
    }else{
        [pageTitleView removeFromSuperview];
        _tableView.frame=CGRectMake(0, 0, kScreen_Width, kScreen_Height-108);
    }
    
  
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SecondModel *model=_dataArray[indexPath.row];
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[HomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [cell updatawithSeModel:model];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)SGPageTitleView:(SGPageTitleView *)SGPageTitleView selectedIndex:(NSInteger)selectedIndex{
    if (selectedIndex==1) {
        self.caizhaiType=@"add_time";
    }else if(selectedIndex==2){
        self.caizhaiType=@"park_id";
    }else if(selectedIndex==0){
        self.caizhaiType=@"vay_id";
    }
   // [self getData];
    NSLog(@"%ld",selectedIndex);
    
}


@end
