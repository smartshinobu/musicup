//
//  ViewController.h
//  musicup
//
//  Created by ビザンコムマック０７ on 2014/10/20.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

//ボタンを押すと呼ばれるメソッド
- (IBAction)upload:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *label;
@end

