//
//  DetailViewController.m
//  ACME-Shopping
//
//  Created by fady on 13-10-29.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "DetailViewController.h"
#import "UIUtils.h"
#import "DetailModel.h"
#import "DetailTableView.h"
#import "ItemModel.h"
#import "SearchModel.h"
#import "ItemDB.h"
#import "PageModel.h"
#import "ShareViewController.h"
#import "ListModel.h"
#import "WebViewController.h"
#import "TalkViewController.h"
#import "ShopViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

/*
 
 module=itemService&digest=C37CCDB7076C0439EEFB9E6400E6924D&pid=mm_27400360_0_0&image_size=180&action=getItem&num_iid=17721075674
 
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    
    [super showLoadingInView:self.view];
    self.tableView.hidden = YES;
    
    [self _loadData];
}

-(void)setModel:(BaseModel *)model
{
    _model = model;
}

/*
 "link": {
 "action": "searchItems",
 "catName": "蕾丝衫/雪纺衫",
 "cid": "162116",
 "discount": "true",
 "key": "雪纺",
 "module": "itemService",
 "templates": "20,22,23"
 },
 */

-(void)_loadData
{
//    NSMutableDictionary *params = [UIUtils params:@"action" value:@"getItem"];
    
//    if (![self.model isKindOfClass:[ListModel class]]) {
        [self _loadLocationData];
        
        return;
//    } else {
    
//    }
    
    NSMutableDictionary *params = [UIUtils params:@"digest" value:@"0F25075BE9A926A1686DD2D736903C94"];
    
    [params setObject:@"getItem" forKey:@"action"];
    [params setObject:@"itemService" forKey:@"module"];
//    [params setObject:@"26923384540" forKey:@"num_iid"];
    
    NSString *itemId = @"26923384540";
    if (self.numId.length == 0) {
        if ([_model isKindOfClass:[PageModel class]]) {
            PageModel *model = (PageModel *)_model;
            itemId = model.itemId;
        }
        
        if ([_model isKindOfClass:[ListModel class]]) {
            ListModel *model = (ListModel *)_model;
            itemId = [model.num_iid stringValue];
        } else if ([_model isKindOfClass:[ItemModel class]]) {
            ItemModel *model = (ItemModel *)_model;
            itemId = [model.link objectForKey:@"itemid"];
        }
        
    } else {
        itemId = self.numId;
    }
    
    [params setObject:itemId forKey:@"num_iid"];
    
    //0F25075BE9A926A1686DD2D736903C94  C37CCDB7076C0439EEFB9E6400E6924D
    
    [params setObject:@"mm_27400360_0_0" forKey:@"pid"];
    [params setObject:@"180" forKey:@"image_size"];
    //26923384540 17721075674
    
    __weak DetailViewController *this = self;
    [ZZDataServier requestWithURL:@"" params:params httpMethod:@"POST" block:^(id result) {
        __strong DetailViewController *thisS = this;
        [thisS afterLoadData:result];
    }];
}

-(void)_loadLocationData
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"detail.json" ofType:nil];
    //    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:filePath];
    NSError *error;
    NSString *string = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    NSLog(@"%@", error);
    NSDictionary *result = [string JSONValue];
    
    [self afterLoadData:result];
}


