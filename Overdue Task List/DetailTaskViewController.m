//
//  DetailTaskViewController.m
//  
//
//  Created by Anand Kumar on 16/09/2015.
//
//

#import "DetailTaskViewController.h"

@interface DetailTaskViewController ()

@end

@implementation DetailTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.titleLabel.text = self.task.title;
    self.detailLabel.text = self.task.description1;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *stringFromDate = [formatter stringFromDate:self.task.date];
    
    self.dateLabel.text = stringFromDate;
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.destinationViewController isKindOfClass:[EditTaskViewController class]])
    {
        
        EditTaskViewController *editTaskViewController = segue.destinationViewController;
        editTaskViewController.task = self.task;
        
        editTaskViewController.delegate = self;    //persist in nsuserdefault
        
        
    }
    
}



- (IBAction)editBarButtonPressed:(id)sender {
    
    [self performSegueWithIdentifier:@"toEditTaskViewController" sender:nil];
    
   
    
}


-(void)didUpdateTask
{
    
    self.titleLabel.text = self.task.title;
    self.detailLabel.text = self.task.description1;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyy-MM-dd"];
    NSString *stringFromDate = [formatter stringFromDate:self.task.date];
    self.dateLabel.text = stringFromDate;
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [self.delegate updateTask];
    
    
    
}



@end
