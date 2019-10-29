//
//  PDChooseItemViewController.m
//  PDChooseItem
//
//  Created by Lemonade on 2019/10/24.
//  Copyright © 2019 Lemer. All rights reserved.
//

#import "PDChooseItemViewController.h"
#import "Macros.h"

static NSString *const constCellIdentifier = @"constCellIdentifier";
//static NSString *const constHeaderIdentifier = @"constHeaderIdentifier";
//static NSString *const constFooterIdentifier = @"constFooterIdentifier";

static NSString *const constCellMoveShake = @"constCellMoveShake";

@interface PDChooseItemViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, readwrite, strong) UICollectionView *collectionView;

@property (nonatomic, readwrite, strong) NSMutableArray *selectedAry;

@property (nonatomic, readwrite, strong) NSMutableArray *unselectedAry;

@property (nonatomic, readwrite, strong) UILongPressGestureRecognizer *changeLocationGR;

@end

@implementation PDChooseItemViewController
#pragma mark - Life Circle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.orangeColor;
    
    for (int i = 0; i < 6; i++) {
        [self.selectedAry addObject:[NSString stringWithFormat:@"menu_style_A_A%02d", i]];
    }
    for (int i = 6; i < 20; i++) {
        [self.unselectedAry addObject:[NSString stringWithFormat:@"menu_style_A_A%02d", i]];
    }

    [self collectionView];
}
#pragma mark - Private Methods



#pragma mark --- collectionView长按移动手势 ---
- (void)itemMoveGestureRecognizer:(UILongPressGestureRecognizer *)sender {
    switch (sender.state) {
            // 手势状态开始
        case UIGestureRecognizerStateBegan:
            {
                NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[sender locationInView:self.collectionView]];
                if (indexPath == nil) {
                    return;
                }
                // iOS9方法,开始移动item
                [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
                // 抖动item
                [self starShaking:self.collectionView];
            }
            break;
            // 手势状态改变
        case UIGestureRecognizerStateChanged:
            {
                // 不断改变item的位置
                [self.collectionView updateInteractiveMovementTargetPosition:[sender locationInView:self.collectionView]];
            }
            break;
            // 手势状态结束
        case UIGestureRecognizerStateEnded:
            {
                // 结束移动
                [self.collectionView endInteractiveMovement];
                // 停止item的抖动
                [self stopShaking:self.collectionView];
            }
            break;
            
            // 手势状态取消
        default:
        {
            // 取消移动
            [self.collectionView cancelInteractiveMovement];
        }
            break;
    }
}
// collectionView的item在长按之后开始抖动
- (void)starShaking:(UICollectionView *)collectionView {
    
    CAKeyframeAnimation * keyAnimaion = [CAKeyframeAnimation animation];
    keyAnimaion.keyPath = @"transform.rotation";
    keyAnimaion.values = @[@(-3 / 180.0 * M_PI),@(3 /180.0 * M_PI),@(-3/ 180.0 * M_PI)];//度数转弧度
    keyAnimaion.removedOnCompletion = NO;
    keyAnimaion.fillMode = kCAFillModeForwards;
    keyAnimaion.duration = 0.3;
    keyAnimaion.repeatCount = MAXFLOAT;
    
    for (UICollectionViewCell *cell in collectionView.visibleCells) {
        [cell.layer addAnimation:keyAnimaion forKey:constCellMoveShake];
    }
}
// item长按移动结束时停止抖动
- (void)stopShaking:(UICollectionView *)collectionView {
    for (UICollectionViewCell *cell in collectionView.visibleCells) {
        [cell.layer removeAnimationForKey:constCellMoveShake];
    }
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return section == 0 ? self.selectedAry.count : self.unselectedAry.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:constCellIdentifier forIndexPath:indexPath];
    
    NSInteger const cImageTag = 10000;
    UIImageView *iv = [cell.contentView viewWithTag:cImageTag];
    if (iv == nil) {
        CGRect cellBounds = cell.contentView.bounds;
        iv = [[UIImageView alloc] initWithFrame:CGRectMake(cellBounds.size.width/2-25, cellBounds.size.height/2-25, 50, 50)];
        cell.contentMode = UIViewContentModeCenter;
        [cell.contentView addSubview:iv];
    }
    cell.contentView.backgroundColor = UIColor.clearColor;
    if (indexPath.section == 0) {
        iv.image = [UIImage imageNamed:self.selectedAry[indexPath.row]];
    } else {
        iv.image = [UIImage imageNamed:self.unselectedAry[indexPath.row]];
    }

    return cell;
}
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if (sourceIndexPath.section == 0) {
        id obj = self.selectedAry[sourceIndexPath.row];
        [self.selectedAry removeObjectAtIndex:sourceIndexPath.row];
        if (destinationIndexPath.section == 0) {
            [self.selectedAry insertObject:obj atIndex:destinationIndexPath.row];
        } else {
            [self.unselectedAry insertObject:obj atIndex:destinationIndexPath.row];
        }
    } else {
        id obj = self.unselectedAry[sourceIndexPath.row];
        [self.unselectedAry removeObjectAtIndex:sourceIndexPath.row];
        if (destinationIndexPath.section == 0) {
            [self.selectedAry insertObject:obj atIndex:destinationIndexPath.row];
        } else {
            [self.unselectedAry insertObject:obj atIndex:destinationIndexPath.row];
        }
    }
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    cell.contentView.backgroundColor = UIColor.whiteColor;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        id obj = self.selectedAry[indexPath.row];
        [self.selectedAry removeObject:obj];
        [self.unselectedAry addObject:obj];
        [collectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForRow:self.unselectedAry.count-1 inSection:1]];
    } else {
        id obj = self.unselectedAry[indexPath.row];
        [self.unselectedAry removeObject:obj];
        [self.selectedAry addObject:obj];
        [collectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForRow:self.selectedAry.count-1 inSection:0]];
    }
}
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    
    
    return YES;
}
#pragma mark - Lazy Load
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        flowLayout.minimumLineSpacing = 5;
        flowLayout.minimumInteritemSpacing = 5;
        
        CGFloat itemWidth = floor((SCREEN_WIDTH-5-5-5*(4-1))/4);
        CGFloat itemHeight = itemWidth;
        
        flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
        flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 0);
        flowLayout.footerReferenceSize = CGSizeMake(SCREEN_WIDTH, 10);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = PD_VIEW_BACKGROUND_COLOR;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        [_collectionView addGestureRecognizer:self.changeLocationGR];
        
        // 注册cell
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:constCellIdentifier];
//        // 注册section header
//        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:constHeaderIdentifier];
//        // 注册section footer
//        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:constFooterIdentifier];
        
        [self.view addSubview:_collectionView];
        
        
    }
    return _collectionView;
}
- (NSMutableArray *)selectedAry {
    if (_selectedAry == nil) {
        _selectedAry = [NSMutableArray array];
    }
    return _selectedAry;
}
- (NSMutableArray *)unselectedAry {
    if (_unselectedAry == nil) {
        _unselectedAry = [NSMutableArray array];
    }
    return _unselectedAry;
}
- (UILongPressGestureRecognizer *)changeLocationGR {
    if (_changeLocationGR == nil) {
        _changeLocationGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(itemMoveGestureRecognizer:)];
        _changeLocationGR.delegate = self;
    }
    return _changeLocationGR;
}
@end
