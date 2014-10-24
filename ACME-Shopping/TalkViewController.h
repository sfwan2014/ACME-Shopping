//
//  TalkViewController.h
//  ACME-Shopping
//
//  Created by fady on 13-11-16.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "BaseViewController.h"
#import "AsyncUdpSocket.h"

@interface TalkViewController : BaseViewController
{
    AsyncUdpSocket *_socket;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *ipLabel;
@property (weak, nonatomic) IBOutlet UITextField *portLabel;
@property (weak, nonatomic) IBOutlet UITextField *sendTextField;

@property (weak, nonatomic) IBOutlet UITextView *textView;
- (IBAction)connectAction:(UIButton *)sender;
- (IBAction)disConnectAction:(UIButton *)sender;
- (IBAction)sendAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *connectButton;

@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UIButton *disConnectButton;

@end
