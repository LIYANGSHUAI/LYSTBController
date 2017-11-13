/*
 Thank you for your use.
 Github address: https://github.com/LIYANGSHUAI/LYSTBController.git
 The above is my contact information, if there are any problems and good ideas, please contact me
 */

#import <UIKit/UIKit.h>

@interface LYSTBBarItem : UIView

/**
 Import the title and picture to create the corresponding item

 @param title title
 @param image picture
 @return the corresponding item
 */
- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image;

/**
 The incoming picture creates the corresponding item

 @param image picture
 @return the corresponding item
 */
- (instancetype)initWithImage:(UIImage *)image;

/**
 The selected state of item
 */
@property (nonatomic,assign)BOOL isSelect;

/**
 The selected state of item
 */
@property (nonatomic,assign)CGFloat fontDefaultSize;
@property (nonatomic,assign)CGFloat fontSelectSize;
@property (nonatomic,strong)UIColor *fontDefaultColor;
@property (nonatomic,strong)UIColor *fontSelectColor;
@property (nonatomic,assign)CGSize imageDefaultSize;
@property (nonatomic,assign)CGSize imageSelectSize;
@property (nonatomic,strong)UIImage *defaultImage;
@property (nonatomic,strong)UIImage *selectImage;
@property (nonatomic,strong)UIColor *imageSelectColor;
@end

