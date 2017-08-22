//
//  ChangeUserInfoViewController.m
//  MangGuoProject
//
//  Created by lijunjie on 2017/6/22.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "ChangeUserInfoViewController.h"
#import "XDAlertController.h"
#import <MobileCoreServices/MobileCoreServices.h>
@interface ChangeUserInfoViewController ()<BackBtnDelegate>
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *iconImg;
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *sex;
@property(nonatomic,strong)UIImageView *waiView;
@property(nonatomic,strong)UITextField *nickText;
@property(nonatomic,strong)UITextField *phoneText;
@property(nonatomic,strong)UIButton *manBtn;
@property(nonatomic,strong)UIButton *womanBtn;
@property(nonatomic,strong)NSString *headImageString;
@end

@implementation ChangeUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"个人信息";
    BackBtn *backbtn=[[BackBtn alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    backbtn.delegate=self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backbtn];
    self.view.backgroundColor=[UIColor colorWithHexString:@"0xf0eff4"];
    [self getUserData];
}
-(void)getUserData{
    [kNetManager getUserIndexData:[DEFAULTS objectForKey:@"userId"] Success:^(id responseObject) {
        NSLog(@"用户信息：%@",responseObject);
        if([responseObject[@"code"] integerValue]==1){
            _userName=responseObject[@"data"][@"username"];
            _iconImg=responseObject[@"data"][@"logo_image"];
            _mobile=responseObject[@"data"][@"mobile"];
            _sex=responseObject[@"data"][@"sex"];
           [self setUI];
        }else{
            [JRToast showWithText:responseObject[@"msg"] duration:1.0];
        }
    } Failure:^(NSError *error) {
        
    }];
}
-(void)setUI{
    
    UIView *bottomView=[[UIView alloc]init];
    bottomView.backgroundColor=[UIColor whiteColor];
    bottomView.frame=CGRectMake(0, 25, kScreen_Width, 50);
    [self.view addSubview:bottomView];
    
    
    UILabel *nameLab=[[UILabel alloc]initWithFrame:CGRectMake(20,0, 100, 50)];
    nameLab.text=@"头像";
    [bottomView addSubview:nameLab];
    
    UIImageView *waiView=[[UIImageView alloc]initWithFrame:CGRectMake(kScreen_Width-80, 5,40, 40)];
    self.waiView=waiView;
    [waiView sd_setImageWithURL:[NSURL URLWithString:_iconImg]];
    waiView.clipsToBounds=YES;
    waiView.layer.cornerRadius=20;
    [bottomView addSubview:waiView];

    
    UIButton *moreBtn=[[UIButton alloc]init];
    [moreBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(changeIcon) forControlEvents:UIControlEventTouchUpInside];
    moreBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [bottomView addSubview:moreBtn];
    [moreBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [moreBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [moreBtn autoSetDimensionsToSize:CGSizeMake(kScreen_Width-10, 50)];

    
    NSArray *nameArray=@[@"用户名",@"性别",@"手机号"];
    UIView *middleTwoView=[[UIView alloc]init];
    middleTwoView.backgroundColor=[UIColor whiteColor];
    middleTwoView.frame=CGRectMake(0, 95, kScreen_Width, 150);
    [self.view addSubview:middleTwoView];
    for (int i=0; i<3; i++) {
        UIView *sepview=[[UIView alloc]initWithFrame:CGRectMake(0, 50*i, kScreen_Width, 1)];
        sepview.backgroundColor=[UIColor colorWithHexString:@"0xf0eff4"];
        [middleTwoView addSubview:sepview];
        
        UILabel *nameLab=[[UILabel alloc]initWithFrame:CGRectMake(20, i*50, 90, 50)];
        nameLab.text=nameArray[i];
        [middleTwoView addSubview:nameLab];
        
        if (i==1) {
            UIButton *manBtn=[[UIButton alloc]initWithFrame:CGRectMake(100, 69, 12, 12)];
            self.manBtn=manBtn;
            manBtn.tag=1;
            [manBtn addTarget:self action:@selector(selectSex:) forControlEvents:UIControlEventTouchUpInside];
            [middleTwoView addSubview:manBtn];
            
            UILabel *manLabel=[[UILabel alloc]initWithFrame:CGRectMake(122, 50, 15, 50)];
            manLabel.text=@"男";
            [middleTwoView addSubview:manLabel];

            UIButton *womanBtn=[[UIButton alloc]initWithFrame:CGRectMake(152, 69, 12, 12)];
            self.womanBtn=womanBtn;
            womanBtn.tag=2;
            [womanBtn addTarget:self action:@selector(selectSex:) forControlEvents:UIControlEventTouchUpInside];
            [middleTwoView addSubview:womanBtn];
            
            UILabel *womanLabel=[[UILabel alloc]initWithFrame:CGRectMake(174, 50, 15, 50)];
            womanLabel.text=@"女";
            [middleTwoView addSubview:womanLabel];
            
            if ([_sex isEqualToString:@"男"]) {
                 [manBtn setBackgroundImage:[UIImage imageNamed:@"对号"] forState:UIControlStateNormal];
                    manBtn.selected=YES;
                 [womanBtn setBackgroundImage:[UIImage imageNamed:@"圆圈"] forState:UIControlStateNormal];
                    womanBtn.selected=NO;
            }else{
                [womanBtn setBackgroundImage:[UIImage imageNamed:@"对号"] forState:UIControlStateNormal];
                  womanBtn.selected=YES;
                [manBtn setBackgroundImage:[UIImage imageNamed:@"圆圈"] forState:UIControlStateNormal];
                 manBtn.selected=NO;
            }


        }
    }
    UITextField *nickText=[[UITextField alloc]initWithFrame:CGRectMake(100, 0, kScreen_Width-100, 50)];
    self.nickText=nickText;
    nickText.text=_userName;
    [middleTwoView addSubview:nickText];

    UITextField *phoneText=[[UITextField alloc]initWithFrame:CGRectMake(100, 100, kScreen_Width-100, 50)];
    self.phoneText=phoneText;
    phoneText.text=_mobile;
    [middleTwoView addSubview:phoneText];

    
    
    UIButton *logoutBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 310, kScreen_Width, 50)];
    [logoutBtn setBackgroundColor:[UIColor whiteColor]];
    [logoutBtn setTitle:@"完成" forState:UIControlStateNormal];
    [logoutBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [logoutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:logoutBtn];
    
}
-(void)submit{
    //  NSLog(@"%ld-------%ld",_manBtn.selected,_womanBtn.selected);
    if (self.nickText.text.length==0) {
        showAlert(@"请输入用户名");
        return;
    }
    if (self.phoneText.text.length==0) {
        showAlert(@"请输入手机号");
        return;
    }
    NSString *sex;
    if (_manBtn.selected==YES) {
        sex=@"男";
    }else{
        sex=@"女";
    }
    NSLog(@"sex：%@---%@",sex,[DEFAULTS objectForKey:@"userId"]);
    if (!_headImageString||_headImageString.length==0) {
        self.headImageString=@"";
    }
    [kNetManager changeUserInfo:[DEFAULTS objectForKey:@"userId"] imgstr:self.headImageString username:_nickText.text sex:sex mobile:_phoneText.text Success:^(id responseObject) {
        NSLog(@"修改个人信息%@",responseObject);
        if ([responseObject[@"code"] intValue]==1) {
            [ZZLProgressHUD showHUDWithMessage:@"正在修改"];
            [self performSelectorOnMainThread : @selector (clearCachSuccess) withObject : nil waitUntilDone : YES ];

        }
    } Failure:^(NSError *error) {
        
    }];

}
-(void)clearCachSuccess{
    [ZZLProgressHUD popHUD];
    [JRToast showWithText:@"修改成功" duration:2.0];
     [[NSNotificationCenter defaultCenter] postNotificationName:@"toFreshs" object:nil userInfo:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)selectSex:(UIButton *)sender{
   
    if (sender.tag==1) {
        [_manBtn setBackgroundImage:[UIImage imageNamed:@"对号"] forState:UIControlStateNormal];
        _manBtn.selected=YES;
        [_womanBtn setBackgroundImage:[UIImage imageNamed:@"圆圈"] forState:UIControlStateNormal];
        _womanBtn.selected=NO;
        
    }else{
        [_womanBtn setBackgroundImage:[UIImage imageNamed:@"对号"] forState:UIControlStateNormal];
        _womanBtn.selected=YES;
        [_manBtn setBackgroundImage:[UIImage imageNamed:@"圆圈"] forState:UIControlStateNormal];
        _manBtn.selected=NO;

    }
     NSLog(@"%ld-------%ld",_manBtn.selected,_womanBtn.selected);
}
-(void)goback{
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)changeIcon{
        XDAlertController *alert = [XDAlertController alertControllerWithTitle:@"修改头像" message:nil preferredStyle:XDAlertControllerStyleActionSheet];
        XDAlertAction *action1 = [XDAlertAction actionWithTitle:@"从相册获取" style: XDAlertActionStyleDefault handler:^( XDAlertAction * _Nonnull action) {
    
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }];
        XDAlertAction *action2 = [XDAlertAction actionWithTitle:@"拍照" style: XDAlertActionStyleDefault handler:^( XDAlertAction * _Nonnull action) {
    
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }];
    
        XDAlertAction *action3 = [XDAlertAction actionWithTitle:@"取消" style:XDAlertActionStyleCancel handler:^(XDAlertAction * _Nonnull action) {
    
        }];
        [alert addAction:action1];
        [alert addAction:action2];
        [alert addAction:action3];
    
        [self presentViewController:alert animated:YES completion:nil];
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeImage]) {
        UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
        [self performSelector:@selector(saveImage:)  withObject:img afterDelay:0.5];
    }
    else if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeMovie]) {
        
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)saveImage:(UIImage *)image {
    // 对于base64编码编码
    NSString *headImageString=[self UIImageToBase64Str:image];
    _headImageString=headImageString;
    _waiView.image=image;
//    [kNetManager changeUserIcon:[DEFAULTS objectForKey:@"userId"] imgstr:headImageString Success:^(id responseObject) {
//        NSLog(@"头像上传成功%@",responseObject);
//        if ([responseObject[@"code"] integerValue]==1) {
//            _waiView.image=image;
//        }
//        
//    } Failure:^(NSError *error) {
//        NSLog(@"%@",error);
//        
//    }];
    
}
-(NSString *)UIImageToBase64Str:(UIImage *) image
{
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return encodedImageStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
