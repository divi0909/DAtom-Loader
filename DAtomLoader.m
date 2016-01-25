//
//  DAtomLoader.m
// 
//
//  Created by Divyanshu Sharma on 25/01/16.


#import "DAtomLoader.h"

@implementation DAtomLoader
{
    UIImageView *ViewAnimation1,*ViewAnimation2,*ViewAnimation3,*ViewAnimation4,*ViewCenter;
        
    CGMutablePathRef path1,path2,path3,path4;
    
    CGPathRef tiltedPath1,tiltedPath2;
    
    BOOL isLoading,isShown;
    
}

+(DAtomLoader *)sharedInstance {
    static dispatch_once_t onceToken;
    static DAtomLoader *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[DAtomLoader alloc] init];
    });
    return instance;
}

-(id)init
{
    return [super init];
}

static CGPathRef createPathRotatedAroundBoundingBoxCenter(CGPathRef path, CGFloat radians) {
    CGRect bounds = CGPathGetBoundingBox(path); // might want to use CGPathGetPathBoundingBox
    CGPoint center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformTranslate(transform, center.x, center.y);
    transform = CGAffineTransformRotate(transform, radians);
    transform = CGAffineTransformTranslate(transform, -center.x, -center.y);
    return CGPathCreateCopyByTransformingPath(path, &transform);
}

#pragma mark
#pragma mark-Show/Hide

-(void)starAnimation:(UIView *)superView
{
    isLoading = YES;
    
    superView.layer.opacity = 0.5;
    
    superView.userInteractionEnabled = NO;
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    [self SetImagesForrAtomView];
    
    [self SetCenterImageforAtomView];
    
    // Path For Left Titlted Circle
    path1 = CGPathCreateMutable();
    
    // Path for Right Tilted Circle
    path2 = CGPathCreateMutable();
    
    // Path for Horizontal circle
    path3 = CGPathCreateMutable();
    
    // Path for Vertical circle
    path4 = CGPathCreateMutable();
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        
        CGPathAddEllipseInRect(path1, nil, CGRectMake(window.center.x-80, window.center.y-30,160,60));
        CGPathAddEllipseInRect(path2, nil, CGRectMake(window.center.x-80, window.center.y-30, 160, 60));
        CGPathAddEllipseInRect(path3, nil, CGRectMake(window.center.x-80, window.center.y-30, 160, 60));
        CGPathAddEllipseInRect(path4, nil, CGRectMake(window.center.x-30, window.center.y-80, 60, 160));
        
    }
    else
    {
        
        CGPathAddEllipseInRect(path1, nil, CGRectMake(window.center.x-40, window.center.y-15,80,30));
        CGPathAddEllipseInRect(path2, nil, CGRectMake(window.center.x-40, window.center.y-15, 80, 30));
        CGPathAddEllipseInRect(path3, nil, CGRectMake(window.center.x-40, window.center.y-15, 80, 30));
        CGPathAddEllipseInRect(path4, nil, CGRectMake(window.center.x-15, window.center.y-40, 30, 80));
        
    }
    
    tiltedPath1 = createPathRotatedAroundBoundingBoxCenter(path1, M_PI/4);
    
    tiltedPath2 = createPathRotatedAroundBoundingBoxCenter(path2, -M_PI/4);
    
    
    // Drawing Path With CAShape Layer On created path
    
    [self drawShapesOnpath:tiltedPath1 withColor:[UIColor redColor]];
    
    [self drawShapesOnpath:tiltedPath2 withColor:[UIColor blueColor]];
    
    [self drawShapesOnpath:path3 withColor:[UIColor greenColor]];
    
    [self drawShapesOnpath:path4 withColor:[UIColor orangeColor]];
    
    
    
    // Setting Up Different Animations For Different Paths
    
    CAKeyframeAnimation *pathAnimation1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation1.removedOnCompletion = NO;
    pathAnimation1.path = tiltedPath1;
    pathAnimation1.calculationMode = kCAAnimationPaced;
    [pathAnimation1 setFillMode:kCAFillModeForwards];
    pathAnimation1.duration = 2.0;
    pathAnimation1.repeatCount = INFINITY;
    
    CAKeyframeAnimation *pathAnimation2 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation2.removedOnCompletion = NO;
    pathAnimation2.path = tiltedPath2;
    pathAnimation2.calculationMode = kCAAnimationPaced;
    [pathAnimation2 setFillMode:kCAFillModeForwards];
    pathAnimation2.duration = 2.0;
    pathAnimation2.repeatCount = INFINITY;
    
    CAKeyframeAnimation *pathAnimation3 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation3.removedOnCompletion = NO;
    pathAnimation3.path = path3;
    pathAnimation3.calculationMode = kCAAnimationPaced;
    [pathAnimation3 setFillMode:kCAFillModeForwards];
    pathAnimation3.duration = 2.0;
    pathAnimation3.repeatCount = INFINITY;
    
    
    CAKeyframeAnimation *pathAnimation4 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation4.removedOnCompletion = NO;
    pathAnimation4.path = path4;
    pathAnimation4.calculationMode = kCAAnimationPaced;
    [pathAnimation4 setFillMode:kCAFillModeForwards];
    pathAnimation4.duration = 2.0;
    pathAnimation4.repeatCount = INFINITY;
    
    
    // Invoke Animation in dispatch_after to show random rotation
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1* NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [ViewAnimation1.layer addAnimation:pathAnimation1 forKey:@"move1"];
        ViewAnimation1.hidden = NO;
    });
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.7* NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [ViewAnimation2.layer addAnimation:pathAnimation2 forKey:@"move2"];
        ViewAnimation2.hidden = NO;
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3* NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [ViewAnimation3.layer addAnimation:pathAnimation3 forKey:@"move3"];
        ViewAnimation3.hidden = NO;
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2* NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [ViewAnimation4.layer addAnimation:pathAnimation4 forKey:@"move4"];
        ViewAnimation4.hidden = NO;
    });
    
}

