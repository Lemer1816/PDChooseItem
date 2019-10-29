//
//  UIScrollView+Refresh.m
//  HuzhouTourSupervise
//
//  Created by Lemonade on 2018/3/30.
//  Copyright © 2018年 Zhejiang Rongchuang Information Industry Co., Ltd. All rights reserved.
//

#import "UIScrollView+Refresh.h"

@implementation UIScrollView (Refresh)

// 添加头部刷新
- (void)addHeaderRefresh:(MJRefreshComponentRefreshingBlock)block{
    [self addHeaderRefresh:block idleTitle:nil];
}
// 添加头部刷新,自定义标题
- (void)addHeaderRefresh:(MJRefreshComponentRefreshingBlock)block idleTitle:(NSString *)idleTitle {
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingBlock:block];
    if (idleTitle) {
        [header setTitle:idleTitle forState:MJRefreshStateIdle];
    }
    header.stateLabel.font = [UIFont systemFontOfSize:13];
    header.stateLabel.textColor = UIColor.grayColor;
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:13];
    header.lastUpdatedTimeLabel.textColor = UIColor.grayColor;
    self.mj_header = header;
}
// 添加脚部自动刷新
- (void)addAutoFooterRefresh:(MJRefreshComponentRefreshingBlock)block {
//    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:block];
    [self addAutoFooterRefresh:block idleTitle:nil noMoreDataTitle:nil];
}
// 添加脚部自动刷新,自定义标题
- (void)addAutoFooterRefresh:(MJRefreshComponentRefreshingBlock)block idleTitle:(NSString *)idleTitle noMoreDataTitle:(NSString *)noMoreDataTitle {
    MJRefreshAutoStateFooter *footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:block];
    if (idleTitle) {
        [footer setTitle:idleTitle forState:MJRefreshStateIdle];
    }
    if (noMoreDataTitle) {
        [footer setTitle:noMoreDataTitle forState:MJRefreshStateNoMoreData];
    }
    footer.stateLabel.font = [UIFont systemFontOfSize:13];
    footer.stateLabel.textColor = UIColor.grayColor;
    self.mj_footer = footer;
}
// 添加脚部返回刷新
- (void)addBackFooterRefresh:(MJRefreshComponentRefreshingBlock)block{
//    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:block];
    [self addBackFooterRefresh:block idleTitle:nil noMoreDataTitle:nil];
}
- (void)addBackFooterRefresh:(MJRefreshComponentRefreshingBlock)block idleTitle:(NSString *)idleTitle noMoreDataTitle:(NSString *)noMoreDataTitle {
    MJRefreshBackStateFooter *footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:block];
    if (idleTitle) {
        [footer setTitle:idleTitle forState:MJRefreshStateIdle];
    }
    if (noMoreDataTitle) {
        [footer setTitle:noMoreDataTitle forState:MJRefreshStateNoMoreData];
    }
    footer.stateLabel.font = [UIFont systemFontOfSize:13];
    footer.stateLabel.textColor = UIColor.grayColor;
    self.mj_footer = footer;
}
// 开始头部刷新
- (void)beginHeaderRefresh{
    [self.mj_header beginRefreshing];
}
// 开始脚部刷新
- (void)beginFooterRefresh{
    [self.mj_footer beginRefreshing];
}

// 结束头部刷新
- (void)endHeaderRefresh{
    [self endHeaderRefreshWithMoreData:YES];
}
// 根据是否有数据结束头部刷新,并且设置脚部文字
- (void)endHeaderRefreshWithMoreData:(BOOL)moreData {
    [self.mj_header endRefreshing];
    if (moreData) {
        [self resetFooterNoMoreData];
    } else {
        [self endFootRefreshWithMoreData:moreData];
    }
}
// 结束脚部刷新
- (void)endFooterRefresh{
    [self endFootRefreshWithMoreData:YES];
}
// 根据是否有数据结束脚步刷新状态
- (void)endFootRefreshWithMoreData:(BOOL)moreData {
    if (moreData) {
        [self.mj_footer endRefreshing];
    } else {
        [self.mj_footer endRefreshingWithNoMoreData];
    }
}
// 重置底部刷新状态
- (void)resetFooterNoMoreData {
    [self.mj_footer resetNoMoreData];
}
@end
