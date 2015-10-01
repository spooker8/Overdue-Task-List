//
//  EditTaskViewController.m
//  
//
//  Created by Anand Kumar on 16/09/2015.
//
//

#import "EditTaskViewController.h"

@interface EditTaskViewController ()

@end

@implementation EditTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.textField.text = self.task.title;
    self.textView.text = self.task.description1;
    self.datePicker.date = self.task.date;
    
 
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)saveBarButtonItemPressed:(id)sender {
    
    [self updateTask];
    [self.delegate didUpdateTask];
    
}

-(void)updateTask
{
    
    self.task.title = self.textField.text;
    self.task.description1 = self.textView.text;
    self.task.date = self.datePicker.date;
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
