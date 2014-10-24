//
//  ProfileCell.h
//  ACME-Shopping
//
//  Created by fady on 13-11-2.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileCell : UITableViewCell
{
    UIImageView *_imgView;
    UILabel *_titleLabel;
}

@property(nonatomic, copy)NSString *imgName;
@property(nonatomic, copy)NSString *title;

@end
