//
//  UIScrollView+Refresh.h
//  HuzhouTourSupervise
//
//  Created by Lemonade on 2018/3/30.
//  Copyright © 2018年 Zhejiang Rongchuang Information Industry Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, RequestType) {
    //下拉刷新
    RequestTypeRefresh,
    //上拉加载
    RequestTypeLoadMore
};

@interface UIScrollView (Refresh)
/** 添加头部刷新 */
- (void)addHeaderRefresh:(MJRefreshComponentRefreshingBlock)block;
/** 添加头部刷新,自定义标题 */
- (void)addHeaderRefresh:(MJRefreshComponentRefreshingBlock)block
               idleTitle:(NSString *)idleTitle;
/** 添加脚部自动刷新 */
- (void)addAutoFooterRefresh:(MJRefreshComponentRefreshingBlock)block;
/** 添加脚部自动刷新,自定义标题 */
- (void)addAutoFooterRefresh:(MJRefreshComponentRefreshingBlock)block
                   idleTitle:(NSString *)idleTitle
             noMoreDataTitle:(NSString *)noMoreDataTitle;
/** 添加脚部返回刷新 */
- (void)addBackFooterRefresh:(MJRefreshComponentRefreshingBlock)block;
/** 添加脚部返回刷新,自定义标题 */
- (void)addBackFooterRefresh:(MJRefreshComponentRefreshingBlock)block
                   idleTitle:(NSString *)idleTitle
             noMoreDataTitle:(NSString *)noMoreDataTitle;

/** 开始头部刷新 */
- (void)beginHeaderRefresh;
/** 开始脚部刷新 */
- (void)beginFooterRefresh;

/** 结束头部刷新 */
- (void)endHeaderRefresh;
/** 根据是否有数据结束头部刷新,并且设置脚部文字 */
- (void)endHeaderRefreshWithMoreData:(BOOL)moreData;
/** 结束脚部刷新 */
- (void)endFooterRefresh;
/** 根据是否有数据结束脚步刷新状态 */
- (void)endFootRefreshWithMoreData:(BOOL)moreData;
/** 重置底部刷新状态 */
- (void)resetFooterNoMoreData;
@end
