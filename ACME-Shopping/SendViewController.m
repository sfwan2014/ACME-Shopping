//
//  SendViewController.m
//  ACME-Shopping
//
//  Created by fady on 13-11-4.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "SendViewController.h"
#import "ZoomImageView.h"
#import "LovingViewController.h"
#import "DetailModel.h"

@interface SendViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, ZoomImageViewDelegate>

@end

@implementation SendViewController
{
    ZoomImageView *_selectImgView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self _loadNavigationItem];
    
    self.textView.delegate = self;
}

-(void)_loadNavigationItem
{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 35, 35);
    [rightButton setImage:[UIImage imageNamed:@"icon_submit.png"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)sendAction:(UIButton *)button
{
    NSString *text = self.textView.text;
    
    NSString *error = nil;
    
    if (text.length == 0) {
        error = @"亲, 最少输入4个字哦";
    } else if (text.length > 140) {
        error = @"亲, 最多输入140个字哦";
    }
    
    if (error != nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:error delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    NSMutableDictionary *params = [UIUtils params:@"action" value:@"publishThread"];
    [params setObject:text forKey:@"content"];
    [params setObject:@"636EEC3D73FB5FD62795F3D84B5E57C5" forKey:@"digest"];
    [params setObject:@"IdsVp" forKey:@"ecode"];
    [params setObject:@"groupService" forKey:@"module"];
    [params setObject:@"afdd67341e538672330c2668dd8f66cc" forKey:@"sid"];
    
    NSString *type = @"1";
    if (self.sendImg != nil) {
        type = @"3";
    }
    [params setObject:type forKey:@"type"];
    
    if (self.typeContent != nil) {
        [params setObject:self.typeContent forKey:@"typeContent"];
    }
    
    [params setObject:@"1858718825" forKey:@"userId"];
    
    __weak SendViewController *this = self;
    [ZZDataServier requestWithURL:@"" params:params httpMethod:@"POST" block:^(id result) {
        NSLog(@"%@", result);
        __strong SendViewController *strong = this;
        [strong.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)keyboardNotification:(NSNotification *)notifation
{
    NSDictionary *userInfo = notifation.userInfo;
    CGRect frame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.textView.height = self.view.height - frame.size.height - self.backView.height;
        self.backView.top = self.textView.bottom;
    }];
}

- (void)textViewDidChange:(UITextView *)textView
{
    int count = self.textView.text.length;
    self.countLabel.text = [NSString stringWithFormat:@"%d/140", count];
}

- (IBAction)openAlbumAction:(UIButton *)sender {
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.sourceType = sourceType;
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:NULL];
}

- (IBAction)takePhotoAction:(UIButton *)sender {
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    if (!isCamera) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"无摄像头" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:NULL, nil];
        
        [alert show];
        return;
    }
    
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.sourceType = sourceType;
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:NULL];
}

- (IBAction)openLovingAction:(UIButton *)sender {
    
    [self.textView resignFirstResponder];
    
    LovingViewController *lovingCtrl = [[LovingViewController alloc] init];
    lovingCtrl.isDelete = NO;
    lovingCtrl.ishomeButton = NO;
    __weak LovingViewController *that = lovingCtrl;
    __weak SendViewController *this = self;
    lovingCtrl.block = ^(UIImage *image, DetailModel *model){
        __strong SendViewController *strong = this;
        __strong LovingViewController *strong1 = that;
        [strong loadImage:image];
        [strong loadModel:model];
        [strong1.navigationController popViewControllerAnimated:YES];
    };
    [self.navigationController pushViewController:lovingCtrl animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    [self loadImage:image];
}

-(void)loadImage:(UIImage *)image
{
    if (_selectImgView ==nil) {
        _selectImgView = [[ZoomImageView alloc] initWithFrame:CGRectMake(135, 5, 30, 30)];
        _selectImgView.delegate = self;
        _selectImgView.layer.cornerRadius = 5;
        _selectImgView.layer.masksToBounds = YES;
        [_selectImgView addZoom:nil];
    }
    
    if (_selectImgView.superview == nil) {
        [self.backView addSubview:_selectImgView];
    }
    
    _selectImgView.image = image;
    
    // 3.移动编辑按钮
    
    // 4. 图片数据
    self.sendImg = image;
}

-(void)loadModel:(DetailModel *)model
{
    _typeContent = [model.numIid stringValue];
}

@end
