//
//  FifthViewController.m
//  MangGuoProject
//
//  Created by lijunjie on 2017/6/13.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "FifthViewController.h"
#import "LoginViewController.h"
#import "SettingViewController.h"
#import "XDAlertController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "ChangeUserInfoViewController.h"
#import "WebDetailViewController.h"
@interface FifthViewController ()<UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *iconImg;
@property(nonatomic,strong)NSString *sertel;
@property(nonatomic,strong)NSString * fileCachePath;
@property(nonatomic,strong)UIImageView *waiView;
@end

@implementation FifthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden =YES;
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, -22, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle = NO;
//    [self.navigationController.view addSubview:_tableView];
    [self.view addSubview:self.tableView];
//    _tableView.tableHeaderView.frame=CGRectMake(0, 0,kScreen_Width, kScreen_Width/1.8+20);
  
    // _tableView.contentInset = UIEdgeInsetsMake(0, 0,50, 0);
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    [self getUserData];

}
-(void)viewWillAppear:(BOOL)animated{
      [self.rdv_tabBarController setTabBarHidden:NO];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(toFreshs) name:@"toFreshs" object:nil];
}
-(void)toFreshs{
    [self getUserData];
}
- (void)headerRereshing{
    [self getUserData];
    [self.tableView.header endRefreshing];
}
-(void)getUserData{
    [kNetManager getUserIndexData:[DEFAULTS objectForKey:@"userId"] Success:^(id responseObject) {
        NSLog(@"用户信息：%@",responseObject);
        if([responseObject[@"code"] integerValue]==1){
            _userName=responseObject[@"data"][@"username"];
            _iconImg=responseObject[@"data"][@"logo_image"];
            _sertel=responseObject[@"data"][@"sertel"];
            [self.tableView reloadData];
        }else{
            [JRToast showWithText:responseObject[@"msg"] duration:1.0];
        }
    } Failure:^(NSError *error) {
        
    }];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *ss=[DEFAULTS objectForKey:@"role"];
    UITableViewCell *cell=[[UITableViewCell alloc]init];
   cell.backgroundColor=[UIColor colorWithHexString:@"0xf0eff4"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    UIView *vieww=[[UIView alloc]initWithFrame:CGRectMake(0, -400, kScreen_Width, 400)];
    vieww.backgroundColor=[UIColor colorWithHexString:@"0xfac600"];
    [cell.contentView addSubview:vieww];
    UIView *view1=[self setTopView];
    view1.frame=CGRectMake(0, 0, kScreen_Width, kScreen_Width/1.6);
    [cell.contentView addSubview:view1];

    
    UIView *view3=[self setmiddleTwo];
    UIView *view2=[self setbottom];
    UIView *view4=[self setmiddleOne];
    if ([ss integerValue]==4||[ss integerValue]==6) {
        view3.frame=CGRectMake(0, kScreen_Width/1.6+20, kScreen_Width, 100);
        view2.frame=CGRectMake(0, kScreen_Width/1.6+140, kScreen_Width, 220);
        [cell.contentView addSubview:view2];
        [cell.contentView addSubview:view3];
    }else if ([ss integerValue]==8){
         view2.frame=CGRectMake(0, kScreen_Width/1.6+20, kScreen_Width, 220);
        [cell.contentView addSubview:view2];
    }else if ([ss integerValue]==7){
        view4.frame=CGRectMake(0, kScreen_Width/1.6+20, kScreen_Width, 50);
        view2.frame=CGRectMake(0, kScreen_Width/1.6+90, kScreen_Width, 220);
        [cell.contentView addSubview:view4];
        [cell.contentView addSubview:view2];
    }
    

    return cell;
}

-(UIView *)setTopView{
    UIImageView *topView=[[UIImageView alloc]init];
    topView.userInteractionEnabled=YES;
    topView.image=[UIImage imageNamed:@"personback"];
    
    UIImageView *waiView=[[UIImageView alloc]initWithFrame:CGRectMake((kScreen_Width-kScreen_Width/4)/2, (kScreen_Width/1.6-kScreen_Width/4)/2, kScreen_Width/4, kScreen_Width/4)];
    self.waiView=waiView;
    waiView.userInteractionEnabled=YES;
    waiView.clipsToBounds=YES;
    waiView.layer.cornerRadius=kScreen_Width/8;
    [waiView sd_setImageWithURL:[NSURL URLWithString:_iconImg]];
    [topView addSubview:waiView];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeIcon)];
    [waiView addGestureRecognizer:tap];
    
    
    UILabel *nickLab=[[UILabel alloc]init];
    nickLab.text=_userName;
    nickLab.textAlignment=NSTextAlignmentCenter;
    [topView addSubview:nickLab];
    [nickLab autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [nickLab autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:waiView withOffset:10];
    [nickLab autoSetDimensionsToSize:CGSizeMake(kScreen_Width, 20)];
    return topView;
}
-(UIView *)setmiddleTwo{
    UIView *middleTwoView=[[UIView alloc]init];
    middleTwoView.backgroundColor=[UIColor whiteColor];
    NSArray *nameArray=@[@"我的果园",@"我的采摘"];
    NSArray *imgArray=@[@"gy",@"cz"];
    for (int i=0; i<2; i++) {
        UIView *sepview=[[UIView alloc]initWithFrame:CGRectMake(0, 50*i, kScreen_Width, 1)];
        sepview.backgroundColor=[UIColor colorWithHexString:@"0xf0eff4"];
        [middleTwoView addSubview:sepview];
        UIImageView *perImgView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10+30*i+10*i*2, 30, 30)];
        perImgView.image=[UIImage imageNamed:imgArray[i]];
        [middleTwoView addSubview:perImgView];
            
        UILabel *nameLab=[[UILabel alloc]initWithFrame:CGRectMake(50, i*50, 100, 50)];
        nameLab.text=nameArray[i];
        [middleTwoView addSubview:nameLab];
        UIButton *moreBtn=[[UIButton alloc]init];
        [moreBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
        moreBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
            moreBtn.tag=i;
        [middleTwoView addSubview:moreBtn];
        [moreBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
        [moreBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:50*i];
        [moreBtn autoSetDimensionsToSize:CGSizeMake(kScreen_Width-10, 50)];
        [moreBtn addTarget:self action:@selector(topviewClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return middleTwoView;
}
-(void)topviewClick:(UIButton *)sender{
    if (sender.tag==0) {
        WebDetailViewController *loginVC=[[WebDetailViewController alloc]init];
        loginVC.webUrl=[NSString stringWithFormat:@"http://mgsl.zilankeji.com/H5/my/mypark?uid=%@",[DEFAULTS objectForKey:@"userId"]];
        [self.navigationController pushViewController:loginVC animated:YES];
    }else if (sender.tag==1){
        WebDetailViewController *webVC=[[WebDetailViewController alloc]init];
        webVC.webUrl=[NSString stringWithFormat:@"http://mgsl.zilankeji.com/H5/my/mypick?uid=%@",[DEFAULTS objectForKey:@"userId"]];
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

-(UIView *)setmiddleOne{
    UIView *setmiddleOne=[[UIView alloc]init];
    setmiddleOne.backgroundColor=[UIColor whiteColor];
    UIImageView *perImgView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    perImgView.image=[UIImage imageNamed:@"dg"];
    [setmiddleOne addSubview:perImgView];
        
    UILabel *nameLab=[[UILabel alloc]initWithFrame:CGRectMake(50, 0, 100, 50)];
    nameLab.text=@"我的订购";
    [setmiddleOne addSubview:nameLab];
    UIButton *moreBtn=[[UIButton alloc]init];
    [moreBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    moreBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [setmiddleOne addSubview:moreBtn];
    [moreBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [moreBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [moreBtn autoSetDimensionsToSize:CGSizeMake(kScreen_Width-10, 50)];
    [moreBtn addTarget:self action:@selector(myDingGou) forControlEvents:UIControlEventTouchUpInside];

    return setmiddleOne;
}
-(void)myDingGou{
    WebDetailViewController *webVC=[[WebDetailViewController alloc]init];
    webVC.webUrl=[NSString stringWithFormat:@"http://mgsl.zilankeji.com/H5/my/myorder?uid=%@",[DEFAULTS objectForKey:@"userId"]];
    [self.navigationController pushViewController:webVC animated:YES];}
-(UIView *)setbottom{
    UIView *bottomView=[[UIView alloc]init];
    bottomView.userInteractionEnabled=YES;
    bottomView.backgroundColor=[UIColor whiteColor];
       NSArray *nameArray=@[@"关于我们",@"联系客服",@"清除缓存"];
       for (int i=0; i<4; i++) {
        UIView *sepview=[[UIView alloc]initWithFrame:CGRectMake(0, 50*i, kScreen_Width, 1)];
        sepview.backgroundColor=[UIColor colorWithHexString:@"0xf0eff4"];
        [bottomView addSubview:sepview];
        if (i!=3) {
         

            UIImageView *perImgView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10+30*i+10*i*2, 30, 30)];
            perImgView.image=[UIImage imageNamed:[NSString stringWithFormat:@"p%d",i+1]];
            [bottomView addSubview:perImgView];
            
            UILabel *nameLab=[[UILabel alloc]initWithFrame:CGRectMake(50, i*50, 100, 50)];
            nameLab.text=nameArray[i];
             [bottomView addSubview:nameLab];
            
            UIButton *moreBtn=[[UIButton alloc]init];
            moreBtn.tag=i+200;
            [moreBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

            if (i!=2) {
                [moreBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
            }
            if (i==2) {
                CGFloat cache=[self filePath];
                [moreBtn setTitle:[NSString stringWithFormat:@"%.2fM", cache]  forState:UIControlStateNormal];
                [moreBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            }
            moreBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
            [bottomView addSubview:moreBtn];
            [moreBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
            [moreBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:50*i];
            [moreBtn autoSetDimensionsToSize:CGSizeMake(kScreen_Width-10, 50)];
        }
           
    }
    UIView *septView=[[UIView alloc]initWithFrame:CGRectMake(0, 150, kScreen_Width, 20)];
    septView.backgroundColor=[UIColor colorWithHexString:@"0xf0eff4"];
    [bottomView addSubview:septView];
    
    UIImageView *setimgView=[[UIImageView alloc]initWithFrame:CGRectMake(10,180, 30, 30)];
    setimgView.image=[UIImage imageNamed:@"set"];
    [bottomView addSubview:setimgView];

    UILabel *setLab=[[UILabel alloc]initWithFrame:CGRectMake(50, 170, 100, 50)];
    setLab.text=@"设置";
    [bottomView addSubview:setLab];
    
    UIButton *moreBtn=[[UIButton alloc]init];
    [moreBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    moreBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [bottomView addSubview:moreBtn];
    [moreBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [moreBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:170];
    [moreBtn autoSetDimensionsToSize:CGSizeMake(kScreen_Width-10, 50)];


    return bottomView;
}
-(void)buttonClick:(UIButton *)sender{
    if (sender.tag==202) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提醒" message:@"是否确认清除缓存" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self clearFile];
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [alertController addAction:okAction];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }else if (sender.tag==200){
        WebDetailViewController *webVC=[[WebDetailViewController alloc]init];
        webVC.webUrl=@"http://mgsl.zilankeji.com/H5/Index/about";
        [self.navigationController pushViewController:webVC animated:YES];
    }else if (sender.tag==201){
        NSString *telphone = [NSString stringWithFormat:@"tel://%@",_sertel];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telphone]];

//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"客服电话" message:@"是否拨打95505" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
//        [alert show];

    }
}
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (buttonIndex==0) {
//        NSString *telphone = [NSString stringWithFormat:@"tel://%@",@"95505"];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telphone]];
//    }
//}
// 显示缓存大小
-( float )filePath
{
    
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    
    return [ self folderSizeAtPath :cachPath];
    
}
//1:首先我们计算一下 单个文件的大小

- ( long long ) fileSizeAtPath:( NSString *) filePath{
    
    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    if ([manager fileExistsAtPath :filePath]){
        
        return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize ];
    }
    
    return 0 ;
    
}
//2:遍历文件夹获得文件夹大小，返回多少 M（提示：你可以在工程界设置（)m）

- ( float ) folderSizeAtPath:( NSString *) folderPath{
    
    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator ];
    
    NSString * fileName;
    
    long long folderSize = 0 ;
    
    while ((fileName = [childFilesEnumerator nextObject ]) != nil ){
        
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
        
    }
    
    return folderSize/( 1024.0 * 1024.0 );
    
}




// 清理缓存

- (void)clearFile
{
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    
    NSArray * files = [[ NSFileManager defaultManager ] subpathsAtPath :cachPath];
    
    NSLog ( @"cachpath = %@" , cachPath);
    
    for ( NSString * p in files) {
        
        NSError * error = nil ;
        
        NSString * path = [cachPath stringByAppendingPathComponent :p];
        
        if ([[ NSFileManager defaultManager ] fileExistsAtPath :path]) {
            
            [[ NSFileManager defaultManager ] removeItemAtPath :path error :&error];
            
        }
        
    }
    [ZZLProgressHUD showHUDWithMessage:@"正在清理"];
    [self performSelectorOnMainThread : @selector (clearCachSuccess) withObject : nil waitUntilDone : YES ];
    
}
-(void)clearCachSuccess
{
    NSLog ( @" 清理成功 " );
    [ZZLProgressHUD popHUD];
//    [_svc showMessage:@"清理成功"];
    
    NSIndexPath *index=[NSIndexPath indexPathForRow:0 inSection:0];//刷新
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index,nil] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)setting{
    SettingViewController *SV=[[SettingViewController alloc]init];
    UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:SV];
    [self presentViewController:nav_third animated:NO completion:nil];
    //[self.navigationController pushViewController:SV animated:NO];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(void)setClick:(UIButton *)sender{
    LoginViewController *LV=[[LoginViewController alloc]init];
    [self presentViewController:LV animated:NO completion:nil];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *ss=[DEFAULTS objectForKey:@"role"];
    CGFloat cellHeight;
    if ([ss integerValue]==4||[ss integerValue]==6) {
        cellHeight=kScreen_Height/1.6+380;
    }else if ([ss integerValue]==8){
        cellHeight=kScreen_Height/1.6+260;
    }else {
        cellHeight=kScreen_Height/1.6+310;
    }

    return  cellHeight;
}
-(void)changeIcon{
    ChangeUserInfoViewController *SV=[[ChangeUserInfoViewController alloc]init];
    UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:SV];
    [self presentViewController:nav_third animated:NO completion:nil];
    
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