-(void)afterLoadData:(NSDictionary *)result
{
    NSDictionary *item = [result objectForKey:@"item"];
    
    if (item == nil) {
        
        [super hiddenLoding];
        self.tableView.hidden = NO;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该物品应下架" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    DetailModel *model = [[DetailModel alloc] initWithDataDic:item];
    
    NSArray *itemRecommendList = [result objectForKey:@"itemRecommendList"];
    self.tableView.data = @[model, itemRecommendList];
    self.detailModel = model;
    
    [super hiddenLoding];
    self.tableView.hidden = NO;
    
    [self _loadRightItem];
    
    [self _loadTabbar];
    
    [self.tableView reloadData];
}

-(void)_loadRightItem
{
    //icon_feedback.png
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(0, 0, 35, 35);
    [shareButton setImage:[UIImage imageNamed:@"icon_feedback.png"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareAction) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    
    UIButton *loveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loveButton.frame = CGRectMake(0, 0, 35, 35);
    [loveButton setImage:[UIImage imageNamed:@"favorite.png"] forState:UIControlStateNormal];
    [loveButton setImage:[UIImage imageNamed:@"favorite_select.png"] forState:UIControlStateSelected];
    [loveButton addTarget:self action:@selector(loveAction:) forControlEvents: UIControlEventTouchUpInside];
    
    ItemDB *DB = [ItemDB shareDB];
    DetailModel *model = [DB findItem:self.detailModel.numIid];
    if (model != nil) {
        loveButton.selected = YES;
    }
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:loveButton];
    NSArray *rightItems = @[rightItem];
    self.navigationItem.rightBarButtonItems = rightItems;
}

-(void)_loadTabbar
{
    UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.height-49, kScreenWidth, 49)];
    backView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gray_background.png"]];
    backView.userInteractionEnabled = YES;
    [self.view addSubview:backView];
    
    float width = kScreenWidth/3;
    UIButton *wangwang = [UIButton buttonWithType:UIButtonTypeCustom];
    [wangwang setImage:[UIImage imageNamed:@"wangwang_not_online.png"] forState:UIControlStateNormal];
    wangwang.frame = CGRectMake((width-25)/2, (49-25)/2, 25, 25);
    [backView addSubview:wangwang];
    [wangwang addTarget:self action:@selector(wangwangAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *shop = [UIButton buttonWithType:UIButtonTypeCustom];
    shop.frame = CGRectMake(width + (width-25)/2, (49-25)/2, 25, 25);
    [shop setImage:[UIImage imageNamed:@"store.png"] forState:UIControlStateNormal];
    [backView addSubview:shop];
    [shop addTarget:self action:@selector(shopAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *car = [UIButton buttonWithType:UIButtonTypeCustom];
    car.frame = CGRectMake(width*2 + (width-25)/2, (49-25)/2, 25, 25);
    [car setImage:[UIImage imageNamed:@"shopping_cart.png"] forState:UIControlStateNormal];
    [backView addSubview:car];
    [car addTarget:self action:@selector(carAction) forControlEvents:UIControlEventTouchUpInside];
}

-(void)loveAction:(UIButton *)button
{
    ItemDB *DB = [ItemDB shareDB];
    
    if (!button.selected) {
        [DB addItem:self.detailModel];
    } else {
        [DB deleteItem:[NSString stringWithFormat:@"%@", self.detailModel.numIid]];
    }
    
    [DB findItems:^(NSArray *result) {
        
    }];
    
    button.selected = !button.selected;
}

-(void)shareAction
{
    ShareViewController *shareCtrl = [[ShareViewController alloc] init];
    shareCtrl.model = self.detailModel;
    [self.navigationController pushViewController:shareCtrl animated:YES];
}

-(void)wangwangAction
{
    NSString *urlstring = [NSString stringWithFormat:@"http://wangwang.wap.taobao.com/ww/wap_ww_dialog.htm?to_user=w8DKscPAv82%%2Bq8a3%%0A&sid=0849e1b0376dac7542df76fe565d10f4&returnUrl=http://auction1.wap.taobao.com/auction/item_detail&item_num_id=17134000328&ttid=215200%%40wht00180_android_1.2.0&ttid=215200%%40wht00180_android_1.2.0&sid=0849e1b0376dac7542df76fe565d10f4"];
    WebViewController *webView = [[WebViewController alloc] init];
    webView.url = urlstring;
    
    [self.navigationController pushViewController:webView animated:YES];
    
//    TalkViewController *talkCtrl = [[TalkViewController alloc] init];
//    [self.navigationController pushViewController:talkCtrl animated:YES];
}

-(void)shopAction
{
    ShopViewController *shopCtrl = [[ShopViewController alloc] init];
    shopCtrl.model = self.detailModel;
    [self.navigationController pushViewController:shopCtrl animated:YES];
}

-(void)carAction
{
    WebViewController *webViewCtrl = [[WebViewController alloc] init];
    webViewCtrl.url = @"http://h5.m.taobao.com/awp/base/cart.htm";
    webViewCtrl.title = @"我的收藏";
    [self.navigationController pushViewController:webViewCtrl animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
