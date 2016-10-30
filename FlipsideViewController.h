//
//  FlipsideViewController.h
//  ColorMixer
//
//  Created by Thibault Dardinier on 20/05/11.
//  Copyright 2011 Aucune. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Options.h"

@protocol FlipsideViewControllerDelegate;

@interface FlipsideViewController : UIViewController {
    IBOutlet UISegmentedControl *couleurs_primaires;
    IBOutlet UISegmentedControl *unite;
    
    IBOutlet UILabel *lab_profil;
    IBOutlet UILabel *lab_unite;
    IBOutlet UILabel *lab_RVB;
    IBOutlet UILabel *lab_CMJ;
    IBOutlet UILabel *lab_TSL;
    IBOutlet UILabel *lab_result;

}

- (IBAction)set_valeur_colori;
- (IBAction)set_valeur_unite;

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end


@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end
