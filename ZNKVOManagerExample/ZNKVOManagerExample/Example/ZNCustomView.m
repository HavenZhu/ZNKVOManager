//
//  ZNCustomView.m
//  ZNKVOManagerExample
//
//  Created by zhuning on 2017/3/14.
//  Copyright © 2017年 zhuning. All rights reserved.
//

#import "ZNCustomView.h"
#import "ZNCustomModel.h"
#import "ZNKVOHeader.h"

@interface ZNCustomView () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *tfInputName;

@property (weak, nonatomic) IBOutlet UILabel *lb163;
@property (weak, nonatomic) IBOutlet UILabel *lbQQ;
@property (weak, nonatomic) IBOutlet UILabel *lbGmail;
@property (weak, nonatomic) IBOutlet UILabel *lb126;

- (IBAction)changeName:(id)sender;

@end

@implementation ZNCustomView

- (void)setModel:(ZNCustomModel *)model {
    _model = model;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldChanged:)
                                                 name:UITextFieldTextDidChangeNotification object:nil];
    
    self.kvoManager = [[ZNKVOManager alloc] initWithObserver:self];
    
    [self.kvoManager observe:_model
                  forKeyPath:@"userName"
                    callBack:^(id observer, id object, NSString *keyPath, NSDictionary<NSKeyValueChangeKey,id> *change) {
                           if (!change) {
                               return;
                           }
                           
                           NSString *newName = change[NSKeyValueChangeNewKey];
                           ZNCustomView *ob = (ZNCustomView *)observer;
                            
                           ob.lb163.text = [NSString stringWithFormat:@"%@@163.com", newName];
                           ob.lbQQ.text = [NSString stringWithFormat:@"%@@qq.com", newName];
                           ob.lbGmail.text = [NSString stringWithFormat:@"%@@gmail.com", newName];
                           ob.lb126.text = [NSString stringWithFormat:@"%@@126.com", newName];
                           ob.tfInputName.text = newName;
                       }];
}

- (IBAction)changeName:(id)sender {
    self.model.userName = [NSString stringWithFormat:@"%lu", (unsigned long)arc4random()];
}

- (void)textFieldChanged:(NSNotification*)notification {
    UITextField *textField = (UITextField *)notification.object;
    if(!textField) {
        return;
    }
    
    self.model.userName = textField.text;
}

@end
