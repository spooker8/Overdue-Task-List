//
//  DetailTaskViewController.h
//  
//
//  Created by Anand Kumar on 16/09/2015.
//
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "EditTaskViewController.h"

@protocol DetailTaskViewControllerDelegate <NSObject>

-(void)updateTask;

@end


@interface DetailTaskViewController : UIViewController <EditTaskViewControllerDelegate>



@property (strong, nonatomic) Task *task;
@property (weak, nonatomic) id  <DetailTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;

- (IBAction)editBarButtonPressed:(id)sender;

@end
