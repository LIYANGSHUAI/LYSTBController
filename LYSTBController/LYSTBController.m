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

#import "LYSTBController.h"

@interface LYSTBController ()

@property (nonatomic,strong)LYSTabBar *x_tabBar;

@property (nonatomic,strong)LYSTabBarView *tabBarView;

@end

@implementation LYSTBController

- (UITabBar *)x_tabBar
{
    if (!_x_tabBar) {
        _x_tabBar = [[LYSTabBar alloc] init];
    }
    return _x_tabBar;
}
// 创建方法
- (instancetype)initWithTabBarView:(LYSTabBarView *)tabBarView
{
    self = [super init];
    if (self) {
        self.tabBarView = tabBarView;
        [self.x_tabBar addSubview:self.tabBarView];
        self.tabBarView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.x_tabBar addConstraint:Layout(self.tabBarView, Top, Equal, self.x_tabBar, Top, 1, 0)];
        [self.x_tabBar addConstraint:Layout(self.tabBarView, Left, Equal, self.x_tabBar, Left, 1, 0)];
        [self.x_tabBar addConstraint:Layout(self.tabBarView, Right, Equal, self.x_tabBar, Right, 1, 0)];
        [self.x_tabBar addConstraint:Layout(self.tabBarView, Bottom, Equal, self.x_tabBar, Bottom, 1, 0)];
        [self setValue:self.x_tabBar forKey:@"tabBar"];
        self.currentSelectItemIndex = 0;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemClickAction:) name:@"ItemDidClickNotifition" object:nil];
    }
    return self;
}
+ (instancetype)tabBarWithView:(LYSTabBarView *)tabBarView{
    return [[LYSTBController alloc] initWithTabBarView:tabBarView];
}
- (void)setCurrentSelectItemIndex:(NSInteger)currentSelectItemIndex
{
    _currentSelectItemIndex = currentSelectItemIndex;
    self.tabBarView.currentSelectItemIndex = _currentSelectItemIndex;
}
- (void)itemClickAction:(NSNotification *)notifition
{
    NSInteger itemIndex = [notifition.userInfo[@"itemIndex"] integerValue];
    if (_viewControllerAry && [_viewControllerAry count] > itemIndex) {
        self.viewControllers = @[_viewControllerAry[itemIndex]];
    }
    for (UIView *view in self.tabBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [view removeFromSuperview];
        }
        if ([view isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
            [view removeFromSuperview];
        }
    }
}
- (void)setViewControllerAry:(NSArray<UIViewController *> *)viewControllerAry
{
    _viewControllerAry = viewControllerAry;
    if (_viewControllerAry && [_viewControllerAry count] > _currentSelectItemIndex) {
        self.viewControllers = @[_viewControllerAry[self.currentSelectItemIndex]];
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (UIView *view in self.tabBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [view removeFromSuperview];
        }
        if ([view isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
            [view removeFromSuperview];
        }
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

@implementation LYSBaseTabBar

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        UIGraphicsBeginImageContext(CGSizeMake(1, 1));
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] colorWithAlphaComponent:0].CGColor);
        CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [self setBackgroundImage:img];
        [self setShadowImage:img];
    }
    return self;
}

@end

@implementation LYSTabBar

// 碰撞监测
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.isHidden == NO && [self pointInside:point withEvent:event]) {
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:NSClassFromString(@"LYSTabBarView")]) {
                if ([view pointInside:point withEvent:event]) {
                    return [view hitTest:point withEvent:event];
                }
            }
        }
    }
    return nil;
}

@end
