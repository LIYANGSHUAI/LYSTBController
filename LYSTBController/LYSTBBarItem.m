/*
 Thank you for your use.
 Github address: https://github.com/LIYANGSHUAI/LYSTBController.git
 The above is my contact information, if there are any problems and good ideas, please contact me
 */

#define Equal NSLayoutRelationEqual
#define Top   NSLayoutAttributeTop
#define Left  NSLayoutAttributeLeft
#define Right NSLayoutAttributeRight
#define Bottom NSLayoutAttributeBottom
#define Width NSLayoutAttributeWidth
#define Height NSLayoutAttributeHeight
#define CenterX NSLayoutAttributeCenterX
#define CenterY NSLayoutAttributeCenterY
#define Not NSLayoutAttributeNotAnAttribute
#define Layout(A,AttributeOne,RelatedBy,B,AttributeTwo,M,C) [NSLayoutConstraint constraintWithItem:A attribute:AttributeOne relatedBy:RelatedBy toItem:B attribute:AttributeTwo multiplier:M constant:C]

#import "LYSTBBarItem.h"
#import <objc/runtime.h>
@interface LYSTBBarItem ()
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIImageView *titleImage;
@property (nonatomic,strong)UIImage *defaultSelectImage;
@end

@implementation LYSTBBarItem
{
    NSArray<NSLayoutConstraint *> *layouts;
}
- (UIImage *)defaultSelectImage{
    return [self imageWithColor:self.imageSelectColor image:self.defaultImage];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.fontDefaultSize = 12;
        self.fontSelectSize = 12;
        
        self.fontDefaultColor = [UIColor lightGrayColor];
        self.fontSelectColor = [[UIColor blueColor] colorWithAlphaComponent:0.8];
        
        self.imageDefaultSize = CGSizeMake(25, 23);
        self.imageSelectSize = CGSizeMake(25, 23);
        self.imageSelectColor = [[UIColor blueColor] colorWithAlphaComponent:0.8];
        
        self.selectImage = nil;
        self.defaultImage = nil;
        
        [self addObserver:self forKeyPath:@"fontDefaultSize" options:(NSKeyValueObservingOptionNew) context:nil];
        [self addObserver:self forKeyPath:@"fontSelectSize" options:(NSKeyValueObservingOptionNew) context:nil];
        [self addObserver:self forKeyPath:@"fontDefaultColor" options:(NSKeyValueObservingOptionNew) context:nil];
        [self addObserver:self forKeyPath:@"fontSelectColor" options:(NSKeyValueObservingOptionNew) context:nil];
        [self addObserver:self forKeyPath:@"imageDefaultSize" options:(NSKeyValueObservingOptionNew) context:nil];
        [self addObserver:self forKeyPath:@"imageSelectSize" options:(NSKeyValueObservingOptionNew) context:nil];
        [self addObserver:self forKeyPath:@"imageSelectColor" options:(NSKeyValueObservingOptionNew) context:nil];
        [self addObserver:self forKeyPath:@"selectImage" options:(NSKeyValueObservingOptionNew) context:nil];
        [self addObserver:self forKeyPath:@"defaultImage" options:(NSKeyValueObservingOptionNew) context:nil];
    }
    return self;
}
- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image{
    self = [self init];
    if (self) {
        if ((title != nil && title.length > 0) && image != nil) {
            self.titleLabel = [[UILabel alloc] init];
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:self.titleLabel];
            _titleLabel.text = title;
            _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
            
            [self addConstraint:Layout(_titleLabel, Top, Equal, self, CenterY, 1, 5)];
            [self addConstraint:Layout(_titleLabel, CenterX, Equal, self, CenterX, 1, 0)];
            
            self.defaultImage = image;
            self.titleImage = [[UIImageView alloc] init];
            [self addSubview:self.titleImage];
            self.titleImage.image = self.defaultImage;
            _titleImage.translatesAutoresizingMaskIntoConstraints = NO;
            
            layouts = @[Layout(_titleImage, Bottom, Equal, self, CenterY, 1, 5),
                        Layout(_titleImage, CenterX, Equal, self, CenterX, 1, 0),
                        Layout(_titleImage, Width, Equal, nil, Not, 1, self.imageDefaultSize.width),
                        Layout(_titleImage, Height, Equal, nil, Not, 1, self.imageDefaultSize.height)];
            
            [self addConstraint:layouts[0]];
            [self addConstraint:layouts[1]];
            
            [_titleImage addConstraint:layouts[2]];
            [_titleImage addConstraint:layouts[3]];

        }else if (image != nil && (title == nil || title.length == 0)) {
            
            self.defaultImage = image;
            self.titleImage = [[UIImageView alloc] init];
            [self addSubview:self.titleImage];
            self.titleImage.image = self.defaultImage;
            _titleImage.translatesAutoresizingMaskIntoConstraints = NO;
            
            layouts = @[Layout(_titleImage, CenterY, Equal, self, CenterY, 1, 0),
                        Layout(_titleImage, CenterX, Equal, self, CenterX, 1, 0),
                        Layout(_titleImage, Width, Equal, nil, Not, 1, self.imageDefaultSize.width),
                        Layout(_titleImage, Height, Equal, nil, Not, 1, self.imageDefaultSize.height)];
            
            [self addConstraint:layouts[0]];
            [self addConstraint:layouts[1]];
            
            [_titleImage addConstraint:layouts[2]];
            [_titleImage addConstraint:layouts[3]];
        }
        
        [self customDefaultStyle];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateStyle:) name:@"ItemDidClickNotifition" object:nil];
        
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image
{
    return [self initWithTitle:nil image:image];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (self.isSelect == YES) {
        if (self.titleLabel != nil && self.titleImage != nil) {
            if ([keyPath isEqualToString:@"fontSelectSize"]) {
                self.titleLabel.font = [UIFont systemFontOfSize:self.fontSelectSize];
            }
            if ([keyPath isEqualToString:@"fontSelectColor"]) {
                self.titleLabel.textColor = self.fontSelectColor;
            }
            if ([keyPath isEqualToString:@"imageSelectSize"]) {
                [_titleImage removeConstraints:@[layouts[2],layouts[3]]];
                
                layouts = @[layouts[0],layouts[1],
                            Layout(_titleImage, Width, Equal, nil, Not, 1, self.imageSelectSize.width),
                            Layout(_titleImage, Height, Equal, nil, Not, 1, self.imageSelectSize.height)];
                [_titleImage addConstraint:layouts[2]];
                [_titleImage addConstraint:layouts[3]];
            }
            if ([keyPath isEqualToString:@"selectImage"]) {
                self.titleImage.image = self.selectImage == nil ? self.defaultSelectImage : self.selectImage;
            }
            if ([keyPath isEqualToString:@"imageSelectColor"]) {
                self.titleImage.image = self.selectImage == nil ? self.defaultSelectImage : self.selectImage;
            }
        }else if (self.titleLabel == nil && self.titleImage != nil){
            if ([keyPath isEqualToString:@"imageSelectSize"]) {
                [_titleImage removeConstraints:@[layouts[2],layouts[3]]];
                
                layouts = @[layouts[0],layouts[1],
                            Layout(_titleImage, Width, Equal, nil, Not, 1, self.imageSelectSize.width),
                            Layout(_titleImage, Height, Equal, nil, Not, 1, self.imageSelectSize.height)];
                [_titleImage addConstraint:layouts[2]];
                [_titleImage addConstraint:layouts[3]];
            }
            if ([keyPath isEqualToString:@"selectImage"]) {
                self.titleImage.image = self.selectImage == nil ? self.defaultSelectImage : self.selectImage;
            }
            if ([keyPath isEqualToString:@"imageSelectColor"]) {
                self.titleImage.image = self.selectImage == nil ? self.defaultSelectImage : self.selectImage;
            }
        }
        
    }else{
        if (self.titleLabel != nil && self.titleImage != nil) {
            if ([keyPath isEqualToString:@"fontDefaultSize"]) {
                self.titleLabel.font = [UIFont systemFontOfSize:self.fontDefaultSize];
            }
            if ([keyPath isEqualToString:@"fontDefaultColor"]) {
                self.titleLabel.textColor = self.fontDefaultColor;
            }
            if ([keyPath isEqualToString:@"imageDefaultSize"]) {
                [_titleImage removeConstraints:@[layouts[2],layouts[3]]];
                layouts = @[layouts[0],layouts[1],
                            Layout(_titleImage, Width, Equal, nil, Not, 1, self.imageDefaultSize.width),
                            Layout(_titleImage, Height, Equal, nil, Not, 1, self.imageDefaultSize.height)];
                [_titleImage addConstraint:layouts[2]];
                [_titleImage addConstraint:layouts[3]];
            }
            if ([keyPath isEqualToString:@"defaultImage"]) {
                self.titleImage.image = self.defaultImage;
            }
        }else if (self.titleLabel == nil && self.titleImage != nil){
            if ([keyPath isEqualToString:@"imageDefaultSize"]) {
                [_titleImage removeConstraints:@[layouts[2],layouts[3]]];
                
                layouts = @[layouts[0],layouts[1],
                            Layout(_titleImage, Width, Equal, nil, Not, 1, self.imageDefaultSize.width),
                            Layout(_titleImage, Height, Equal, nil, Not, 1, self.imageDefaultSize.height)];
                [_titleImage addConstraint:layouts[2]];
                [_titleImage addConstraint:layouts[3]];
            }
            if ([keyPath isEqualToString:@"defaultImage"]) {
                self.titleImage.image = self.defaultImage;
            }
        }
    }
}

