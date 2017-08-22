//
//  ChangePWDViewController.m
//  MangGuoProject
//
//  Created by lijunjie on 2017/6/16.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "ChangePWDViewController.h"

@interface ChangePWDViewController ()<BackBtnDelegate,UITextFieldDelegate>
@property(nonatomic,strong)UIButton *changeBtn;
@property(nonatomic,strong)UITextField *contentTextOne;
@property(nonatomic,strong)UITextField *contentTextTwo;
@property(nonatomic,strong)UITextField *contentTextThree;
@end

@implementation ChangePWDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"修改密码";
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
    UIView *backview=[[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreen_Width, 150)];
    backview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:backview];
    NSArray *nameArray=@[@"原密码",@"新密码",@"确认密码"];
    NSArray *contentArray=@[@"请输入原密码",@"请输入新密码",@"请再次输入密码"];
    for (int i=0; i<4; i++) {
        UIView *sepView=[[UIView alloc]initWithFrame:CGRectMake(0, 50*i, kScreen_Width, 1)];
        sepView.backgroundColor=[UIColor colorWithHexString:@"0xeeeeee"];
        [backview addSubview:sepView];
//        if (i!=3) {
//                }
        
    }
    UILabel *nameLabone=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 50)];
    nameLabone.font=[UIFont systemFontOfSize:16];
    nameLabone.text=nameArray[0];
    [backview addSubview:nameLabone];
    
    UITextField *contentTextOne=[[UITextField alloc]initWithFrame:CGRectMake(115, 0, kScreen_Width-125, 50)];
    _contentTextOne=contentTextOne;
    contentTextOne.delegate=self;
    contentTextOne.placeholder=contentArray[0];
    contentTextOne.secureTextEntry=YES;
    [backview addSubview:contentTextOne];
    
    UILabel *nameLabtwo=[[UILabel alloc]initWithFrame:CGRectMake(15, 50, 100, 50)];
    nameLabtwo.font=[UIFont systemFontOfSize:16];
    nameLabtwo.text=nameArray[1];
    [backview addSubview:nameLabtwo];
    
    UITextField *contentTextTwo=[[UITextField alloc]initWithFrame:CGRectMake(115, 50, kScreen_Width-125, 50)];
    _contentTextTwo=contentTextTwo;
    contentTextTwo.delegate=self;
    contentTextTwo.placeholder=contentArray[1];
    contentTextTwo.secureTextEntry=YES;
    [backview addSubview:contentTextTwo];

    
    UILabel *nameLabthree=[[UILabel alloc]initWithFrame:CGRectMake(15, 100, 100, 50)];
    nameLabthree.font=[UIFont systemFontOfSize:16];
    nameLabthree.text=nameArray[2];
    [backview addSubview:nameLabthree];
    
    UITextField *contentTextThree=[[UITextField alloc]initWithFrame:CGRectMake(115, 100, kScreen_Width-125, 50)];
    _contentTextThree=contentTextThree;
    contentTextThree.delegate=self;
    contentTextThree.placeholder=contentArray[1];
    contentTextThree.secureTextEntry=YES;
    [backview addSubview:contentTextThree];

    
    UIButton *changeBtn = [[UIButton alloc]init];
    [changeBtn setTitle:@"修改" forState:UIControlStateNormal];
    changeBtn.layer.cornerRadius = 6.0;
    // [loginBtn setTitleColor:[UIColor colorWithHexString:@"0xf0eff4"] forState:UIControlStateNormal];
    self.changeBtn=changeBtn;
    [changeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [changeBtn setBackgroundColor:[UIColor colorWithHexString:@"0xdadad9"]];
    [self.view addSubview:changeBtn];
    [changeBtn addTarget:self action:@selector(changeClick) forControlEvents:UIControlEventTouchUpInside];
    [changeBtn autoSetDimension:ALDimensionHeight toSize:40];
    [changeBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [changeBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:30];
    [changeBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:backview withOffset:50];
//    changeBtn.layer.borderColor=[UIColor grayColor].CGColor;
//    changeBtn.layer.borderWidth=1.0;
    /*隐藏键盘*/
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];

}
- (void)changeClick{
    if (![self.contentTextTwo.text isEqualToString:self.contentTextThree.text]) {
        showAlert(@"两次密码不同");
        return;
    }
    [kNetManager changePassword:[DEFAULTS objectForKey:@"userId"] password:[self md5:_contentTextOne.text] new_password:[self md5:_contentTextThree.text] Success:^(id responseObject) {
        NSLog(@"修改密码结果%@",responseObject);
        if ([responseObject[@"code"] integerValue]==1) {
            [self.navigationController popViewControllerAnimated:NO];
            [JRToast showWithText:@"密码修改成功" duration:2.0];
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

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    if (textField == self.contentTextTwo) {
        if (string.length == 0)
            return YES;
        if (existedLength - selectedLength + replaceLength > 18) {
            return NO;
        }
        
    }else{
        if (existedLength - selectedLength + replaceLength > 20) {
            return NO;
        }
        
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
      self.changeBtn.userInteractionEnabled=NO;
    if (self.contentTextOne.text.length>0&&self.contentTextTwo.text.length>0&&self.contentTextThree.text.length>0) {
        [self.changeBtn setBackgroundColor:[UIColor colorWithHexString:@"0x8fce47"]];
        self.changeBtn.userInteractionEnabled=YES;
    }else{
        [self.changeBtn setBackgroundColor:[UIColor colorWithHexString:@"0xdadad9"]];
      
    }

}

//- (void) animateTextField: (UITextField*) textField up: (BOOL) up
//{
//    const int movementDistance = 80; // tweak as needed
//    const float movementDuration = 0.3f; // tweak as needed
//    
//    int movement = (up ? -movementDistance : movementDistance);
//    
//    [UIView beginAnimations: @"anim" context: nil];
//    [UIView setAnimationBeginsFromCurrentState: YES];
//    [UIView setAnimationDuration: movementDuration];
//    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
//    [UIView commitAnimations];
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
