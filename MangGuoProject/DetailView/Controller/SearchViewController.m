//
//  SearchViewController.m
//  MangGuoProject
//
//  Created by lijunjie on 2017/8/12.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "SearchViewController.h"
#import "HXSearchBar.h"
#import "SearchModel.h"
#import "MeetingCell.h"
#import "NativeWebViewController.h"
@interface SearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *searchView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *bannalArray;

@end

@implementation SearchViewController
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSearchBar];

    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreen_Width, kScreen_Height-44) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle = NO;
    [self addSearchBar];
    [self.view addSubview:_tableView];

}


//-(void)viewDidDisappear:(BOOL)animated{
//    self.navigationController.navigationBar.hidden =NO;
//}
- (void)addSearchBar {
    //加上 搜索栏
    _searchView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 64)];
     [self.view addSubview:_searchView];
    UIView *top=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 22)];
    top.backgroundColor=RGB(237, 197, 46);
    [_searchView addSubview:top];
    HXSearchBar *searchBar = [[HXSearchBar alloc] initWithFrame:CGRectMake(0, 22, self.view.frame.size.width, 42)];
    searchBar.backgroundColor = RGB(237, 197, 46);
    searchBar.delegate = self;
    //输入框提示
    searchBar.placeholder = @"请输入搜索关键词";
    //光标颜色
    searchBar.cursorColor = [UIColor grayColor];
    //TextField
    searchBar.searchBarTextField.layer.cornerRadius = 4;
    searchBar.searchBarTextField.layer.masksToBounds = YES;
//    searchBar.searchBarTextField.layer.borderColor = [UIColor orangeColor].CGColor;
//    searchBar.searchBarTextField.layer.borderWidth = 1.0;
    
    searchBar.cancleButton.backgroundColor = [UIColor clearColor];
    [searchBar.cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [searchBar.cancleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    searchBar.cancleButton.titleLabel.font = [UIFont systemFontOfSize:14];

    
    //清除按钮图标
    searchBar.clearButtonImage = [UIImage imageNamed:@"demand_delete"];
    
    //去掉取消按钮灰色背景
    searchBar.hideSearchBarBackgroundImage = YES;
    
    
    [_searchView addSubview:searchBar];
    [self.searchDisplayController setActive:NO animated:YES];
    
    UIButton *cancel=[[UIButton alloc]initWithFrame:CGRectMake(kScreen_Width-60, 22, 60, 42)];
    [cancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [_searchView addSubview:cancel];
  //  return _searchView;
}
-(void)cancel{
//    _searchView.showsCancelButton = NO;
//    _searchView.text = nil;
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:NO];
}
// 视图显示的时候, 隐藏系统导航  使用自定义导航
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
      [self.rdv_tabBarController setTabBarHidden:YES];
    
    if (self.navigationController) {
        
        self.navigationController.navigationBarHidden = YES;
    }
}
// 视图消失的时候, 将系统导航恢复
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    if (self.navigationController) {
        self.navigationController.navigationBarHidden = NO;
    }
}

#pragma mark - UISearchBar Delegate

//已经开始编辑时的回调
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
//    HXSearchBar *sear = (HXSearchBar *)searchBar;
//    //取消按钮
//    sear.cancleButton.backgroundColor = [UIColor clearColor];
//    [sear.cancleButton setTitle:@"取消" forState:UIControlStateNormal];
//    [sear.cancleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    sear.cancleButton.titleLabel.font = [UIFont systemFontOfSize:14];
}

//编辑文字改变的回调
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"searchText:%@",searchText);
}

//搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
     [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    if (searchBar.text.length==0) {
        [JRToast showWithText:@"请输入搜索的关键字" duration:2.0];
        return;
    }
    
     NSLog(@"searchText:%@",searchBar.text);
    
    [kNetManager getSearchData:searchBar.text Success:^(id responseObject) {
        NSLog(@"search:%@",responseObject);
        NSDictionary *dic=(NSDictionary *)responseObject;
        NSArray *dataarray=dic[@"datas"];
        NSMutableArray *muAarray=[NSMutableArray array];
        for (NSDictionary *dict in dataarray) {
            SearchModel *model = [[SearchModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [muAarray addObject:model];
        }
        _dataArray=[muAarray mutableCopy];
        NSLog(@"dataarray:%@",dataarray);
        [self.tableView reloadData];
    } Failure:^(NSError *error) {
        
    }];
}

//取消按钮点击的回调
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
    searchBar.text = nil;
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchModel *model=_dataArray[indexPath.row];
    NSLog(@"model:%@",model);
    MeetingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[MeetingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    [cell updatawithSearchModel:model];
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  140;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_searchView removeFromSuperview];
    SearchModel *model=_dataArray[indexPath.row];
    NSInteger cat=[model.cat integerValue];
    NativeWebViewController *nv=[[NativeWebViewController alloc]init];
    nv.news_id=model.nid;;
    if (cat==1) {
       
        nv.urlLeft=@"meettings";
        nv.urlRight=@"id";
        [self.navigationController pushViewController:nv animated:NO];
    }else if (cat==2){
        
    }else if (cat==3){
        nv.urlLeft=@"eat_detailai";
        nv.urlRight=@"eid";
        [self.navigationController pushViewController:nv animated:NO];

    }else if (cat==4||cat==41||cat==42||cat==43||cat==44){
        nv.urlLeft=@"technology_detailai";
        nv.urlRight=@"tid";
        [self.navigationController pushViewController:nv animated:NO];
    }else if (cat==6){
        CustomWebViewController *webVC=[[CustomWebViewController alloc]init];
        webVC.webUrl=[NSString stringWithFormat:@"http://mgsl.zilankeji.com/H5/detail/vay?vay_id=%@",model.nid];
        [self presentViewController:webVC animated:NO completion:nil];
    }else if (cat==7){
        CustomWebViewController *webVC=[[CustomWebViewController alloc]init];
        webVC.webUrl=[NSString stringWithFormat:@"http://mgsl.zilankeji.com/H5/detail/scenic/scenic_id/%@.html",model.nid];
        
        [self presentViewController:webVC animated:NO completion:nil];
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