-(void)stopAnimation:(UIView *)superView
{
    superView.layer.opacity = 1.0;
    
    isLoading = NO;
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    UINavigationController *navigationControllerG = (UINavigationController *)window.rootViewController;
    
    [navigationControllerG shouldAutorotate];
    
    superView.userInteractionEnabled = YES;
    
    [ViewAnimation1.layer removeAnimationForKey:@"move1"];
    
    [ViewAnimation2.layer removeAnimationForKey:@"move2"];
    
    [ViewAnimation3.layer removeAnimationForKey:@"move3"];
    
    [ViewAnimation4.layer removeAnimationForKey:@"move4"];
    
    [ViewAnimation1 removeFromSuperview];
    
    [ViewAnimation2 removeFromSuperview];
    
    [ViewAnimation3 removeFromSuperview];
    
    [ViewAnimation4 removeFromSuperview];
    
    [ViewCenter removeFromSuperview];
    
    
    NSArray *array = [window.layer.sublayers mutableCopy];
    
    for(CAShapeLayer *layer in array)
    {
        if([layer isKindOfClass:[CAShapeLayer class]])
        {
            [layer removeFromSuperlayer];
        }
    }
}

#pragma mark
#pragma mark-Private Methods

-(void)setCenterImage:(UIImage *)yourImage
{
    _centerImage = yourImage;
}

-(void)SetCenterImageforAtomView
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        ViewCenter = [[UIImageView alloc]initWithFrame:CGRectMake(window.center.x-20, window.center.y-20, 40, 40)];
    }
    else
    {
        ViewCenter = [[UIImageView alloc]initWithFrame:CGRectMake(window.center.x-12, window.center.y-12, 24, 24)];
    }
    
    if(_centerImage)
    {
        ViewCenter.image = _centerImage;
    }
    else
    {
        ViewCenter.backgroundColor = [UIColor blueColor];
    }
    [window addSubview:ViewCenter];
    
}

-(void)drawShapesOnpath:(CGPathRef)path withColor:(UIColor *)color
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    layer.path = path;
    
    layer.strokeColor = [color CGColor];
    
    layer.lineWidth = 1.0;
    
    layer.fillColor = nil;
    
    layer.shouldRasterize = YES;
    
    layer.contentsScale = [[UIScreen mainScreen] scale];
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    [window.layer addSublayer:layer];
}




-(void)SetImagesForrAtomView
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        ViewAnimation1 = [[UIImageView alloc]initWithFrame:CGRectMake(window.center.x-40,window.center.y, 12, 12)];
        ViewAnimation2 = [[UIImageView alloc]initWithFrame:CGRectMake(window.center.x-40,window.center.y,12,12)];
        ViewAnimation3 = [[UIImageView alloc]initWithFrame:CGRectMake(window.center.x-40,window.center.y, 12, 12)];
        ViewAnimation4 = [[UIImageView alloc]initWithFrame:CGRectMake(window.center.x-40,window.center.y, 12, 12)];
        
        ViewAnimation1.layer.cornerRadius = 10.0;
        ViewAnimation2.layer.cornerRadius = 10.0;
        ViewAnimation3.layer.cornerRadius = 10.0;
        ViewAnimation4.layer.cornerRadius = 10.0;
    }
    else
    {
        ViewAnimation1 = [[UIImageView alloc]initWithFrame:CGRectMake(window.center.x-20,window.center.y, 6, 6)];
        ViewAnimation2 = [[UIImageView alloc]initWithFrame:CGRectMake(window.center.x-20,window.center.y,6,6)];
        ViewAnimation3 = [[UIImageView alloc]initWithFrame:CGRectMake(window.center.x-20,window.center.y, 6, 6)];
        ViewAnimation4 = [[UIImageView alloc]initWithFrame:CGRectMake(window.center.x-20,window.center.y, 6, 6)];
        
        ViewAnimation1.layer.cornerRadius = 5.0;
        ViewAnimation2.layer.cornerRadius = 5.0;
        ViewAnimation3.layer.cornerRadius = 5.0;
        ViewAnimation4.layer.cornerRadius = 5.0;
    }
    
    ViewAnimation1.backgroundColor = [UIColor whiteColor];
    ViewAnimation2.backgroundColor = [UIColor whiteColor];
    ViewAnimation3.backgroundColor = [UIColor whiteColor];
    ViewAnimation4.backgroundColor = [UIColor whiteColor];
    
    ViewAnimation1.hidden = YES;
    
    ViewAnimation3.hidden = YES;
    
    ViewAnimation2.hidden = YES;
    
    ViewAnimation4.hidden = YES;
    
    [window addSubview:ViewAnimation1];
    
    [window addSubview:ViewAnimation2];
    
    [window addSubview:ViewAnimation3];
    
    [window addSubview:ViewAnimation4];
    
}


@end
