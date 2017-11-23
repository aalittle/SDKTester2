//
//  ViewController.m
//  SDKTest2
//
//  Created by Andrew Little on 2017-06-16.
//  Copyright © 2017 Andrew Little. All rights reserved.
//

#import "ViewController.h"
//#import "ETPush.h"
//#import "PICart.h"
//#import "PICartItem.h"
//#import "PIOrder.h"
//#import "ETAnalytics.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *favFood;
@property (weak, nonatomic) IBOutlet UITextField *favSport;


@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib. hi
}

- (IBAction)onAddToCart:(id)sender {
  // Track the addition of a cart item
//  PICartItem *cartItem1 = [[PICartItem alloc] initWithPrice:@(1.10) quantity:@(1) item:@"111"];
//  PICartItem *cartItem2 = [[PICartItem alloc] initWithPrice:@(4.99) quantity:@(3) item:@"222"];
//  PICartItem *cartItem3 = [[PICartItem alloc] initWithPrice:@(4.99) quantity:@(3) item:@"333" uniqueId:@"333"]; // product 333 sku 333
//  PICartItem *cartItem4 = [[PICartItem alloc] initWithPrice:@(4.99) quantity:@(3) item:@"333" uniqueId:@"332"]; // product 333 sku 332
//  PICartItem *cartItem5 = [[PICartItem alloc] initWithPrice:@(4.99) quantity:@(3) item:@"333" uniqueId:@"331"]; // product 333 sku 331
//
//  PICart *cart = [[PICart alloc] initWithCartItems:@[cartItem1, cartItem2, cartItem3, cartItem4, cartItem5]];
//  [ETAnalytics trackCartContents:cart];
}

- (IBAction)onCompletePurchase:(id)sender {
  //Track a purchase
//  PICartItem *cartItem = [[PICartItem alloc] initWithPrice:@(1.10) quantity:@(1) item:@"111"];
//  PICartItem *cartItem2 = [[PICartItem alloc] initWithPrice:@(1.10) quantity:@(1) item:@"222"];
//  PICartItem *cartItem3 = [[PICartItem alloc] initWithPrice:@(1.10) quantity:@(1) item:@"333" uniqueId:@"333"]; // product 333 sku 333
//  PICartItem *cartItem4 = [[PICartItem alloc] initWithPrice:@(4.99) quantity:@(3) item:@"333" uniqueId:@"332"]; // product 333 sku 332
//  PICartItem *cartItem5 = [[PICartItem alloc] initWithPrice:@(4.99) quantity:@(3) item:@"333" uniqueId:@"331"]; // product 333 sku 331
//
//  PICart *cart = [[PICart alloc] initWithCartItems:@[cartItem, cartItem2, cartItem3, cartItem4, cartItem5]];
//  PIOrder *order = [[PIOrder alloc] initWithOrderNumber:@"1000" shipping:@(2.11) discount:@(4.99) cart:cart];
//  [ETAnalytics trackCartConversion:order];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)onSave:(id)sender {
  NSString *favFood = self.favFood.text;
  NSString *favSport = self.favSport.text;
  
//  // Update the value of the Contact Record attribute
//  // Note that the attribute must be added to the Contact record prior to sending the value
//  // To remove the value, send a blank value
//  // Leading and trailing blanks are removed from the name and value
//  bool successSport = [[ETPush pushManager] addAttributeNamed:@"FavSport" value:favSport];
//  bool successFood = [[ETPush pushManager] addAttributeNamed:@"FavFood" value:favFood];
//  
//  if (!successSport || !successFood)
//  {
//    // handle if name is null, blank or one of the reserved words.  Or value is null.
//    NSLog(@"Attribute could not be saved :(");
//  }
//  
//  // Add a tag
//  bool success = [[ETPush pushManager] addTag:@"iOSTesterApp"];
//  
//  if (!success){
//    // handle if the tag was blank or nil
//  }
//  
}

- (void)setBackgroundColor:(UIColor *)color {
  self.view.backgroundColor = color;
}

@end
