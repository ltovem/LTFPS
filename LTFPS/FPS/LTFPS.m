//
// LTFPS.m
// LTFPS
//
//  Auther:    田高伟
//  email:     mailto:t@ltove.com
//  webSite:   https://www.ltove.com
//  GitHub:    https://github.com/LTOVEM/
//
// Created by LTOVE on 2019/7/2.
// Copyright © 2019 LTOVE. All rights reserved.
//
    

#import "LTFPS.h"

#define LTFPSWidth 80
#define LTFPSHeight 30
NSNotificationName LTFPSNotification = @"LTFPSNotificationKey";


@interface LTFPSWeakProxy : NSProxy
@property (nonatomic, weak, readonly) id target;
+ (instancetype)proxyWithTarget:(id)target;
@end


@implementation LTFPS {
    UIButton *_fpsButtion;
    NSInteger _count;
    CFTimeInterval _lastTimeInter;
    CADisplayLink *_displayLink;
    double _lastFPSValue;
}

+ (instancetype)share{
    static LTFPS *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (instancetype)init{
    if (self = [super initWithFrame:CGRectMake(10, 10, LTFPSWidth, LTFPSHeight)]) {
        self.windowLevel = UIWindowLevelStatusBar + 1000;
        self.rootViewController = [UIViewController new];
        self.layer.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7].CGColor;
        self.layer.cornerRadius = 4;
        self.hidden = NO;
        _fpsButtion = ({
            _fpsButtion = [UIButton buttonWithType:UIButtonTypeCustom];
            _fpsButtion.titleLabel.font = [UIFont fontWithName:@"Verdana" size:14];
            [_fpsButtion setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
            _fpsButtion.frame = self.rootViewController.view.frame;
            [self addSubview:_fpsButtion];
            [self updateFpsWith:60.0];
            [_fpsButtion addTarget:self action:@selector(didClickAction:) forControlEvents:UIControlEventTouchUpInside];
            _fpsButtion;
        });
        
        _displayLink = ({
            _displayLink = [CADisplayLink displayLinkWithTarget:[LTFPSWeakProxy proxyWithTarget:self] selector:@selector(displayLinkCallBack:)];
            [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
            _displayLink;
        });
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(didPanGestureEnent:)];
        [self addGestureRecognizer:panGesture];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive) name:UIApplicationWillResignActiveNotification object:nil];
    }
    return self;
}

- (void)setEnable:(BOOL)enable{
    _enable = enable;
    if (enable) {
        self.hidden = NO;
    }else{
        self.hidden = YES;
    }
}

- (void)didPanGestureEnent:(UIPanGestureRecognizer *)sender{
    if (sender.state == UIGestureRecognizerStateChanged) {
        CGPoint point = [sender translationInView:self];
        sender.view.layer.position = CGPointMake(sender.view.center.x + point.x, sender.view.center.y + point.y);
        [sender setTranslation:CGPointMake(0, 0) inView:self];
    }
}

- (void)didClickAction:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:LTFPSNotification object:nil];
}

- (void)displayLinkCallBack:(CADisplayLink *)sender{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self->_lastTimeInter = sender.timestamp;
    });
    dispatch_async(dispatch_queue_create("disp", NULL), ^{
        self->_count++;
        CFTimeInterval durtime = sender.timestamp - self->_lastTimeInter;
        
        if (durtime < 1) {
            return;
        }
        double FPS = round(self->_count / durtime);
        self->_count = 0;
        self->_lastTimeInter = sender.timestamp;
        if (FPS != self->_lastFPSValue) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateFpsWith:FPS];
            });
            self->_lastFPSValue = FPS;
        }
    });
    
}

- (void)updateFpsWith:(double)fps{
    [_fpsButtion setTitle:[NSString stringWithFormat:@"FPS:%.0fHz",fps] forState:UIControlStateNormal];
}

#pragma mark --

- (void)applicationDidBecomeActive{
    [_displayLink setPaused:NO];
}

- (void)applicationWillResignActive{
    [_displayLink setPaused:YES];
}

- (void)dealloc{
    [_displayLink invalidate];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end

#pragma mark - weakProxy
@implementation LTFPSWeakProxy
- (instancetype)initWithTarget:(id)target {
    _target = target;
    return self;
}

+ (instancetype)proxyWithTarget:(id)target{
    return [[LTFPSWeakProxy alloc] initWithTarget:target];
}

- (id)forwardingTargetForSelector:(SEL)selector {
    return _target;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    void *null = NULL;
    [invocation setReturnValue:&null];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}

@end
