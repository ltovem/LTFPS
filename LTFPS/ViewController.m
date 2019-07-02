//
// ViewController.m
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
    

#import "ViewController.h"
#import "LTFPS.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertView) name:LTFPSNotification object:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    LTFPS.share.enable = !LTFPS.share.enable;
}

- (void)alertView{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"提示内容" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *defaults = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
    [alertVc addAction:defaults];
    [alertVc addAction:cancel];
    [self presentViewController:alertVc animated:YES completion:nil];
}

@end
