//
//  ViewController.m
//  justademo
//
//  Created by admin on 2019/1/7.
//  Copyright © 2019 allyes. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textFiled;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBar.hidden = YES;

}

- (IBAction)showTestWebViewAction:(id)sender {
}


- (IBAction)showCustomerWebViewAction:(id)sender {
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation

 */

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    WebViewController *destination = segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:@"pushToWebView"]) {
        destination.URLString = self.textFiled.text;
    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
