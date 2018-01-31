//
//  ViewController.m
//  SDKTest2
//
//  Created by Andrew Little on 2017-06-16.
//  Copyright © 2017 Andrew Little. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import <MarketingCloudSDK/MarketingCloudSDK.h>

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
  AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  NSDictionary *cartItem1 = [MarketingCloudSDK.sharedInstance sfmc_cartItemDictionaryWithPrice:@(1.10) quantity:@(1) item:@"111" uniqueId:@"111"];
  NSDictionary *cartItem2 = [MarketingCloudSDK.sharedInstance sfmc_cartItemDictionaryWithPrice:@(4.99) quantity:@(3) item:@"222" uniqueId:@"222"];
  NSDictionary *cartItem3 = [MarketingCloudSDK.sharedInstance sfmc_cartItemDictionaryWithPrice:@(4.99) quantity:@(3) item:@"333" uniqueId:@"333"];
  NSDictionary *cartItem4 = [MarketingCloudSDK.sharedInstance sfmc_cartItemDictionaryWithPrice:@(4.99) quantity:@(3) item:@"333" uniqueId:@"332"];
  NSDictionary *cartItem5 = [MarketingCloudSDK.sharedInstance sfmc_cartItemDictionaryWithPrice:@(4.99) quantity:@(3) item:@"333" uniqueId:@"331"];

  NSDictionary *cart = [MarketingCloudSDK.sharedInstance sfmc_cartDictionaryWithCartItemDictionaryArray:@[cartItem1, cartItem2, cartItem3, cartItem4, cartItem5]];
  [MarketingCloudSDK.sharedInstance sfmc_trackCartContents:cart];
}

- (IBAction)onCompletePurchase:(id)sender {
  //Track a purchase
  NSDictionary *cartItem1 = [MarketingCloudSDK.sharedInstance sfmc_cartItemDictionaryWithPrice:@(1.10) quantity:@(1) item:@"111" uniqueId:@"111"];
  NSDictionary *cartItem2 = [MarketingCloudSDK.sharedInstance sfmc_cartItemDictionaryWithPrice:@(4.99) quantity:@(3) item:@"222" uniqueId:@"222"];
  NSDictionary *cartItem3 = [MarketingCloudSDK.sharedInstance sfmc_cartItemDictionaryWithPrice:@(4.99) quantity:@(3) item:@"333" uniqueId:@"333"];
  NSDictionary *cartItem4 = [MarketingCloudSDK.sharedInstance sfmc_cartItemDictionaryWithPrice:@(4.99) quantity:@(3) item:@"333" uniqueId:@"332"];
  NSDictionary *cartItem5 = [MarketingCloudSDK.sharedInstance sfmc_cartItemDictionaryWithPrice:@(4.99) quantity:@(3) item:@"333" uniqueId:@"331"];
  
  NSDictionary *cart = [MarketingCloudSDK.sharedInstance sfmc_cartDictionaryWithCartItemDictionaryArray:@[cartItem1, cartItem2, cartItem3, cartItem4, cartItem5]];
  [MarketingCloudSDK.sharedInstance  sfmc_orderDictionaryWithOrderNumber:@"1000" shipping:@(2.11) discount:@(4.99) cart:cart];
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

  AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  bool successSport = [MarketingCloudSDK.sharedInstance sfmc_setAttributeNamed:@"FavSport" value:favSport];
  bool successFood = [MarketingCloudSDK.sharedInstance sfmc_setAttributeNamed:@"FavFood" value:favFood];
  
  if (!successSport || !successFood)
  {
    // handle if name is null, blank or one of the reserved words.  Or value is null.
    NSLog(@"Attribute could not be saved :(");
  }
  
  // Add a tag
  bool success = [MarketingCloudSDK.sharedInstance sfmc_addTag:@"iOSTesterApp"];
  
  if (!success){
    // handle if the tag was blank or nil
  }
}

- (void)setBackgroundColor:(UIColor *)color {
  self.view.backgroundColor = color;
}

@end
