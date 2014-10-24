//
//  TalkViewController.m
//  ACME-Shopping
//
//  Created by fady on 13-11-16.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "TalkViewController.h"
#import <ifaddrs.h>
#import <arpa/inet.h>

@interface TalkViewController ()

@end

@implementation TalkViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:view];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, kScreenHeight/2-40, kScreenWidth, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];
    
    label.text = @"正在开发中, 尽请期待";
    
    /*
    self.scrollView.contentSize = CGSizeMake(kScreenWidth, self.scrollView.height);
    self.scrollView.bounces = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [self getIPAddress];
     
     */
}

-(NSString *)getIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    
    int success= 0;
    
    success = getifaddrs(&interfaces);
    if (success == 0) {
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if (temp_addr->ifa_addr->sa_family == AF_INET) {
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);
    
    return address;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (IBAction)connectAction:(UIButton *)sender {
    
    if (_socket == nil) {
        _socket = [[AsyncUdpSocket alloc] initWithDelegate:self];
    }
    
    NSString *host = self.ipLabel.text;
    UInt16 port = [self.portLabel.text intValue];
    BOOL isConnect = [_socket connectToHost:host onPort:port error:nil];
    if (isConnect) {
        
        self.textView.text = @"连接成功";
        
        self.sendButton.enabled = YES;
        self.disConnectButton.enabled = YES;
        self.connectButton.enabled = NO;
    }
}

- (IBAction)disConnectAction:(UIButton *)sender {

}

- (IBAction)sendAction:(UIButton *)sender {
    NSString *text = self.sendTextField.text;
    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
    BOOL isSended = [_socket sendData:data withTimeout:60 tag:100];
    if (isSended) {
        NSLog(@"发送成功");
    }
}

- (void)onUdpSocket:(AsyncUdpSocket *)sock didSendDataWithTag:(long)tag
{
    NSLog(@"%ld", tag);
}

- (BOOL)onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port
{
    
    return YES;
}

-(void)keyboardAction:(NSNotification *)notification
{
    CGRect frame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.scrollView.height = self.scrollView.height - frame.size.height;
}

@end
