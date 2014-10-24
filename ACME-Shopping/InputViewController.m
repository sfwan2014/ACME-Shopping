//
//  InputViewController.m
//  ACME-Shopping
//
//  Created by fady on 13-10-30.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "InputViewController.h"
#import "ListViewController.h"

@interface InputViewController ()<UITextFieldDelegate>

@end

@implementation InputViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.textfield becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    [self.textfield becomeFirstResponder];
}

- (IBAction)searchButton:(UIButton *)sender {
    
    [self.textfield resignFirstResponder];
    NSString *result = self.textfield.text;
    ListViewController *listCtrl = [[ListViewController alloc] init];
    listCtrl.searchKey = result;
    listCtrl.title = result;
    [self.navigationController pushViewController:listCtrl animated:YES];
}
@end
