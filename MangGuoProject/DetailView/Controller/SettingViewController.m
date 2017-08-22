//
//  SettingViewController.m
//  MangGuoProject
//
//  Created by lijunjie on 2017/6/16.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "SettingViewController.h"
#import "ChangePWDViewController.h"
#import "ChangeRolesViewController.h"
@interface SettingViewController ()<BackBtnDelegate>

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"设置";
    BackBtn *backbtn=[[BackBtn alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    backbtn.delegate=self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backbtn];
     self.view.backgroundColor=[UIColor colorWithHexString:@"0xf0eff4"];
    [self setUI];
}
-(void)setUI{
    NSArray *nameArray=@[@"修改密码",@"变更角色"];
//    NSArray *imgArray=@[@"gy",@"cz"];
    UIView *middleTwoView=[[UIView alloc]init];
    middleTwoView.backgroundColor=[UIColor whiteColor];
    middleTwoView.frame=CGRectMake(0, 25, kScreen_Width, 100);
    [self.view addSubview:middleTwoView];
    for (int i=0; i<2; i++) {
        UIView *sepview=[[UIView alloc]initWithFrame:CGRectMake(0, 50*i, kScreen_Width, 1)];
        sepview.backgroundColor=[UIColor colorWithHexString:@"0xf0eff4"];
        [middleTwoView addSubview:sepview];
        
        UILabel *nameLab=[[UILabel alloc]initWithFrame:CGRectMake(20, i*50, 100, 50)];
        nameLab.text=nameArray[i];
        [middleTwoView addSubview:nameLab];
        UIButton *moreBtn=[[UIButton alloc]init];
        [moreBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
        moreBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
        moreBtn.tag=i;
        [middleTwoView addSubview:moreBtn];
        [moreBtn addTarget:self action:@selector(topClick:) forControlEvents:UIControlEventTouchUpInside];
        [moreBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
        [moreBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:50*i];
        [moreBtn autoSetDimensionsToSize:CGSizeMake(kScreen_Width-10, 50)];
        
        
    }
    
//    UIView *bottomView=[[UIView alloc]init];
//    bottomView.backgroundColor=[UIColor whiteColor];
//    bottomView.frame=CGRectMake(0, 150, kScreen_Width, 50);
//    [self.view addSubview:bottomView];
    
    
//    UILabel *nameLab=[[UILabel alloc]initWithFrame:CGRectMake(20,0, 100, 50)];
//    nameLab.text=@"变更角色";
//    [bottomView addSubview:nameLab];
//    UIButton *moreBtn=[[UIButton alloc]init];
//    [moreBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
//    [moreBtn addTarget:self action:@selector(changeRole) forControlEvents:UIControlEventTouchUpInside];
//    moreBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
//    [bottomView addSubview:moreBtn];
//    [moreBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
//    [moreBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
//    [moreBtn autoSetDimensionsToSize:CGSizeMake(kScreen_Width-10, 50)];
    
    
    UIButton *logoutBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 260, kScreen_Width, 50)];
    [logoutBtn setBackgroundColor:[UIColor whiteColor]];
    [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [logoutBtn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [logoutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:logoutBtn];

}
-(void)logout{
    [DEFAULTS removeObjectForKey:@"userId"];
     [DEFAULTS removeObjectForKey:@"role"];
//    [self.delegate refresh];
//    [LRNotificationCenter postNotificationName:@"refresh" object:nil];
    CYRootTabViewController *rootVC = [[CYRootTabViewController alloc] init];
    [self presentViewController:rootVC animated:NO completion:nil];
}
-(void)changeRole{
    ChangeRolesViewController *CV=[[ChangeRolesViewController alloc]init];
    [self.navigationController pushViewController:CV animated:NO];
}
-(void)topClick:(UIButton *)btn{
    if (btn.tag==0) {
        ChangePWDViewController *CV=[[ChangePWDViewController alloc]init];
        [self.navigationController pushViewController:CV animated:NO];
    }else{
        [self changeRole];
//        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//        [kNetManager getbanben:app_Version type:@"2" Success:^(id responseObject) {
//            NSLog(@"%@",responseObject);
//            if ([responseObject[@"code"] intValue]==-1) {
//                showAlert(@"您已经是最新版本，无需更新");
//            }else if ([responseObject[@"code"] intValue]==1){
//                NSString *downurl=responseObject[@"data"][@"path"];
//                [self alertUpdata:downurl];
//            }else{
//                [JRToast showWithText:responseObject[@"msg"] duration:1.0];
//            }
//        } Failure:^(NSError *error) {
//
//        }];
    }
}
-(void)alertUpdata:(NSString *)downUrl{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"检查更新" message:@"发现新版本，是否立即更新" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *s=[@"itms-apps://itunes.apple.com/cn/app/社区之家-让你的生活更轻松/id1246595848?mt=8" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:s]];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];

}
-(void)goback{
    [self dismissViewControllerAnimated:NO completion:nil];
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