- (void)updateStyle:(NSNotification *)notification{
    NSInteger itemIndex = [notification.userInfo[@"itemIndex"] integerValue];
    if ([objc_getAssociatedObject(self, @"itemIndex") integerValue] == itemIndex) {
        [self customSelectStyle];
    }else{
        [self customDefaultStyle];
    }
}

- (void)customDefaultStyle{
    self.isSelect = NO;
    if (self.titleLabel != nil && self.titleImage != nil) {
        self.titleLabel.textColor = self.fontDefaultColor;
        self.titleLabel.font = [UIFont systemFontOfSize:self.fontDefaultSize];
        self.titleImage.image = self.defaultImage;
        
        [_titleImage removeConstraints:@[layouts[2],layouts[3]]];
        
        layouts = @[layouts[0],layouts[1],
                    Layout(_titleImage, Width, Equal, nil, Not, 1, self.imageDefaultSize.width),
                    Layout(_titleImage, Height, Equal, nil, Not, 1, self.imageDefaultSize.height)];
        [_titleImage addConstraint:layouts[2]];
        [_titleImage addConstraint:layouts[3]];
    }else if (self.titleLabel == nil && self.titleImage != nil){
        self.titleImage.image = self.defaultImage;
        [_titleImage removeConstraints:@[layouts[2],layouts[3]]];
        
        layouts = @[layouts[0],layouts[1],
                    Layout(_titleImage, Width, Equal, nil, Not, 1, self.imageDefaultSize.width),
                    Layout(_titleImage, Height, Equal, nil, Not, 1, self.imageDefaultSize.height)];
        [_titleImage addConstraint:layouts[2]];
        [_titleImage addConstraint:layouts[3]];
    }
}

