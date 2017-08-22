//
//  ChangeRolesViewController.m
//  MangGuoProject
//
//  Created by lijunjie on 2017/6/16.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "ChangeRolesViewController.h"

@interface ChangeRolesViewController ()<BackBtnDelegate>

@end

@implementation ChangeRolesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"选择角色";
    self.view.backgroundColor=[UIColor colorWithHexString:@"0xf2f2f2"];
    [self setUI];
    BackBtn *backbtn=[[BackBtn alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    backbtn.delegate=self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backbtn];
}
-(void)goback{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)setUI{
    UIView *backview=[[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreen_Width, 200)];
    backview.userInteractionEnabled=YES;
    backview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:backview];
    NSArray *nameArray=@[@"标准种植园",@"水果种植散户",@"批发商",@"普通用户"];
    for (int i=0; i<5; i++) {
        UIView *sepView=[[UIView alloc]initWithFrame:CGRectMake(0, 50*i, kScreen_Width, 1)];
        sepView.backgroundColor=[UIColor colorWithHexString:@"0xeeeeee"];
        [backview addSubview:sepView];
        if (i!=4) {
            UILabel *nameLab=[[UILabel alloc]initWithFrame:CGRectMake(20, i*50, 150, 50)];
            nameLab.text=nameArray[i];
            [backview addSubview:nameLab];
            UIButton *moreBtn=[[UIButton alloc]init];
            [moreBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
            moreBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
            moreBtn.tag=i;
            [backview addSubview:moreBtn];
            [moreBtn addTarget:self action:@selector(changeRole:) forControlEvents:UIControlEventTouchUpInside];
            [moreBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
            [moreBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:50*i];
            [moreBtn autoSetDimensionsToSize:CGSizeMake(kScreen_Width-10, 50)];
        }
    }
}
-(void)changeRole:(UIButton *)sender{
    NSArray *roleParam=@[@"4",@"6",@"7",@"8"];
    [kNetManager roleChange:roleParam[sender.tag] uid:[DEFAULTS objectForKey:@"userId"] Success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"code"] integerValue]==1) {
            [DEFAULTS setObject:responseObject[@"data"][@"group_id"] forKey:@"role"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"toFreshs" object:nil userInfo:nil];
            [self.navigationController popViewControllerAnimated:NO];
            [JRToast showWithText:@"变更角色成功" duration:1.0];
        }else{
            [JRToast showWithText:responseObject[@"msg"] duration:2.0];
        }
    } Failure:^(NSError *error) {
        
    }];
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
