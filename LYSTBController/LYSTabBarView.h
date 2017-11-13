/*
 Thank you for your use.
 Github address: https://github.com/LIYANGSHUAI/LYSTBController.git
 The above is my contact information, if there are any problems and good ideas, please contact me
 */

#import <UIKit/UIKit.h>

/**
 Control the navigation background view, and imitate the glass effect of the system navigation
 */
@interface LYSBaseBgView : UIView

/**
 Display and hide control of frosted glass effect
 */
@property (nonatomic,assign)BOOL translucent;

@end

@interface LYSBaseTabBarView : UIView

/**
 Navigation bottom background view
 */
@property (nonatomic,strong)LYSBaseBgView *bakgroundView;

/**
 Navigation top thin line
 */
@property (nonatomic,strong)UIView *topLineView;

@end

@class LYSTBBarItem;

@interface LYSTabBarView : LYSBaseTabBarView

/**
 Which item is in the selected state by the controller navigation
 */
@property (nonatomic,assign)NSInteger currentSelectItemIndex;

/**
 Storing the displayed item
 */
@property (nonatomic,strong)NSArray<LYSTBBarItem *> *tabBarItems;

@end


