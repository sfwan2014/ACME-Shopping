//
//  BaseCollectionView.m
//  ACME-Shopping
//
//  Created by fady on 13-10-24.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "BaseCollectionView.h"

@implementation BaseCollectionView

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self _loadDelegate];
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.dataSource = self;
    self.delegate = self;
}

-(void)setIsPull:(BOOL)isPull
{
    _isPull = isPull;
    
    [self _loadDelegate];
}

-(void)_loadDelegate
{
    if (_refreshTableHeaderView == nil && self.isPull) {
        
        _refreshTableHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.bounds.size.height, self.frame.size.width, self.bounds.size.height)];
        _refreshTableHeaderView.delegate = self;
        [self addSubview:_refreshTableHeaderView];
    }
    
    //  update the last update date
    [_refreshTableHeaderView refreshLastUpdatedDate];
}


#pragma mark - UICollectionView dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellId" forIndexPath:indexPath];
    
    return cell;
}


#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;
	
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshTableHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
	
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[_refreshTableHeaderView egoRefreshScrollViewDidScroll:scrollView];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshTableHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
    float y = scrollView.contentOffset.y+scrollView.height - scrollView.contentSize.height;
    if (y > 50) {
        if ([self.pullDelegate respondsToSelector:@selector(pullUp:)]) {
            [self.pullDelegate pullUp:self];
        }
    }
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
    
    //	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
    
	if ([self.pullDelegate respondsToSelector:@selector(pullDown:)]) {
        [self.pullDelegate pullDown:self];
    }
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

@end
