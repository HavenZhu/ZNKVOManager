//
//  ViewController.m
//  ZNKVOManagerExample
//
//  Created by zhuning on 2017/3/14.
//  Copyright © 2017年 zhuning. All rights reserved.
//

#import "ViewController.h"
#import "ZNKVOHeader.h"
#import "ZNCustomView.h"
#import "ZNCustomModel.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet ZNCustomView *vCustom;
@property (weak, nonatomic) IBOutlet UILabel *lbUserName;
- (IBAction)changeUserName:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.vCustom.model = [ZNCustomModel new];
    
    self.kvoManager = [[ZNKVOManager alloc] initWithObserver:self];
    [self.kvoManager observe:self.vCustom.model
                  forKeyPath:@"userName"
                    callBack:^(id observer, id object, NSString *keyPath, NSDictionary<NSKeyValueChangeKey,id> *change) {
                           if (!change) {
                               return;
                           }
                           
                           ((ViewController *)observer).lbUserName.text = change[NSKeyValueChangeNewKey];
                       }];
    
}

- (IBAction)changeUserName:(UIButton *)sender {
    self.vCustom.model.userName = [NSString stringWithFormat:@"%lu", (unsigned long)arc4random()];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
