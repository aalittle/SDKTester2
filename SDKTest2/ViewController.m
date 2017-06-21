//
//  ViewController.m
//  SDKTest2
//
//  Created by Andrew Little on 2017-06-16.
//  Copyright © 2017 Andrew Little. All rights reserved.
//

#import "ViewController.h"
#import "ETPush.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *favFood;
@property (weak, nonatomic) IBOutlet UITextField *favSport;


@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)onSave:(id)sender {
  NSString *favFood = self.favFood.text;
  NSString *favSport = self.favSport.text;
  
  // Update the value of the Contact Record attribute
  // Note that the attribute must be added to the Contact record prior to sending the value
  // To remove the value, send a blank value
  // Leading and trailing blanks are removed from the name and value
  bool successSport = [[ETPush pushManager] addAttributeNamed:@"FavSport" value:favSport];
  bool successFood = [[ETPush pushManager] addAttributeNamed:@"FavFood" value:favFood];
  
  if (!successSport || !successFood)
  {
    // handle if name is null, blank or one of the reserved words.  Or value is null.
    NSLog(@"Attribute could not be saved :(");
  }
  
  // Add a tag
  bool success = [[ETPush pushManager] addTag:@"iOSTesterApp"];
  
  if (!success){
    // handle if the tag was blank or nil
  }
  
}

- (void)setBackgroundColor:(UIColor *)color {
  self.view.backgroundColor = color;
}

@end
