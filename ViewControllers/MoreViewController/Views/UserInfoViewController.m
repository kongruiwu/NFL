//
//  UserInfoViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/29.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoSettingCell.h"
#import "ShowMessageView.h"
#import "CropViewController.h"
#import "PhoneAboutViewController.h"
#import "ChangeAddresViewController.h"
#import "ThirdAccountViewController.h"
@interface UserInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) NSArray * titles;
@property (nonatomic, strong) NSArray * descs;

@property (nonatomic, strong) ShowMessageView * sexView;
@property (nonatomic, strong) ShowMessageView * brithView;
@property (nonatomic, strong) ShowMessageView * teamView;

@property (nonatomic, strong) UIImageView * userIcon;


@end

@implementation UserInfoViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawBackButton];
    [self setNavTitle:@"个人资料"];
    [self creatUI];
}
- (void)creatUI{
    
    self.titles = @[@[@"头像",@"用户名",@"性别",@"生日",@"城市",@"主队"],@[@"手机",@"密码"],@[@"第三方帐号绑定"]];
    self.descs = @[@[@"",@"汤姆布雷迪",@"设置",@"设置",@"设置",@"设置"],@[@"173****8962",@"设置"],@[@""]];
    
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT) style:UITableViewStyleGrouped delegate:self];
    [self.view addSubview:self.tabview];
    
    UIView * footer = [Factory creatViewWithColor:[UIColor clearColor]];
    footer.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(88));
    
    UIButton * logout = [Factory creatButtonWithTitle:@"退出登录"
                                      backGroundColor:Color_MainBlue
                                            textColor:[UIColor whiteColor]
                                             textSize:font750(32)];
    logout.layer.cornerRadius = Anno750(8);
    [footer addSubview:logout];
    [logout mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.right.equalTo(@(Anno750(-24)));
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    self.tabview.tableFooterView = footer;
    
    self.sexView = [[ShowMessageView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT) MessageType:MessageTypeSex];
    self.brithView = [[ShowMessageView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT) MessageType:MessageTypeBrithday];
    self.teamView = [[ShowMessageView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT) MessageType:MessageTypeTeam];
    
    [self.view addSubview:self.sexView];
    [self.view addSubview:self.brithView];
    [self.view addSubview:self.teamView];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titles.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * arr = self.titles[section];
    return arr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return Anno750(140);
    }else{
        return Anno750(100);
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return Anno750(20);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"UserInfoSettingCell";
    UserInfoSettingCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UserInfoSettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    BOOL rec = NO;
    if (indexPath.section == 0 && indexPath.row == 1) {
        rec = YES;
    }
    if (indexPath.section == 0 && indexPath.row == 0) {
        [cell updateUserIconWithTitle:self.titles[indexPath.section][indexPath.row]];
        self.userIcon = cell.userIcon;
    }else{
        [cell updateWithTitle:self.titles[indexPath.section][indexPath.row] desc:self.descs[indexPath.section][indexPath.row] hidden:rec];
    }
    
    if (indexPath.section == 2) {
        [cell updateThirdLogIcon];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if(indexPath.row == 0){
            [self uploadUserIcon];
        }else if (indexPath.row == 2) {
            [self changeUserSex];
        }else if(indexPath.row == 3){
            [self setUserBrithDay];
        }else if(indexPath.row == 5){
            [self changeTeamSetting];
        }else if(indexPath.row == 4){
            [self.navigationController pushViewController:[ChangeAddresViewController new] animated:YES];
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            PhoneAboutViewController  * vc = [[PhoneAboutViewController alloc]initWithType:ChangeTypeBindPhone];
            [self.navigationController pushViewController:vc animated:YES];
        }else if(indexPath.row == 1){
            PhoneAboutViewController  * vc = [[PhoneAboutViewController alloc]initWithType:ChangeTypeChangePwd];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        [self.navigationController pushViewController:[ThirdAccountViewController new] animated:YES];
    }
}
- (void)changeUserSex{
    [self.sexView show];
}
- (void)setUserBrithDay{
    [self.brithView show];
}
- (void)changeTeamSetting{
    [self.teamView show];
}

- (void)uploadUserIcon{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * cammer = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypeCamera;
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing=NO;
        picker.title = @"照片";
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:NULL];
    }];
    UIAlertAction * photo = [UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing=NO;
        picker.title = @"照片";
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:NULL];
    }];
    UIAlertAction *cannce = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    [alert addAction:cammer];
    [alert addAction:photo];
    [alert addAction:cannce];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo
{
    [self dismissViewControllerAnimated:NO completion:^{
        
        CropViewController * cropVC = [[CropViewController alloc] initWithNibName:@"CropViewController" bundle:nil];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:cropVC];
        cropVC.IMg = [self  imageCrop:image];
        __weak UserInfoViewController * blockSelf = self;
        cropVC.cropIMGBlock = ^(UIImage * img){
            //    上传图片的数据请求
            blockSelf.userIcon.image = img;
            [blockSelf uploadImagerequest:img];
        };
        [self presentViewController:nav animated:YES completion:nil];
        
        
        
    }];
}
- (void)uploadImagerequest:(UIImage *)image{
    
//    NSData *data = [KTFactory dealWithAvatarImage:image];
//    //判断图片是不是png格式的文件
//    NSString *mimeType = nil;
//    if (UIImagePNGRepresentation(image)) {
//        mimeType = @"image/png";
//    }else {
//        mimeType = @"image/jpeg";
//    }
//    NSString * datastr = [NSString stringWithFormat:@"data:%@;base64,%@",mimeType,[GTMBase64 stringByEncodingData:data]];
//    NSDictionary * params = @{
//                              @"icon":datastr
//                              };
//    [[NetWorkManager manager] POSTRequest:params pageUrl:Page_UserAvater complete:^(id result) {
//        [self dismissLoadingView];
//        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:@"头像上传成功" duration:1.0f];
//    } errorBlock:^(KTError *error) {
//        [self dismissLoadingView];
//        NSLog(@"%@",error.message);
//    }];
}
-(UIImage *) imageCrop:(UIImage *)sourceImage
{
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    BOOL ISWho = width>height;
    CGFloat targetWidth = ISWho? width*UI_WIDTH/height:UI_WIDTH;
    CGFloat targetHeight =  ISWho?UI_WIDTH: UI_WIDTH*height/width;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0,0,targetWidth,  targetHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@end
