//
//  LoginViewController.m
//  MangGuoProject
//
//  Created by lijunjie on 2017/6/16.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "LoginViewController.h"
#import "ForgetViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UIView *LoginView;
@property(nonatomic,strong)UIView *RegistView;
@property(nonatomic,strong)UIView *registLine;
@property(nonatomic,strong)UIView *loginLine;
@property(nonatomic,strong)UITextField *phoneNumText;
@property(nonatomic,strong)UITextField *passwordText;
@property(nonatomic,strong)UITextField *vertifyText;
@property(nonatomic,strong)UITextField *nickNameText;
@property(nonatomic,strong)UITextField *userNameText;
@property(nonatomic,strong)UITextField *userPWDText;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopUI];
    
}
-(void)setTopUI{
    UIImageView *topView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Width/1.66)];
    topView.userInteractionEnabled=YES;
    topView.image=[UIImage imageNamed:@"loginImg"];
    [self.view addSubview:topView];
    
    UIButton *backBtn=[[UIButton alloc]initWithFrame:CGRectMake(15, 25, 30, 30)];
    [backBtn setImage:[UIImage imageNamed:@"x"] forState:UIControlStateNormal];
    [topView addSubview:backBtn];
    [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:16]};
    CGSize size=[@"登录" sizeWithAttributes:attrs];
    UIButton *loginbtn=[[UIButton alloc]init];
    [loginbtn setTitle:@"登录" forState:UIControlStateNormal];
    loginbtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [loginbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [topView addSubview:loginbtn];
    [loginbtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:20];
    [loginbtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [loginbtn autoSetDimensionsToSize:CGSizeMake(kScreen_Width/2, 30)];
    
    UIView *loginLine=[[UIView alloc]init];
    self.loginLine=loginLine;
    [topView addSubview:loginLine];
    [loginbtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    loginLine.backgroundColor=[UIColor blackColor];
    [loginLine autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:18];
    [loginLine autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:(kScreen_Width/2-size.width)/2];
    [loginLine autoSetDimensionsToSize:CGSizeMake(size.width, 2)];
    
    UIButton *registbtn=[[UIButton alloc]init];
    [registbtn setTitle:@"注册" forState:UIControlStateNormal];
    [registbtn addTarget:self action:@selector(registClick) forControlEvents:UIControlEventTouchUpInside];
    registbtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [registbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [topView addSubview:registbtn];
    [registbtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:30];
    [registbtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kScreen_Width/2];
    [registbtn autoSetDimensionsToSize:CGSizeMake(kScreen_Width/2, 20)];
    
    UIView *registLine=[[UIView alloc]init];
    self.registLine=registLine;
    registLine.hidden=YES;
    [topView addSubview:registLine];
    registLine.backgroundColor=[UIColor blackColor];
    [registLine autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:18];
    [registLine autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:(kScreen_Width/2-size.width)/2];
    [registLine autoSetDimensionsToSize:CGSizeMake(size.width, 2)];
    [self.view addSubview:[self setLoginView]];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];

    }
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}
-(void)registClick{
    [self.view endEditing:YES];
    [self.view addSubview:[self setRegistView]];

    self.LoginView.hidden=YES;
    self.RegistView.hidden=NO;
    self.loginLine.hidden=YES;
    self.registLine.hidden=NO;
}
-(void)loginClick{
    [self.view endEditing:YES];
    self.RegistView.hidden=YES;
    self.LoginView.hidden=NO;
    self.loginLine.hidden=NO;
     self.registLine.hidden=YES;
}
-(void)goBack{
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(UIView *)setLoginView{
    UIView *LoginView=[[UIView alloc]init];
    self.LoginView=LoginView;
    LoginView.backgroundColor=[UIColor whiteColor];
    LoginView.frame=CGRectMake(0, kScreen_Width/1.66, kScreen_Width, kScreen_Height-kScreen_Width/1.66);
    
    UITextField *phoneText = [[UITextField alloc]init];
   // phoneText.keyboardType = UIKeyboardTypeNumberPad;
    phoneText.delegate=self;
    self.userNameText=phoneText;
    [_LoginView addSubview:phoneText];
    phoneText.backgroundColor = [UIColor whiteColor];
    phoneText.layer.cornerRadius = 6.0;
    phoneText.placeholder = @"手机号/用户名";
    phoneText.leftViewMode = UITextFieldViewModeAlways;
    [phoneText autoSetDimension:ALDimensionHeight toSize:30];
    [phoneText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [phoneText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [phoneText autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:40];
    
    UIView *changePwdline=[[UIView alloc]init];
    changePwdline.backgroundColor=[UIColor colorWithHexString:@"0xf1f1f1"];
    [phoneText addSubview:changePwdline];
    [changePwdline autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:-4];
    [changePwdline autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [changePwdline autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [changePwdline autoSetDimension:ALDimensionHeight toSize:1];
    
    UITextField *pwdText = [[UITextField alloc]init];
    self.userPWDText=pwdText;
    pwdText.secureTextEntry = YES;
    pwdText.delegate=self;
    [_LoginView addSubview:pwdText];
    pwdText.backgroundColor = [UIColor whiteColor];
    pwdText.layer.cornerRadius = 6.0;
    pwdText.placeholder = @"请输入密码";
    pwdText.leftViewMode = UITextFieldViewModeAlways;
    [pwdText autoSetDimension:ALDimensionHeight toSize:30];
    [pwdText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [pwdText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [pwdText autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:changePwdline withOffset:30];
    
    UIView *Pwdline=[[UIView alloc]init];
    Pwdline.backgroundColor=[UIColor colorWithHexString:@"0xf1f1f1"];
    [pwdText addSubview:Pwdline];
    [Pwdline autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:-4];
    [Pwdline autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [Pwdline autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [Pwdline autoSetDimension:ALDimensionHeight toSize:1];
    
    
    
    /*登录按钮*/
    UIButton *loginBtn = [[UIButton alloc]init];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius = 6.0;
   // [loginBtn setTitleColor:[UIColor colorWithHexString:@"0xf0eff4"] forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:[UIColor whiteColor]];
    [_LoginView addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(loginSubmit) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn autoSetDimension:ALDimensionHeight toSize:40];
    [loginBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [loginBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:30];
    [loginBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:Pwdline withOffset:50];
    loginBtn.layer.borderColor=[UIColor grayColor].CGColor;
    loginBtn.layer.borderWidth=1.0;
    
    UIButton *forgetBtn=[[UIButton alloc]init];
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(forgetClick) forControlEvents:UIControlEventTouchUpInside];
    forgetBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [_LoginView addSubview:forgetBtn];
    [forgetBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [forgetBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:100];
    [forgetBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:100];
    [forgetBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:loginBtn withOffset:50];
    [forgetBtn autoSetDimension:ALDimensionHeight toSize:20];
    
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:14]};
    CGSize size=[@"忘记密码" sizeWithAttributes:attrs];
    UIView *lineview=[[UIView alloc]init];
    lineview.backgroundColor=[UIColor grayColor];
    [_LoginView addSubview:lineview];
    [lineview autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:forgetBtn withOffset:5];
    [lineview autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:(kScreen_Width-size.width)/2];
     [lineview autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:(kScreen_Width-size.width)/2];
    [lineview autoSetDimension:ALDimensionHeight toSize:1];

    
    return LoginView;
}
-(void)forgetClick{
    ForgetViewController *FV=[[ForgetViewController alloc]init];
    UINavigationController *nav_third = [[UINavigationController alloc] initWithRootViewController:FV];
    [self presentViewController:nav_third animated:NO completion:nil];
}
-(UIView *)setRegistView{
    UIView *RegistView=[[UIView alloc]init];
    self.RegistView=RegistView;
    RegistView.backgroundColor=[UIColor whiteColor];
    RegistView.frame=CGRectMake(0, kScreen_Width/1.66, kScreen_Width, kScreen_Height-kScreen_Width/1.66);
    
    
    UITextField *nameText = [[UITextField alloc]init];
    self.nickNameText=nameText;
    nameText.delegate=self;
    [_RegistView addSubview:nameText];
    nameText.backgroundColor = [UIColor whiteColor];
    nameText.layer.cornerRadius = 6.0;
    nameText.placeholder = @"请输入用户名";
    //    nameText.leftViewMode = UITextFieldViewModeAlways;
    [nameText autoSetDimension:ALDimensionHeight toSize:30];
    [nameText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [nameText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [nameText autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:40];
    
    UIView *nameline=[[UIView alloc]init];
    nameline.backgroundColor=[UIColor colorWithHexString:@"0xf1f1f1"];
    [nameText addSubview:nameline];
    [nameline autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:-4];
    [nameline autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [nameline autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [nameline autoSetDimension:ALDimensionHeight toSize:1];
    

    
    UITextField *phoneText = [[UITextField alloc]init];
    self.phoneNumText=phoneText;
    phoneText.keyboardType = UIKeyboardTypeNumberPad;
    phoneText.delegate=self;
    [RegistView addSubview:phoneText];
    phoneText.backgroundColor = [UIColor whiteColor];
    phoneText.layer.cornerRadius = 6.0;
    phoneText.placeholder = @"请输入手机号码";
    phoneText.leftViewMode = UITextFieldViewModeAlways;
    [phoneText autoSetDimension:ALDimensionHeight toSize:30];
    [phoneText autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [phoneText autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [phoneText autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:nameline withOffset:30];
    
    UIView *changePwdline=[[UIView alloc]init];
    changePwdline.backgroundColor=[UIColor colorWithHexString:@"0xf1f1f1"];
    [phoneText addSubview:changePwdline];
    [changePwdline autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:-4];
    [changePwdline autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [changePwdline autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [changePwdline autoSetDimension:ALDimensionHeight toSize:1];
    
    
    
    
    UITextField *vertifyText = [[UITextField alloc]init];
     self.vertifyText=vertifyText;
    vertifyText.keyboardType = UIKeyboardTypeNumberPad;
    vertifyText.delegate=self;
    [RegistView addSubview:vertifyText];
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
    [RegistView addSubview:VerifiBtn];
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
     self.passwordText=pwdText;
    pwdText.secureTextEntry = YES;
    pwdText.delegate=self;
    [RegistView addSubview:pwdText];
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

    /*登录按钮*/
    UIButton *registBtn = [[UIButton alloc]init];
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    registBtn.layer.cornerRadius = 6.0;
    [registBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [registBtn setBackgroundColor:[UIColor whiteColor]];
    [RegistView addSubview:registBtn];
    [registBtn addTarget:self action:@selector(registSubmit) forControlEvents:UIControlEventTouchUpInside];
    [registBtn autoSetDimension:ALDimensionHeight toSize:40];
    [registBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [registBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:30];
    [registBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:Pwdline withOffset:50];
    registBtn.layer.borderColor=[UIColor grayColor].CGColor;
    registBtn.layer.borderWidth=1.0;


    return RegistView;
}
-(void)registSubmit{
    [kNetManager toRegist:self.phoneNumText.text password:[self md5:self.passwordText.text] chkcode:self.vertifyText.text username:self.nickNameText.text Success:^(id responseObject) {
          NSLog(@"注册结果%@",responseObject);
        if ([responseObject[@"code"] integerValue]==1) {
            [DEFAULTS setObject:responseObject[@"data"][@"uid"] forKey:@"userId"];
            [DEFAULTS setObject:responseObject[@"data"][@"group_id"] forKey:@"role"];
            CYRootTabViewController *rootVC = [[CYRootTabViewController alloc] init];
            [self presentViewController:rootVC animated:NO completion:nil];

        }else{
            [JRToast showWithText:responseObject[@"msg"] duration:2.0];
        }
        
    } Failure:^(NSError *error) {
        
    }];
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
-(void)sendClick:(UIButton *)sender{
    if ([self.phoneNumText.text isEqualToString:@""]) {
        [JRToast showWithText:@"请输入手机号" duration:1.0];
        return;
    }
    [kNetManager getVerficode:self.phoneNumText.text Success:^(id responseObject) {
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    
//    if (textField == self.phoneNumText) {
//        if (string.length == 0)
//            return YES;
//        if (existedLength - selectedLength + replaceLength > 11) {
//            return NO;
//        }
//        
//    }else{
//        if (existedLength - selectedLength + replaceLength > 20) {
//            return NO;
//        }
//        
//    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 80; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}
-(void)loginSubmit{
    if (self.userNameText.text.length==0||self.userPWDText.text.length==0) {
        [JRToast showWithText:@"用户名和密码不能为空" duration:1.0];
        return;
    }
    [kNetManager getLogin:self.userNameText.text password:[self md5:self.userPWDText.text] Success:^(id responseObject) {
        NSLog(@"用户登录结果:%@",responseObject);
        if([responseObject[@"code"] integerValue]==1){
            [DEFAULTS setObject:responseObject[@"data"][@"uid"] forKey:@"userId"];
            [DEFAULTS setObject:responseObject[@"data"][@"group_id"] forKey:@"role"];
            CYRootTabViewController *rootVC = [[CYRootTabViewController alloc] init];
            [self presentViewController:rootVC animated:NO completion:nil];
        }else{
            [JRToast showWithText:responseObject[@"msg"] duration:1.0];
        }

    } Failure:^(NSError *error) {
        
    }];
    
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
