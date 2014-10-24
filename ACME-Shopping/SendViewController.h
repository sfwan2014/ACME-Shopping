//
//  SendViewController.h
//  ACME-Shopping
//
//  Created by fady on 13-11-4.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "BaseViewController.h"

@interface SendViewController : BaseViewController<UITextViewDelegate, UITextFieldDelegate>

@property(nonatomic, strong)UIImage *sendImg;
@property(nonatomic, copy)NSString *typeContent;

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIView *backView;
- (IBAction)openAlbumAction:(UIButton *)sender;
- (IBAction)takePhotoAction:(UIButton *)sender;
- (IBAction)openLovingAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end
