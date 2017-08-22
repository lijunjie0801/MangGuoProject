//
//  ForgetViewController.m
//  MangGuoProject
//
//  Created by lijunjie on 2017/6/16.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "ForgetViewController.h"

@interface ForgetViewController ()<BackBtnDelegate>
@property(nonatomic,strong)UITextField *phoneText;
@property(nonatomic,strong)UITextField *codeText;
@property(nonatomic,strong)UITextField *pwdText;
@property(nonatomic,strong)UITextField *repwdText;
@end

@implementation ForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"忘记密码";
    BackBtn *backbtn=[[BackBtn alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    backbtn.delegate=self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backbtn];

    [self setUI];
}
-(void)goback{
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)setUI{
    
    
    
    
    UITextField *phoneText = [[UITextField alloc]init];
    self.phoneText=phoneText;
    phoneText.keyboardType = UIKeyboardTypeNumberPad;
    phoneText.delegate=self;
    [self.view addSubview:phoneText];
    phoneText.backgroundColor = [UIColor whiteColor];
    phoneText.layer.cornerRadius = 6.0;
    phoneText.placeholder = @"请输入手机号码";
    phoneText.leftViewMode = UITextFieldViewModeAlways;
    [phoneText autoSetDimension:ALDimensionHeight toSize:30];
    [phoneText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [phoneText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [phoneText autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:50];
    
    UIView *changePwdline=[[UIView alloc]init];
    changePwdline.backgroundColor=[UIColor colorWithHexString:@"0xf1f1f1"];
    [phoneText addSubview:changePwdline];
    [changePwdline autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:-4];
    [changePwdline autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [changePwdline autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [changePwdline autoSetDimension:ALDimensionHeight toSize:1];
    
    
    
    
    UITextField *vertifyText = [[UITextField alloc]init];
     self.codeText=vertifyText;
    vertifyText.keyboardType = UIKeyboardTypeNumberPad;
    vertifyText.delegate=self;
    [self.view addSubview:vertifyText];
    vertifyText.backgroundColor = [UIColor whiteColor];
    vertifyText.layer.cornerRadius = 6.0;
    vertifyText.placeholder = @"请输入验证码";
    vertifyText.leftViewMode = UITextFieldViewModeAlways;
    [vertifyText autoSetDimension:ALDimensionHeight toSize:30];
    [vertifyText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [vertifyText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:160];
    [vertifyText autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:changePwdline withOffset:30];
    
    //获取验证码
    UIButton *VerifiBtn = [[UIButton alloc]init];
    [VerifiBtn setBackgroundColor:[UIColor colorWithHexString:@"0xfac600"]];
    [VerifiBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [VerifiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    VerifiBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:VerifiBtn];
    //    VerifiBtn.layer.cornerRadius = 6.0;
    [VerifiBtn addTarget:self action:@selector(sendClick:) forControlEvents:UIControlEventTouchUpInside];
    [VerifiBtn autoSetDimension:ALDimensionHeight toSize:42];
    [VerifiBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [VerifiBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:vertifyText withOffset:15];
    [VerifiBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:changePwdline withOffset:20];
    
    UIView *Verifiline=[[UIView alloc]init];
    Verifiline.backgroundColor=[UIColor colorWithHexString:@"0xf1f1f1"];
    [vertifyText addSubview:Verifiline];
    [Verifiline autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:-4];
    [Verifiline autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [Verifiline autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [Verifiline autoSetDimension:ALDimensionHeight toSize:1];
    
    UITextField *pwdText = [[UITextField alloc]init];
     self.pwdText=pwdText;
    pwdText.secureTextEntry = YES;
    pwdText.delegate=self;
    [self.view addSubview:pwdText];
    pwdText.backgroundColor = [UIColor whiteColor];
    pwdText.layer.cornerRadius = 6.0;
    pwdText.placeholder = @"请输入密码";
    pwdText.leftViewMode = UITextFieldViewModeAlways;
    [pwdText autoSetDimension:ALDimensionHeight toSize:30];
    [pwdText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [pwdText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [pwdText autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:Verifiline withOffset:30];
    
    UIView *Pwdline=[[UIView alloc]init];
    Pwdline.backgroundColor=[UIColor colorWithHexString:@"0xf1f1f1"];
    [pwdText addSubview:Pwdline];
    [Pwdline autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:-4];
    [Pwdline autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [Pwdline autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [Pwdline autoSetDimension:ALDimensionHeight toSize:1];

    
    UITextField *pwdTextTwo = [[UITextField alloc]init];
    self.repwdText=pwdTextTwo;
    pwdTextTwo.secureTextEntry = YES;
    pwdTextTwo.delegate=self;
    [self.view addSubview:pwdTextTwo];
    pwdTextTwo.backgroundColor = [UIColor whiteColor];
    pwdTextTwo.layer.cornerRadius = 6.0;
    pwdTextTwo.placeholder = @"请再次输入密码";
    pwdTextTwo.leftViewMode = UITextFieldViewModeAlways;
    [pwdTextTwo autoSetDimension:ALDimensionHeight toSize:30];
    [pwdTextTwo autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [pwdTextTwo autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [pwdTextTwo autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:Pwdline withOffset:30];
    
    UIView *PwdTwoline=[[UIView alloc]init];
    PwdTwoline.backgroundColor=[UIColor colorWithHexString:@"0xf1f1f1"];
    [pwdTextTwo addSubview:PwdTwoline];
    [PwdTwoline autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:-4];
    [PwdTwoline autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [PwdTwoline autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [PwdTwoline autoSetDimension:ALDimensionHeight toSize:1];

    /*登录按钮*/
    UIButton *registBtn = [[UIButton alloc]init];
    [registBtn setTitle:@"确定" forState:UIControlStateNormal];
    registBtn.layer.cornerRadius = 6.0;
    // [loginBtn setTitleColor:[UIColor colorWithHexString:@"0xf0eff4"] forState:UIControlStateNormal];
    [registBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [registBtn setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:registBtn];
    [registBtn addTarget:self action:@selector(forgetSubmit) forControlEvents:UIControlEventTouchUpInside];
    [registBtn autoSetDimension:ALDimensionHeight toSize:40];
    [registBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [registBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:30];
    [registBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:PwdTwoline withOffset:50];
    registBtn.layer.borderColor=[UIColor grayColor].CGColor;
    registBtn.layer.borderWidth=1.0;

}
-(void)forgetSubmit{
    if (![self.pwdText.text isEqualToString:self.repwdText.text]) {
        showAlert(@"两次密码输入不一致");
        return;
    }else if (self.codeText.text.length==0){
        showAlert(@"请输入验证码");
        return;
    }
    [kNetManager forgetPassword:self.phoneText.text chkcode:self.codeText.text password:[self md5:self.pwdText.text] repassword:[self md5:self.repwdText.text] Success:^(id responseObject) {
        NSLog(@"忘记密码结果:%@",responseObject);
        if ([responseObject[@"code"] integerValue]==1) {
            [self dismissViewControllerAnimated:NO completion:nil];
        }else{
            [JRToast showWithText:responseObject[@"msg"] duration:1.0];
        }
    } Failure:^(NSError *error) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)sendClick:(UIButton *)sender{
    if ([self.phoneText.text isEqualToString:@""]) {
        [JRToast showWithText:@"请输入手机号" duration:1.0];
        return;
    }
    [kNetManager getVerficode:self.phoneText.text Success:^(id responseObject) {
        //  self.sendCond = responseObject[@"basecode"];
        if ([responseObject[@"code"] integerValue]==1) {
            NSLog(@"获取验证码成功%@",responseObject);
            [JRToast showWithText:@"获取验证码成功" duration:1];
        }else{
            [JRToast showWithText:responseObject[@"msg"] duration:1];
        }
        
        
    } Failure:^(NSError *error) {
        
    }];
    sender.userInteractionEnabled=NO;
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [sender setTitle:@"发送验证码" forState:UIControlStateNormal];
                sender.userInteractionEnabled = YES;
            });
        }else{
            //int seconds = timeout % 60;
            int seconds = timeout;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [sender setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                
                //  sender.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
}
- (NSString *)md5:(NSString *)str{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (unsigned int) strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
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
