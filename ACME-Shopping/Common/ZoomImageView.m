//
//  ZoomImageView.m
//  ZZWeibo
//
//  Created by ios on 13-10-14.
//  Copyright (c) 2013年 万绍发 邮箱 www.854347546@qq.com. All rights reserved.
//

#import "ZoomImageView.h"
#import "BaseViewController.h"

#define ZZRelease(obj) [obj release], obj = nil

@implementation ZoomImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)addZoom:(NSString *)urlstring
{
    if(self.urlstring.length == 0) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomInAction)];
        [self addGestureRecognizer:tap];
        [tap release];
        
        self.userInteractionEnabled = YES;
    }
    
    self.urlstring = urlstring;
}

-(void)_loadViews
{
    
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        [self.window addSubview:_scrollView];
        
        // 缩小手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomOutAction)];
        [_scrollView addGestureRecognizer:tap];
        [tap release];
    }
    
    if (_saveButton == nil) {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveButton retain];
        _saveButton.frame = CGRectMake(kScreenWidth - 60, kScreenHeight - 60, 40, 50);
        [_saveButton addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
        _saveButton.enabled = NO;
        [_saveButton setImage:[UIImage imageNamed:@"compose_savebutton_background.png"] forState:UIControlStateNormal];
        [_saveButton setImage:[UIImage imageNamed:@"compose_savebutton_background_highlighted.png"] forState:UIControlStateHighlighted];
        
        [self.window addSubview:_saveButton];
    }
    
    if (_fullImageView == nil) {
        _fullImageView = [[UIImageView alloc] initWithImage:self.image];
        _fullImageView.contentMode = UIViewContentModeScaleAspectFit;
        [_scrollView addSubview:_fullImageView];
    }
    
    if (_progressView == nil) {
        _progressView = [[DDProgressView alloc] initWithFrame:CGRectMake(10, kScreenHeight/2, kScreenWidth - 20, 50)];
        _progressView.emptyColor = [UIColor darkGrayColor];
        _progressView.outerColor = [UIColor clearColor];
        _progressView.innerColor = [UIColor lightGrayColor];
        _progressView.progress = 0;
        _progressView.hidden = YES;
        [_scrollView addSubview:_progressView];
    }
}

#pragma mark - zoomInAction

-(void)zoomInAction
{
    // 1. 显示放大视图
    [self _loadViews];

    // 2. 隐藏状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];

    if ([self.delegate respondsToSelector:@selector(imageWillZoomIn:)]) {
        [self.delegate imageWillZoomIn:_scrollView];
    }
    
    // 3. 放大的动画效果
    CGRect frame = [self convertRect:self.bounds toView:self.window];
    _scrollView.backgroundColor = [UIColor clearColor];
    _fullImageView.frame = frame;
    [UIView animateWithDuration:0.3 animations:^{
        _fullImageView.frame = [UIScreen mainScreen].bounds;
    } completion:^(BOOL finished) {
        _scrollView.backgroundColor = [UIColor blackColor];
        
        if ([self.delegate respondsToSelector:@selector(imageDidZoomIn:)]) {
            [self.delegate imageDidZoomIn:_scrollView];
        }
    }];
    
    // 4. 加载图片
    if (self.urlstring.length > 0) {
        
        [_progressView performSelector:@selector(setHidden:) withObject:NO afterDelay:0.3];
        
        ZZRelease(_data);
        _data = [[NSMutableData alloc] init];
        NSURL *url = [NSURL URLWithString:self.urlstring];
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30];
        self.connect = [NSURLConnection connectionWithRequest:request delegate:self];
    } else {
        UIImage *image = _fullImageView.image;
        
        float height = image.size.height/image.size.width*kScreenWidth;
        if (height < kScreenHeight) {
            _fullImageView.top = (kScreenHeight - height)/2;
        }
        
        _fullImageView.size = CGSizeMake(kScreenWidth, height);
        _scrollView.contentSize = CGSizeMake(kScreenWidth, height);
        _progressView.progress = 1;
        [_progressView removeFromSuperview];
        _saveButton.enabled = YES;
    }
    
}

-(void)zoomOutAction
{
    if ([self.delegate respondsToSelector:@selector(imageWillZoomOut:)]) {
        [self.delegate imageWillZoomOut:_scrollView];
    }
    
    // 1显示状态烂
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
    // 2 缩小动画效果
    _scrollView.backgroundColor = [UIColor clearColor];
    _progressView.hidden = YES;
    [_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = [self convertRect:self.bounds toView:self.window];
        _fullImageView.frame = frame;
    } completion:^(BOOL finished) {
        
        if (_scrollView.superview != nil) {
            [_scrollView removeFromSuperview];            
        }
        
        if (_saveButton.superview != nil) {
            
            [_saveButton removeFromSuperview];
        }

        [self.connect cancel];
        ZZRelease(_connect);
        ZZRelease(_scrollView);
        ZZRelease(_fullImageView);
        ZZRelease(_progressView);
        ZZRelease(_saveButton);
        ZZRelease(_hud);
        
        if ([self.delegate respondsToSelector:@selector(imageDidZoomOut:)]) {
            [self.delegate imageDidZoomOut:_scrollView];
        }
    }];
    
}

-(void)saveAction
{
    [self performSelectorInBackground:@selector(savePicture) withObject:NULL];
}

-(void)savePicture
{
    [self showHUD:@"正在保存"];
    UIImage *image = [UIImage imageWithData:_data];
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    [UIView animateWithDuration:0.5 animations:^{
        [self hiddenHUDWithCompletion:@"保存成功"];
    }];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    NSDictionary *allHeaderFields = [httpResponse allHeaderFields];
    NSString *size = [allHeaderFields objectForKey:@"Content-Length"];
    _length = [size doubleValue];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
    
    float progress = _data.length/_length;
    NSLog(@"%f", progress);
    _progressView.progress = progress;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    UIImage *image = [UIImage imageWithData:_data];
    _fullImageView.image = image;
    
    float height = image.size.height/image.size.width*kScreenWidth;
    if (height < kScreenHeight) {
        _fullImageView.top = (kScreenHeight - height)/2;
    }
    
    _fullImageView.size = CGSizeMake(kScreenWidth, height);
    _scrollView.contentSize = CGSizeMake(kScreenWidth, height);
    _progressView.progress = 1;
    _progressView.hidden = YES;
    [_progressView removeFromSuperview];
    _saveButton.enabled = YES;
}

-(void)showHUD:(NSString *)title
{
    if (_hud == nil) {
        _hud = [MBProgressHUD showHUDAddedTo:_scrollView animated:YES];
        _hud.labelText = title;
        [_hud retain];
        _hud.dimBackground = YES;
    }
    
    [_hud show:YES];
}

-(void)hiddenHUDWithCompletion:(NSString *)title
{
    UIImageView *customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    _hud.customView = customView;
    _hud.mode = MBProgressHUDModeCustomView;
    
    _hud.labelText = title;
    
    [_hud hide:YES afterDelay:1.5];
    [customView release];
}

@end
