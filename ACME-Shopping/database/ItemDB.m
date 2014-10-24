//
//  ItemDB.m
//  ACME-Shopping
//
//  Created by fady on 13-11-3.
//  Copyright (c) 2013年 wanshaofa. All rights reserved.
//

#import "ItemDB.h"
#import "DetailModel.h"

@implementation ItemDB

static ItemDB *instance;

-(NSString *)filePath
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    documentPath = [documentPath stringByAppendingPathComponent:@"database.sqlite"];
    
    return documentPath;
}

+(ItemDB *)shareDB
{
    @synchronized(self){
        if (instance == nil) {
            instance = [[[self class] alloc]init];
        }
    }
    
    return instance;
}
/*
 @property(nonatomic, copy)NSString *bitmapurl;
 @property(nonatomic, strong)NSDictionary *rect;
 @property(nonatomic, strong)NSNumber *type;
 @property(nonatomic, copy)NSString *uri;
 @property(nonatomic, copy)NSString *itemId;
 */
-(void)addItem:(DetailModel *)model
{
    EGODatabase *database = [[EGODatabase alloc] initWithPath:self.filePath];
    [database open];
    
    
    
//    NSString *sql = @"INSERT INTO Item(bitmapurl, type, uri, ItemId)VALUES(?,?,?,?)";
//    NSArray *params = @[model.bitmapurl, model.type, model.uri, model.itemId];
    
    NSString *sql = @"INSERT INTO Items(picUrl, numIid, promotionPrice)VALUES(?,?,?)";
    NSArray *params = @[model.picUrl, model.numIid, model.promotionPrice];
    EGODatabaseResult *result = [database executeQuery:sql parameters:params];
    NSString *error = [result errorMessage];
    NSLog(@"error = %@", error);
    [database close];
}

-(void)deleteItem:(NSString *)itemId
{
    EGODatabase *database = [[EGODatabase alloc] initWithPath:self.filePath];
    [database open];
    
//    NSString *sql = [NSString stringWithFormat:@"DELETE FROM Item WHERE ItemId = %@", itemId];
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM Items WHERE numIid = %@", itemId];
    [database executeUpdate:sql];
    
    [database close];
}

-(void)findItems:(FindCompletionBlock)block
{
    EGODatabase *database = [[EGODatabase alloc] initWithPath:self.filePath];
    [database open];
    
//    NSString *sql = @"SELECT bitmapurl, type, uri, ItemId FROM Item";
    
    NSString *sql = @"SELECT picUrl, numIid, promotionPrice FROM Items";
    EGODatabaseRequest *request = [database requestWithQuery:sql];
    [request setSuccessBlock:^(EGODatabaseResult *result){
        NSMutableArray *array = [NSMutableArray array];
        // bitmapurl, rect, type, uri, itemId
//        for (int i = 0; i < result.count; i++) {
//            PageModel *model = [[PageModel alloc] init];
//            EGODatabaseRow *row = [result.rows objectAtIndex:i];
//            model.bitmapurl = [row stringForColumn:@"bitmapurl"];
//            int type = [row intForColumn:@"type"];
//            model.type = [NSNumber numberWithInt:type];
//            
//            model.uri = [row stringForColumn:@"uri"];
//            model.itemId = [row stringForColumn:@"ItemId"];
//            
//            [array addObject:model];
//        }
        
        for (int i = 0; i < result.count; i++) {
            DetailModel *model = [[DetailModel alloc] init];
            EGODatabaseRow *row = [result.rows objectAtIndex:i];
            model.picUrl = [row stringForColumn:@"picUrl"];
            
            NSString *idd = [row.columnData objectAtIndex:1];
            long long numIid = [idd longLongValue];
            model.numIid = [NSNumber numberWithLongLong:numIid];
            double promotionPrice = [row doubleForColumn:@"promotionPrice"];
            model.promotionPrice = [NSNumber numberWithDouble:promotionPrice];
            [array addObject:model];
        }
        
        block(array);
    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:request];
//    [database close];
}

-(DetailModel *)findItem:(NSNumber *)itemId
{
    EGODatabase *database = [[EGODatabase alloc] initWithPath:self.filePath];
    [database open];
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM Items WHERE numIid = %@", itemId];
    EGODatabaseResult *result = [database executeQuery:sql];
    
    for (int i = 0; i < result.count; i++) {
        DetailModel *model = [[DetailModel alloc] init];
        EGODatabaseRow *row = [result.rows objectAtIndex:i];
        model.picUrl = [row stringForColumn:@"picUrl"];
        NSString *idd = [row.columnData objectAtIndex:1];
        long long numIid = [idd longLongValue];
        model.numIid = [NSNumber numberWithLongLong:numIid];
        
        double promotionPrice = [row doubleForColumn:@"promotionPrice"];
        model.promotionPrice = [NSNumber numberWithDouble:promotionPrice];
        
        [database close];
        
        return model;
    }
    
    return nil;
}

@end
