//
//  ZDGuideView.m
//  DrawLine
//
//  Created by zhuchao on 14-7-24.
//  Copyright (c) 2014年 baidu. All rights reserved.
//

#import "ZDGuideView.h"
#import <Accelerate/Accelerate.h>

#import <Availability.h>


@interface ZDGuideView()
@property(nonatomic,strong) UIColor *bgColor;
@property(nonatomic,weak) UIView *revealView;
@property(nonatomic,assign) ZDRevealType revealType;
@property(nonatomic,strong) UIImage *bgImage;
@property(nonatomic,assign) BOOL removing;
@property(nonatomic,assign) CGFloat blurRadius;
@end

@implementation ZDGuideView


- (instancetype)initWithBgColor:(UIColor *)aColor revealView:(UIView *)aView revealType:(ZDRevealType)aType
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        self.revealView = aView;
        self.revealType = aType;
        self.bgColor = aColor;
        self.bgImage = [self.class zd_imageWithColor:aColor];
    }
    return self;
}

- (instancetype)initWithBlurRadius:(CGFloat)aFloat revealView:(UIView *)aView revealType:(ZDRevealType)aType
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        self.revealView = aView;
        self.revealType = aType;
        self.blurRadius = aFloat;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
//    NSLog(@"drawing.....");
    if (!_bgImage) {
        return;
    }
    
    [_bgImage drawInRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetBlendMode(context, kCGBlendModeClear);
    
    UIBezierPath* path = nil;
    switch (_revealType) {
        case ZDRevealTypeRect:
            path = [UIBezierPath bezierPathWithRect:[self revealRect]];
            break;
        case ZDRevealTypeOval:{
            CGRect round = [self ovalRect];
            path = [UIBezierPath bezierPathWithOvalInRect:round];
        }
            break;
        default:
            break;
    }
    [[UIColor clearColor] set];
    [path fill];
    
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
//    NSLog(@"hitTest");
    UIView *view = [super hitTest:point withEvent:event];
    CGRect viewRect = [self revealRect];
    [self remove];
    if (CGRectContainsPoint(viewRect, point)) {
        return nil;
    }
    return view;
    
    
}

- (void)showInView:(UIView *)aView
{
    self.alpha = 0.0f;
    [self setFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(aView.bounds), CGRectGetHeight(aView.bounds))];
    if (!self.bgColor) {
        self.bgImage = [self.class zd_blurredImageWithImage:[self.class zd_imageFromView:aView andOpaque:NO] radius:self.blurRadius iterations:3 tintColor:[UIColor colorWithWhite:0.0f alpha:0.3f]];
    }
    [aView addSubview:self];
    [aView setNeedsDisplay];
    
    [UIView animateWithDuration:0.2 delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.alpha = 1.0f;
                     }
                     completion:nil];
    
}

- (void)remove
{
    if (self.removing) return;
    
    self.removing = YES;
    [UIView animateWithDuration:0.2 delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.alpha = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             [self removeFromSuperview];
                         }
                     }];
}

- (CGRect)revealRect
{
    CGRect realRect = [_revealView convertRect:CGRectMake(0.0f, 0.0f, CGRectGetWidth(_revealView.bounds), CGRectGetHeight(_revealView.bounds)) toView:self];
    return CGRectInset(realRect, _insetX, _insetY);
}

- (CGRect)ovalRect
{
    CGRect rect = [self revealRect];
    //圆的直径
    CGFloat diameter = floorf(sqrtf(rect.size.width*rect.size.width + rect.size.height*rect.size.height));
    CGFloat rate = rect.size.width/rect.size.height;
    CGSize newSize;
    if (rate >= 1) {//宽大于长
        newSize = CGSizeMake(diameter, diameter/rate);
    } else {
        newSize = CGSizeMake(diameter/rate,diameter);
    }
    
    return CGRectMake(rect.origin.x - (newSize.width - rect.size.width)/2.0f, rect.origin.y - (newSize.height - rect.size.height)/2.0f, newSize.width, newSize.height);
}

#pragma mark - Image

+ (UIImage *)zd_imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


+ (UIImage *)zd_imageFromView:(UIView *)view andOpaque:(BOOL) opaque
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, opaque, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)zd_blurredImageWithImage:(UIImage *)image radius:(CGFloat)radius iterations:(NSUInteger)iterations  tintColor:(UIColor *)tintColor
{
    //image must be nonzero size
    NSAssert(image.size.width > 0 && image.size.height > 0, @"size error");
    
    //boxsize must be an odd integer
    uint32_t boxSize = radius * image.scale;
    if (boxSize % 2 == 0) boxSize ++;
    
    //create image buffers
    CGImageRef imageRef = image.CGImage;
    vImage_Buffer buffer1, buffer2;
    buffer1.width = buffer2.width = CGImageGetWidth(imageRef);
    buffer1.height = buffer2.height = CGImageGetHeight(imageRef);
    buffer1.rowBytes = buffer2.rowBytes = CGImageGetBytesPerRow(imageRef);
    CFIndex bytes = buffer1.rowBytes * buffer1.height;
    buffer1.data = malloc(bytes);
    buffer2.data = malloc(bytes);
    
    //create temp buffer
    void *tempBuffer = malloc(vImageBoxConvolve_ARGB8888(&buffer1, &buffer2, NULL, 0, 0, boxSize, boxSize,
                                                         NULL, kvImageEdgeExtend + kvImageGetTempBufferSize));
    
    //copy image data
    CFDataRef dataSource = CGDataProviderCopyData(CGImageGetDataProvider(imageRef));
    memcpy(buffer1.data, CFDataGetBytePtr(dataSource), bytes);
    CFRelease(dataSource);
    
    for (NSUInteger i = 0; i < iterations; i++)
    {
        //perform blur
        vImageBoxConvolve_ARGB8888(&buffer1, &buffer2, tempBuffer, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
        
        //swap buffers
        void *temp = buffer1.data;
        buffer1.data = buffer2.data;
        buffer2.data = temp;
    }
    
    free(buffer2.data);
    free(tempBuffer);
    
    CGContextRef ctx = CGBitmapContextCreate(buffer1.data, buffer1.width, buffer1.height,
                                             8, buffer1.rowBytes, CGImageGetColorSpace(imageRef),
                                             CGImageGetBitmapInfo(imageRef));
    
    //apply tint
    if (tintColor && CGColorGetAlpha(tintColor.CGColor) > 0.0f)
    {
        CGContextSetFillColorWithColor(ctx, tintColor.CGColor);
        CGContextSetBlendMode(ctx, kCGBlendModeNormal);
        CGContextFillRect(ctx, CGRectMake(0, 0, buffer1.width, buffer1.height));
    }
    
    
    imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *newImage = [UIImage imageWithCGImage:imageRef scale:image.scale orientation:image.imageOrientation];
    CGImageRelease(imageRef);
    CGContextRelease(ctx);
    free(buffer1.data);
    return newImage;
}




@end
