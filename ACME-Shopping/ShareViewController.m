//
//  ShareViewController.m
//  ACME-Shopping
//
//  Created by fady on 13-11-5.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "ShareViewController.h"
#import "PageModel.h"

@interface ShareViewController ()

@end

@implementation ShareViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*
 
 
 ****************** 空间*************
 获取用户在QQ空间的个人资料	get_simple_userinfo  不需要
 发表一条说说到QQ空间	add_topic	 需要，现在就申请
 发表一篇日志到QQ空间	add_one_blog	 需要，现在就申请
 创建一个QQ空间相册	add_album	 需要，现在就申请
 上传一张照片到QQ空间相册	upload_pic	 需要，现在就申请
 获取用户QQ空间相册列表	list_album	 需要，现在就申请
 获取安装了移动应用的好友信息	get_app_friends （仅支持移动应用调用） 需要，现在就申请
 同步分享到QQ空间、腾讯微博	add_share	 不需要
 验证是否认证空间粉丝	check_page_fans	 不需要
 
 ***************微博*******************
 发表一条微博信息到腾讯微博	add_t	 不需要
 上传图片并发表消息到腾讯微博	add_pic_t	 不需要
 删除一条微博信息	del_t	 不需要
 获取一条微博的转播或评论信息列表	get_repost_list	 不需要
 获取登录用户自己的详细信息	get_info	 不需要
 获取其他用户的详细信息	get_other_info	 不需要
 获取登录用户的听众列表	get_fanslist	 不需要
 获取登录用户的收听列表	get_idollist	 不需要
 收听腾讯微博上的用户	add_idol	 不需要
 取消收听腾讯微博上的用户	del_idol	 不需要
 
 财付通	 获取用户在财付通的收货地址	get_tenpay_addr	 需要，现在就申请
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 100266567
	//100349529 我的
	tencentOAuth = [[TencentOAuth alloc] initWithAppId:APP_ID andDelegate:self];
	tencentOAuth.redirectURI = @"www.qq.com";
	permissions = [NSArray arrayWithObjects:@"get_simple_userinfo",@"add_topic",@"add_one_blog",@"add_album",@"upload_pic",@"list_album",@"get_app_friends",@"add_share",@"check_page_fans",@"add_t",@"add_pic_t",@"del_t",@"get_repost_list",@"get_info",@"get_other_info",@"get_fanslist",@"get_idollist",@"add_idol",@"del_idol", nil];
    
    
	// Do any additional setup after loading the view.
	
	//arrFunctions = [NSArray arrayWithObjects:@"获取用户在QQ空间的个人资料",@"发表一条说说到QQ空间(X)",@"发表一篇日志到QQ空间(X)",@"创建一个QQ空间相册(X)",@"上传一张照片到QQ空间相册(X)",@"获取用户QQ空间相册列表(X)",@"获取安装了移动应用的好友信息(X)",@"同步分享到QQ空间、腾讯微博",@"验证是否认证空间粉丝",@" 发表一条微博信息到腾讯微博",@"上传图片并发表消息到腾讯微博",@"删除一条微博信息",@"获取一条微博的转播或评论信息列表",@"获取登录用户自己的详细信息",@"获取其他用户的详细信息",@"获取登录用户的听众列表",@"获取登录用户的收听列表",@"收听腾讯微博上的用户",@"取消收听腾讯微博上的用户", nil];
//	arrFunctions = [NSArray arrayWithObjects:@"获取用户在QQ空间的个人资料",@"发表一条说说到QQ空间(X)",@"发表一篇日志到QQ空间(X)",@"创建一个QQ空间相册(X)",@"上传一张照片到QQ空间相册(X)",@"获取用户QQ空间相册列表(X)",@"get List photo",@"同步分享到QQ空间、腾讯微博",@"验证是否认证空间粉丝", nil];
	arrFunctions = [NSArray arrayWithObjects:@"分享到QQ空间", nil];
	btnClick = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	btnClick.frame = CGRectMake(10, 5, 300, 40);
	if (tencentOAuth.isSessionValid) {
        [btnClick setTitle:@"登录成功" forState:UIControlStateNormal];
    } else {
        [btnClick setTitle:@"登录验证" forState:UIControlStateNormal];
    }
	[btnClick addTarget:self action:@selector(onClickTencentOAuth) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:btnClick];
	
	tblView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, 320, 376) style:UITableViewStylePlain];
	tblView.delegate = self;
	tblView.dataSource = self;
	tblView.contentSize = CGSizeMake(320, 500);
	[self.view addSubview:tblView];
}

- (void)onClickTencentOAuth
{
	[tencentOAuth authorize:permissions inSafari:NO];
}


#pragma mark 登录登出

// 登录
- (void)tencentDidLogin
{
	[btnClick setTitle:@"登录成功" forState:UIControlStateNormal];
}

// 登出
- (void)tencentDidLogout
{
	
}

// 取消登录
- (void)tencentDidNotLogin:(BOOL)cancelled
{
	
}

// 网络不好
- (void)tencentDidNotNetWork
{
	
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return arrFunctions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"identifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (nil == cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
	}
	cell.textLabel.text = [NSString stringWithFormat:@"%@",[arrFunctions objectAtIndex:indexPath.row]];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
    if (indexPath.row == 0) {
        [self onClickAddShare];
    }
    
    /*switch (indexPath.row) {
     
		case 0:
        {
            [self onClickGetUserInfo];
        }
			break;
		case 1:
        {
            [self onClickAddTopic];
        }
			break;
		case 2:
        {
            [self onClickAddBlog];
        }
			break;
		case 3:
        {
            [self onClickAddAlbum];
        }
			break;
		case 4:
        {
            [self onClickUploadPic];
        }
			break;
		case 5:
        {
            [self onClickListAlbum];
        }
			break;
		case 6:
		{
            [self onClickGetListPhoto];
		}
			break;
		case 7:
        {
            [self onClickAddShare];
        }
			break;
		case 8:
		{
            [self onCLickCheckans];
		}
			break;
		case 9:
		{}
			break;
		case 10:
		{}
			break;
		case 11:
		{}
			break;
		case 12:
		{}
			break;
		case 13:
		{}
			break;
			
		default:
			break;
	}*/
}