- (void)customSelectStyle{
    self.isSelect = YES;
    if (self.titleLabel != nil && self.titleImage != nil) {
        self.titleLabel.textColor = self.fontSelectColor;
        self.titleLabel.font = [UIFont systemFontOfSize:self.fontSelectSize];
        self.titleImage.image = self.selectImage == nil ? self.defaultSelectImage : self.selectImage;
        
        [_titleImage removeConstraints:@[layouts[2],layouts[3]]];
        
        layouts = @[layouts[0],layouts[1],
                    Layout(_titleImage, Width, Equal, nil, Not, 1, self.imageSelectSize.width),
                    Layout(_titleImage, Height, Equal, nil, Not, 1, self.imageSelectSize.height)];
        [_titleImage addConstraint:layouts[2]];
        [_titleImage addConstraint:layouts[3]];
    }else if (self.titleLabel == nil && self.titleImage != nil){
        self.titleImage.image = self.selectImage == nil ? self.defaultSelectImage : self.selectImage;
        [_titleImage removeConstraints:@[layouts[2],layouts[3]]];
        
        layouts = @[layouts[0],layouts[1],
                    Layout(_titleImage, Width, Equal, nil, Not, 1, self.imageSelectSize.width),
                    Layout(_titleImage, Height, Equal, nil, Not, 1, self.imageSelectSize.height)];
        [_titleImage addConstraint:layouts[2]];
        [_titleImage addConstraint:layouts[3]];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    id itemIndex = objc_getAssociatedObject(self, @"itemIndex");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ItemDidClickNotifition" object:nil userInfo:@{@"itemIndex":itemIndex}];
}

//改变图片颜色
- (UIImage *)imageWithColor:(UIColor *)color image:(UIImage *)image
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, image.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextClipToMask(context, rect, image.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (void)dealloc{
    [self removeObserver:self forKeyPath:@"fontDefaultSize"];
    [self removeObserver:self forKeyPath:@"fontSelectSize"];
    [self removeObserver:self forKeyPath:@"fontDefaultColor"];
    [self removeObserver:self forKeyPath:@"fontSelectColor"];
    [self removeObserver:self forKeyPath:@"imageDefaultSize"];
    [self removeObserver:self forKeyPath:@"imageSelectSize"];
    [self removeObserver:self forKeyPath:@"imageSelectColor"];
    [self removeObserver:self forKeyPath:@"selectImage"];
    [self removeObserver:self forKeyPath:@"defaultImage"];
}
@end
