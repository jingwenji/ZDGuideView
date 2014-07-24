//
//  ZDViewController.m
//  ZDCoverTipView
//
//  Created by zhuchao on 14-7-24.
//  Copyright (c) 2014年 baidu. All rights reserved.
//

#import "ZDViewController.h"
#import "ZDCoverTipView.h"

@interface ZDViewController ()
@property(nonatomic,strong) IBOutlet UILabel *label;
@property(nonatomic,strong) IBOutlet UIButton *button;
@property(nonatomic,strong) IBOutlet UIButton *buttonLong;
@property(nonatomic,strong) IBOutlet UISwitch *typeSwitch;

@end

@implementation ZDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)showLableCover:(id)sender
{
    ZDCoverTipView *tip = [[ZDCoverTipView alloc] initWithBgColor:[UIColor colorWithWhite:0.0f alpha:0.5f] revealView:_label revealType:_typeSwitch.on?ZDRevealTypeOval:ZDRevealTypeRect];
    tip.insetY = -5.0f;
    tip.insetX = -5.0f;
    [tip showInView:self.view];
}

- (IBAction)showButtonCover:(id)sender
{
    ZDCoverTipView *tip = [[ZDCoverTipView alloc] initWithBlurRadius:10.0f revealView:_button revealType:_typeSwitch.on?ZDRevealTypeOval:ZDRevealTypeRect];
    tip.insetY = -8.0f;
    tip.insetX = -8.0f;
    [tip showInView:self.view];
    
}

- (IBAction)showLongBtnCover:(id)sender
{
    ZDCoverTipView *tip = [[ZDCoverTipView alloc] initWithBgColor:[UIColor colorWithWhite:0.0f alpha:0.5f] revealView:_buttonLong revealType:_typeSwitch.on?ZDRevealTypeOval:ZDRevealTypeRect];
    tip.insetY = -15.0f;
    tip.insetX = -15.0f;
    [tip showInView:self.view];
    
}


@end
