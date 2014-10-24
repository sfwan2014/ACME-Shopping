//
//  SendView.m
//  ACME-Shopping
//
//  Created by fady on 13-11-1.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "SendView.h"

@implementation SendView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    
    
}

- (IBAction)sendAction:(UIButton *)sender {
    
    [self.textField resignFirstResponder];
    NSString *text = self.textField.text;
    NSString *error = nil;
    if (text.length > 140) {
        error = @"字数超过140";
    } else if (text.length == 0){
        error = @"内容为空";
    }
    
    if (error.length > 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:error delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
        return;
    }
    
    if ([self.sendDelegate respondsToSelector:@selector(sendReplay:)]) {
        [self.sendDelegate sendReplay:text];
        self.textField.text = @"";
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

@end
