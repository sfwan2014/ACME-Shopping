//
//  SendView.h
//  ACME-Shopping
//
//  Created by fady on 13-11-1.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SendReplyDelegate <NSObject>

-(void)sendReplay:(NSString *)text;

@end

@interface SendView : UIView<UITextFieldDelegate>

@property(nonatomic, weak)id<SendReplyDelegate>sendDelegate;

@property (weak, nonatomic) IBOutlet UITextField *textField;
- (IBAction)sendAction:(UIButton *)sender;
@end
