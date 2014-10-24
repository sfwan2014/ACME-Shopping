//
//  DetailHeaderView.h
//  ACME-Shopping
//
//  Created by fady on 13-10-29.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PurchButton.h"
#import "DetailModel.h"

@interface DetailHeaderView : UIView

@property(nonatomic, strong)DetailModel *model;
@property(nonatomic, strong)NSArray *data;

@property (weak, nonatomic) IBOutlet UIView *pictureView;
@property (weak, nonatomic) IBOutlet UILabel *lovingLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *saleLabl;
@property (strong, nonatomic) IBOutlet PurchButton *purchButton;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
- (IBAction)buttonAction:(UIButton *)sender;


@end
