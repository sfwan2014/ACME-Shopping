//
//  InputViewController.h
//  ACME-Shopping
//
//  Created by fady on 13-10-30.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "BaseViewController.h"

@interface InputViewController : BaseViewController

- (IBAction)searchButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *textfield;


@end
