//
//  PlaceNewViewController.h
//  TapPlace
//
//  Created by Thomas Balthazar on 24/07/10.
//  Copyright 2010 Suit My Mind SPRL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Place;


@interface PlaceNewViewController : UIViewController {
	Place *place;
	
	@private
	UITextView *textView;	
}

@property (nonatomic, retain) Place *place;
@property (nonatomic, retain) IBOutlet UITextView *textView;

@end
