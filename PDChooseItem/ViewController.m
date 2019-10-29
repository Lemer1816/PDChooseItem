//
//  ViewController.m
//  PDChooseItem
//
//  Created by Lemonade on 2019/10/24.
//  Copyright © 2019 Lemer. All rights reserved.
//

#import "ViewController.h"
#import "PDChooseItemViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.lightGrayColor;
    self.navigationController.navigationItem.title = @"首页";
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    PDChooseItemViewController *vc = [[PDChooseItemViewController alloc] init];
    
//    vc.modalPresentationStyle = UIModalPresentationAutomatic;
//    vc.modalPresentationStyle = UIModalPresentationFullScreen;

    
    [self.navigationController pushViewController:vc animated:YES];
//    [self presentViewController:vc animated:YES completion:nil];
}

@end
