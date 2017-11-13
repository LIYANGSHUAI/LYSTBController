/*
 Thank you for your use.
 Github address: https://github.com/LIYANGSHUAI/LYSTBController.git
 The above is my contact information, if there are any problems and good ideas, please contact me
 */

#import <UIKit/UIKit.h>
#import "LYSTabBarView.h"
#import "LYSTBBarItem.h"

/**
 This component has the following functions:
    1. mainly solve the system navigation can not set more than five item problems
 */
@interface LYSTBController : UITabBarController

/**
 Responsible for storing the controller that needs to be switched
 */
@property (nonatomic,strong)NSArray<UIViewController *> *viewControllerAry;

/**
 Controls which controller is currently displayed. The value corresponds to the corresponding controller subscript
 */
@property (nonatomic,assign)NSInteger currentSelectItemIndex;

/**
 Creating a custom controller

 @param tabBarView Item container view
 @return Controller entity class
 */
- (instancetype)initWithTabBarView:(LYSTabBarView *)tabBarView;

/**
 Creating a custom controller
 
 @param tabBarView Item container view
 @return Controller entity class
 */
+ (instancetype)tabBarWithView:(LYSTabBarView *)tabBarView;
@end


/**
 Here are some of the components used in the development, you can ignore them in use
 */
@interface LYSBaseTabBar : UITabBar
@end

/**
 Here are some of the components used in the development, you can ignore them in use
 */
@interface LYSTabBar : LYSBaseTabBar
@end
