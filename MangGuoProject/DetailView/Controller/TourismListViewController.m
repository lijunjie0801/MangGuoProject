//
//  TourismListViewController.m
//  MangGuoProject
//
//  Created by lijunjie on 2017/8/14.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "TourismListViewController.h"
#import "TouristCell.h"
#import "NativeWebViewController.h"
@interface TourismListViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,BackBtnDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic,strong)NSString *procode;
@property(nonatomic,strong)NSString *type_MHQ;
@property (nonatomic, strong)NSArray *titleArrays;

@end

@implementation TourismListViewController
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource =[NSMutableArray array];
    }
    return _dataSource;
}
-(void)goback{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.rdv_tabBarController setTabBarHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    BackBtn *backbtn=[[BackBtn alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    backbtn.delegate=self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backbtn];
    
    self.title=@"田东旅游";
    //self.view.frame=CGRectMake(0, 50, kScreen_Width, kScreen_Height-45);
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    //设置滚动方向
    [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //左右间距
    flowlayout.minimumInteritemSpacing = 0;
    //上下间距
    flowlayout.minimumLineSpacing = 10;
    flowlayout.sectionInset= UIEdgeInsetsMake(0, 10, 0, 10);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0 ,0, kScreen_Width, kScreen_Height-64) collectionViewLayout:flowlayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_collectionView setBackgroundColor:[UIColor colorWithHexString:@"0xf1f1f1"]];
    [_collectionView registerClass:[TouristCell class] forCellWithReuseIdentifier:@"listCell"];
    //    self.collectionView.header.stateHidden=YES;
    //    self.collectionView.header.updatedTimeHidden=YES;
    
    [self.view addSubview:_collectionView];
    [self getdata];

}
-(void)getdata{
    [kNetManager getTourData:^(id responseObject) {
        if ([responseObject[@"status"] integerValue]==100) {
        NSDictionary *dic = (NSDictionary *)responseObject;
            if ([dic[@"status"] integerValue] ==100) {
            NSArray *array =dic[@"datas"];
            NSMutableArray *homeModelArray=[NSMutableArray array];
            for (NSDictionary *dic in array) {
                TourModel *model = [[TourModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [homeModelArray addObject:model];
            }
            _dataSource=[homeModelArray mutableCopy];
            [self.collectionView reloadData];
        }
    }
    } Failure:^(NSError *error) {
    
    }];
    

    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((kScreen_Width-30)/ 2, (kScreen_Width-30)/ 2+50);
    
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TourModel *model=_dataSource[indexPath.row];
//    NativeWebViewController *nv=[[NativeWebViewController alloc]init];
//    nv.news_id=model.aid;
//    nv.urlLeft=@"around_detailai";
//    nv.urlRight=@"id";
//    [self.navigationController pushViewController:nv animated:NO];
    CustomWebViewController *webVC=[[CustomWebViewController alloc]init];
    webVC.webUrl=[NSString stringWithFormat:@"http://mgsl.zilankeji.com/H5/detail/scenic/scenic_id/%@.html",model.aid];

    [self presentViewController:webVC animated:NO completion:nil];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TouristCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"listCell" forIndexPath:indexPath];
    TourModel *model=self.dataSource[indexPath.row];
    [cell updateWithModel:model];
    //cell.indexRow=[NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}


-(void)setIntentDic:(NSDictionary *)intentDic{
    self.procode=intentDic[@"procode"];
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
