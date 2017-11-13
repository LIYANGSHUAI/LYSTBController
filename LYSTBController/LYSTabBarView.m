/*
 Thank you for your use.
 Github address: https://github.com/LIYANGSHUAI/LYSTBController.git
 The above is my contact information, if there are any problems and good ideas, please contact me
 */
#define Equal NSLayoutRelationEqual
#define Top NSLayoutAttributeTop
#define Left NSLayoutAttributeLeft
#define Right NSLayoutAttributeRight
#define Bottom NSLayoutAttributeBottom
#define Width NSLayoutAttributeWidth
#define Height NSLayoutAttributeHeight
#define CenterX NSLayoutAttributeCenterX
#define CenterY NSLayoutAttributeCenterY
#define Not NSLayoutAttributeNotAnAttribute
#define Layout(A,AttributeOne,RelatedBy,B,AttributeTwo,M,C) [NSLayoutConstraint constraintWithItem:A attribute:AttributeOne relatedBy:RelatedBy toItem:B attribute:AttributeTwo multiplier:M constant:C]

#import "LYSTabBarView.h"
#import "LYSTBBarItem.h"
#import <objc/runtime.h>
@interface LYSBaseBgView ()

@property (nonatomic,strong)UIVisualEffectView *effectView;

@end

@implementation LYSBaseBgView
{
    UIColor *bgColor;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addObserver:self forKeyPath:@"translucent" options:(NSKeyValueObservingOptionOld |NSKeyValueObservingOptionNew) context:nil];
        [self addObserver:self forKeyPath:@"backgroundColor" options:(NSKeyValueObservingOptionOld |NSKeyValueObservingOptionNew) context:nil];
        self.translucent = YES;
    }
    return self;
}
- (void)setTranslucent:(BOOL)translucent{
    _translucent = translucent;
    if (_translucent == YES) {
        [self addSubview:self.effectView];
        _effectView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraint:Layout(_effectView, Top, Equal, self, Top, 1, 0)];
        [self addConstraint:Layout(_effectView, Left, Equal, self, Left, 1, 0)];
        [self addConstraint:Layout(_effectView, Right, Equal, self, Right, 1, 0)];
        [self addConstraint:Layout(_effectView, Bottom, Equal, self, Bottom, 1, 0)];
    }else{
        [self.effectView removeFromSuperview];
        self.effectView = nil;
    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"translucent"]) {
        [self removeObserver:self forKeyPath:@"backgroundColor"];
        if ([change[@"new"] boolValue] == YES) {
            self.backgroundColor = [UIColor clearColor];
        }else{
            self.backgroundColor = bgColor;
        }
        [self addObserver:self forKeyPath:@"backgroundColor" options:(NSKeyValueObservingOptionOld |NSKeyValueObservingOptionNew) context:nil];
    }
    if ([keyPath isEqualToString:@"backgroundColor"]) {
        bgColor = change[@"new"];
    }
}
- (UIVisualEffectView *)effectView
{
    if (!_effectView) {
        _effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    }
    return _effectView;
}
- (void)dealloc{
    [self removeObserver:self forKeyPath:@"translucent"];
    [self removeObserver:self forKeyPath:@"backgroundColor"];
}
@end

@implementation LYSBaseTabBarView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.topLineView];
        _topLineView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraint:Layout(_topLineView, Top, Equal, self, Top, 1, 0)];
        [self addConstraint:Layout(_topLineView, Left, Equal, self, Left, 1, 0)];
        [self addConstraint:Layout(_topLineView, Right, Equal, self, Right, 1, 0)];
        [_topLineView addConstraint:Layout(_topLineView, Height, Equal, nil, Not, 1, 0.5)];
        [self addSubview:self.bakgroundView];
        _bakgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraint:Layout(_bakgroundView, Top, Equal, self, Top, 1, 0.5)];
        [self addConstraint:Layout(_bakgroundView, Left, Equal, self, Left, 1, 0)];
        [self addConstraint:Layout(_bakgroundView, Right, Equal, self, Right, 1, 0)];
        [self addConstraint:Layout(_bakgroundView, Bottom, Equal, self, Bottom, 1, 0)];
    }
    return self;
}

- (LYSBaseBgView *)bakgroundView
{
    if (!_bakgroundView) {
        _bakgroundView = [[LYSBaseBgView alloc] init];
    }
    return _bakgroundView;
}
- (UIView *)topLineView
{
    if (!_topLineView) {
        _topLineView = [[UIView alloc] init];
        _topLineView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    }
    return _topLineView;
}

@end

@interface LYSTabBarView ()
@end

@implementation LYSTabBarView
@synthesize tabBarItems = _tabBarItems;

- (NSArray<LYSTBBarItem *> *)tabBarItems
{
    if (!_tabBarItems) {
        _tabBarItems = [NSArray array];
    }
    return _tabBarItems;
}

- (void)setTabBarItems:(NSArray<LYSTBBarItem *> *)tabBarItems{
    _tabBarItems = tabBarItems;
    for (int i = 0; i < self.tabBarItems.count; i++) {
        LYSTBBarItem *item = self.tabBarItems[i];
        [self addSubview:item];
        objc_setAssociatedObject(item, @"itemIndex", @(i), OBJC_ASSOCIATION_ASSIGN);
        item.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraint:Layout(item, CenterY, Equal, self, CenterY, 1, 0)];
        [self addConstraint:Layout(item, CenterX, Equal, self, Right, ((1 + i * 2) * 1.0)  / (self.tabBarItems.count * 2), 0)];
        [self addConstraint:Layout(item, Width, Equal, self, Width, 1.0  / (self.tabBarItems.count), 0)];
        [self addConstraint:Layout(item, Height, Equal, self, Height, 1, 0)];
    }
}
- (void)setCurrentSelectItemIndex:(NSInteger)currentSelectItemIndex{
    _currentSelectItemIndex = currentSelectItemIndex;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ItemDidClickNotifition" object:nil userInfo:@{@"itemIndex":@(_currentSelectItemIndex)}];
}
@end
