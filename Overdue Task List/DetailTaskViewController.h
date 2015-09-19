//
//  DetailTaskViewController.h
//  
//
//  Created by Anand Kumar on 16/09/2015.
//
//

#import <UIKit/UIKit.h>

@interface DetailTaskViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;
- (IBAction)editBarButtonPressed:(id)sender;

@end
