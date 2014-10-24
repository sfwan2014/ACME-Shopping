//
//  MainViewController.m
//  ZZUNIQLO
//
//  Created by fady on 13-10-22.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property(nonatomic, strong)UIView *backgroundView;
@property(nonatomic, strong)UIImageView *backImageView;

@end

@implementation MainViewController

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

    _backImageViews = [[NSMutableDictionary alloc] initWithCapacity:5];
    self.view.backgroundColor = [UIColor clearColor];
    [self _initTabbar];
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    documentPath = [documentPath stringByAppendingPathComponent:@"database.sqlite"];
    
//    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"database.sqlite"];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if (![fm fileExistsAtPath:documentPath]) {
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"database.sqlite" ofType:Nil];
        NSError *error = nil;
        if ([fm copyItemAtPath:sourcePath toPath:documentPath error:&error]) {
            NSLog(@"复制完成!");
        }
        
        NSLog(@"%@",error);
        
    }else {
        NSLog(@"存在");
    }
}

-(void)_initTabbar
{
    self.tabBar.hidden = YES;
    
    _tabbarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 44, kScreenWidth, 49)];
    _tabbarView.opaque = YES;
    _tabbarView.userInteractionEnabled = YES;
    _tabbarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"title_bg.png"]];
    [self.view addSubview:_tabbarView];
    
    NSArray *selectedImages = @[@"tab_home_select.png",
                                @"main_search_select.png",
                                @"tab_quanzi_select.png",
                                @"tab_user_unit_select.png",
                                @"tab_more_select.png"];
    
    NSArray *imgNames =          @[@"tab_home.png",
                                   @"main_search.png",
                                   @"tab_quanzi.png",
                                   @"tab_user_unit.png",
                                   @"tab_more.png"];
    
    
    float width = kScreenWidth/5;
    for (int i = 0; i < imgNames.count; i++) {
        NSString *imageName  =imgNames[i];
        NSString *selectedName = selectedImages[i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*width + (width - 37)/2, (49-32)/2, 37, 35);
        button.tag = i;
        
        if (i == 0) {
            _lastButton = button;
            _lastButton.selected = YES;
        }
        UIImage *image = [UIImage imageNamed:imageName];
//        image = [self scaleToSize:image size:CGSizeMake(25, 23)];
        
        UIImage *selectImg = [UIImage imageNamed:selectedName];
//        selectImg = [self scaleToSize:selectImg size:CGSizeMake(25, 23)];
        
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button setBackgroundImage:selectImg forState:UIControlStateSelected];
        button.contentMode = UIViewContentModeScaleAspectFit;

//        [button setImage:image forState:UIControlStateNormal];
//        [button setImage:selectImg forState:UIControlStateSelected];
        
        [button addTarget:self action:@selector(tabBarAction:) forControlEvents:UIControlEventTouchUpInside];
        [_tabbarView addSubview:button];
    }
    
    // 下标视图
    UIImageView *indexView = [[UIImageView alloc] initWithFrame:CGRectMake((width - 14)/2 +1, 49-7, 14, 7)];
    indexView.image = [UIImage imageNamed:@"menu_index.png"];
    indexView.tag = 2013;
    [_tabbarView addSubview:indexView];
}

- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

#pragma mark - tabBarAction
-(void)tabBarAction:(UIButton *)button
{
    
    if (_lastButton != button) {
        UIImage *capture = [self capture];
        
        NSString *key = [NSString stringWithFormat:@"%ld", (long)_lastButton.tag];
        if (capture != nil) {
            
            [_backImageViews setObject:capture forKey:key];
        }
        
        UIView *indexView = [_tabbarView viewWithTag:2013];
        indexView.left = button.left + button.width / 2 - 5;
        indexView.bottom = 49;
        self.selectedIndex = button.tag;
        
        if (self.backImageView == nil) {
            CGRect frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
            
            self.backImageView = [[UIImageView alloc] initWithFrame:frame];
        }
        
        if (self.backImageView.superview == nil) {
            [self.view insertSubview:self.backImageView belowSubview:self.view];
        }
        
        UIImage *image = [_backImageViews objectForKey:key];
        if (image != nil) {
            
            self.backImageView.image = image;
        }
        _bgView.left = button.left;
        
        self.backImageView.left = 0;
        [UIView animateWithDuration:0.3 animations:^{
            
            self.backImageView.left = kScreenWidth;
            
        } completion:^(BOOL finished) {
            [self.backImageView removeFromSuperview];
        }];
        
        _lastButton.selected = !_lastButton.selected;
        button.selected = !button.selected;
    }
    
    _lastButton = button;
}

#pragma mark - show or hidden tabbar
-(void)showTabbar
{
    self.tabBar.hidden = YES;

    _tabbarView.left = 0;
}
-(void)hiddenTabbar
{
    _tabbarView.left = kScreenWidth;
}

#pragma mark - Utility Methods -
//获取当前屏幕视图的快照图片
- (UIImage *)capture {
    
    UIView *view = self.view;
    if (view == nil) {
        return nil;
    }
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    NSLog(@"%f,%f",img.size.height,img.size.width);
    UIGraphicsEndImageContext();
    
    return img;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