// 获取个人信息
- (void)onClickGetUserInfo
{
	[tencentOAuth getUserInfo];
}

// 获取个人信息完成
- (void)getUserInfoResponse:(APIResponse *)response
{
	if (response.retCode == URLREQUEST_SUCCEED) {
		NSLog(@"用户信息: %@",response.jsonResponse);
        //		for (id key in response.jsonResponse) {
        //			NSLog(@"用户信息: %@",key);
        //		}
	}
}

// 发表一条说说到QQ空间
- (void)onClickAddTopic
{
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"add topic 接口测试",@"con",@"3",@"richtype",@"http://www.tudou.com/programs/view/C0FuB0FTv50/",@"richval",@"广东省深圳市南山区高新科技园腾讯大厦",@"lbs_nm",@"2",@"third_source", nil];
	[tencentOAuth addTopicWithParams:params];
}

- (void)addTopicResponse:(APIResponse *)response
{
	if (response.retCode == URLREQUEST_SUCCEED) {
		NSLog(@"发表一条说说:%@",response.jsonResponse);
	}
}

// 发表一篇日志到QQ空间
- (void)onClickAddBlog
{
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"IOS日志测试",@"title",@"哈哈，测试成功",@"content", nil];
	[tencentOAuth addOneBlogWithParams:params];
}

- (void)addOneBlogResponse:(APIResponse *)response
{
	if (response.retCode == URLREQUEST_SUCCEED)
    {
		NSLog(@"发表日志到QQ空间:%@",response.jsonResponse);
    }
}

// 创建一个QQ空间相册
- (void)onClickAddAlbum
{
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"IOS接口创建相册测试",@"albumname",@"我的测试相册",@"albumdesc",@"1",@"priv", nil];
	[tencentOAuth addAlbumWithParams:params];
}

- (void)addAlbumResponse:(APIResponse *)response
{
	if (response.retCode == URLREQUEST_SUCCEED)
	{
        NSLog(@"创建空间相册:%@",response.jsonResponse);
	}
}

// 上传一张照片到QQ空间相册
- (void)onClickUploadPic
{
	NSString *path = @"http://img1.gtimg.com/tech/pics/hv1/95/153/847/55115285.jpg";
	NSURL *url = [NSURL URLWithString:path];
	NSData *data = [NSData dataWithContentsOfURL:url];
	UIImage *img = [[UIImage alloc] initWithData:data];
	
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:img,@"picture",@"目的相册ID",@"albumid",@"jobs",@"title",@"天皇巨星",@"photodesc", nil];
	[tencentOAuth uploadPicWithParams:params];
}

- (void)uploadPicResponse:(APIResponse *)response
{
	if (response.retCode == URLREQUEST_SUCCEED) {
		NSLog(@"上传照片到空间相册:%@",response.jsonResponse);
	}
}


// 获取用户QQ空间相册列表
- (void)onClickListAlbum
{
	[tencentOAuth getListAlbum];
}

- (void)getListAlbumResponse:(APIResponse *)response
{
	if (response.retCode == URLREQUEST_SUCCEED) {
		NSLog(@"相册列表: %@",response.jsonResponse);
	}
	
}

// 获取安装了移动应用的好友信息
// Get List photo
- (void)onClickGetListPhoto
{
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"123",@"albumid", nil];
	[tencentOAuth getListPhotoWithParams:params];
}

- (void)getListPhotoResponse:(APIResponse *)response
{
	if (response.retCode == URLREQUEST_SUCCEED) {
		NSLog(@"get list photo: %@",response.jsonResponse);
	}
}


// 同步分享到QQ空间、腾讯微博
- (void)onClickAddShare
{
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_model.title forKey:@"title"];
    [params setObject:_model.wapDetailUrl forKey:@"url"];
    [params setObject:@"免费打广告啊" forKey:@"comment"];
    [params setObject:@"呵呵" forKey:@"summary"];
    
    NSArray *images = _model.itemImgs;
    NSString *imageNames = [images componentsJoinedByString:@","];
    
    [params setObject:imageNames forKey:@"images"];
    [params setObject:@"4" forKey:@"source"];
    
	[tencentOAuth addShareWithParams:params];
}

- (void)addShareResponse:(APIResponse *)response
{
	if (response.retCode == URLREQUEST_SUCCEED)
	{
        NSLog(@"同步分享: %@",response.jsonResponse);
        
	}
}

// 验证是否认证空间粉丝
- (void)onCLickCheckans
{
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"1731696797",@"page_id", nil];
	[tencentOAuth checkPageFansWithParams:params];
}

- (void)checkPageFansResponse:(APIResponse *)response
{
	if (response.retCode == URLREQUEST_SUCCEED)
	{
        NSLog(@"验证空间粉丝: %@",response.jsonResponse);
	}
}

// 发表一条微博信息到腾讯微博

// 上传图片并发表消息到腾讯微博

//删除一条微博信息

// 获取一条微博的转播或评论信息列表

// 获取登录用户自己的详细信息

// 获取其他用户的详细信息

// 获取登录用户的听众列表

// 获取登录用户的收听列表

// 收听腾讯微博上的用户

// 取消收听腾讯微博上的用户



















- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
