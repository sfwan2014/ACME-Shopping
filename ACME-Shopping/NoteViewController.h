//
//  NoteViewController.h
//  ACME-Shopping
//
//  Created by fady on 13-11-1.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "BaseViewController.h"

@class ReplyTableView;
@class SendView;
@class CircleModel;
@interface NoteViewController : BaseViewController
{
    __strong SendView *sendView;
}

@property (weak, nonatomic) IBOutlet ReplyTableView *tableView;
@property (nonatomic, strong)CircleModel *model;
@property(nonatomic, assign)int pageIndex;

@end
