//
//  PlaceDetailsViewController.h
//  TapPlace
//
//  Created by Thomas Balthazar on 30/08/10.
//  Copyright 2010 Suit My Mind SPRL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Place;

@interface PlaceDetailsViewController : UIViewController {
	UITextView *textView;

	@private
	Place *place;
}

@property (nonatomic, retain) IBOutlet UITextView *textView;
@property (nonatomic, retain) Place *place;

@end
