//
//  SendOtherViewController.m
//  MangGuoProject
//
//  Created by lijunjie on 2017/6/21.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "SendOtherViewController.h"
#import "HomeTableViewCell.h"
@interface SendOtherViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation SendOtherViewController
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
    [self setUI];
    [self getData];
    
}
-(void)getData{

        [kNetManager getCaizhaiNotiData:^(id responseObject) {
            NSLog(@"采摘通告数据%@",responseObject);
            if ([responseObject[@"code"] integerValue]==1) {
                NSArray *dataarray=responseObject[@"data"];
                NSMutableArray *muAarray=[NSMutableArray array];
                for (NSDictionary *dict in dataarray) {
                    SencondOtherModel *model = [[SencondOtherModel alloc] init];
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
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle = NO;
    
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    [self.view addSubview: _tableView];
    
    UIView *top=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 20)];
    top.backgroundColor=[UIColor colorWithHexString:@"0xf1f1f1"];
    _tableView.tableHeaderView=top;
    //_tableView.frame=CGRectMake(0, 0, kScreen_Width, kScreen_Height-108);

    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SencondOtherModel *model=_dataArray[indexPath.row];
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[HomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [cell updatawithSeOtherModel:model];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"_dataArray.count:%ld",_dataArray.count);
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  140;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
      SencondOtherModel *model=_dataArray[indexPath.row];
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:model.logo_image forKey:@"shareImg"];
    [dic setValue:model.news_name forKey:@"shareTitle"];
    [dic setValue:model.excerpt forKey:@"shareContent"];
    NSString *string=[NSString stringWithFormat:@"http://mgsl.zilankeji.com/H5/detail/pick?pick_id=%@",model.news_id];
    //[self.delegate toweb:string];
    [self.delegate towebview:string :dic];

}
- (void)headerRereshing{
    [self getData];
    [self.tableView.header endRefreshing];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
