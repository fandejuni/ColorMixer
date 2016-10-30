//
//  MainViewController.h
//  ColorMixer
//
//  Created by Thibault Dardinier on 20/05/11.
//  Copyright 2011 Aucune. All rights reserved.
//

#import "FlipsideViewController.h"
#import "Options.h"
#import "math.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate> {
    IBOutlet UILabel *haut;
    IBOutlet UILabel *milieu;
    IBOutlet UILabel *bas;
    
    IBOutlet UILabel *hexa_haut;
    IBOutlet UILabel *hexa_milieu;
    IBOutlet UILabel *hexa_bas;
    
    IBOutlet UILabel *R_haut;
    IBOutlet UILabel *R_milieu;
    IBOutlet UILabel *R_bas;
    
    IBOutlet UILabel *V_haut;
    IBOutlet UILabel *V_milieu;
    IBOutlet UILabel *V_bas;
    
    IBOutlet UILabel *B_haut;
    IBOutlet UILabel *B_milieu;
    IBOutlet UILabel *B_bas;
    
    IBOutlet UISlider *Slider_R_haut;
    IBOutlet UISlider *Slider_V_haut;
    IBOutlet UISlider *Slider_B_haut;
    IBOutlet UISlider *Slider_R_milieu;
    IBOutlet UISlider *Slider_V_milieu;
    IBOutlet UISlider *Slider_B_milieu;
    
    IBOutlet UISlider *proportion;
    IBOutlet UILabel *Prop_1;
    IBOutlet UILabel *Prop_2;
    IBOutlet UIButton *colorimetre;
    
    IBOutlet UIButton *alea_haut;
    IBOutlet UIButton *alea_milieu;
    
    IBOutlet UILabel *Lettre_R_haut;
    IBOutlet UILabel *Lettre_V_haut;
    IBOutlet UILabel *Lettre_B_haut;
    IBOutlet UILabel *Lettre_R_milieu;
    IBOutlet UILabel *Lettre_V_milieu;
    IBOutlet UILabel *Lettre_B_milieu;
    
    IBOutlet UILabel *Lettre_R_bas;
    IBOutlet UILabel *Lettre_V_bas;
    IBOutlet UILabel *Lettre_B_bas;
    
    IBOutlet UIWebView *collect_stats;
    
    IBOutlet UILabel *barriere;
    IBOutlet UILabel *blanc_1;
    IBOutlet UILabel *blanc_2;
    IBOutlet UILabel *P3_1;
    IBOutlet UILabel *P3_2;
    IBOutlet UILabel *P1;
    IBOutlet UILabel *P2;
    IBOutlet UILabel *Ex_1_1;
    IBOutlet UILabel *Ex_1_2;
    IBOutlet UILabel *Ex_2_1;
    IBOutlet UILabel *Ex_2_2;
    IBOutlet UILabel *Ex_3_1;
    IBOutlet UILabel *Ex_3_2;
    IBOutlet UIButton *bouton_close;
    IBOutlet UIButton *bouton_aide;
}

void RGBtoHSV( int r, int g, int b, float *h, float *s, float *v );
void HSVtoRGB( int *r, int *g, int *b, float h, float s, float v );

- (IBAction)afficher_aide:(id)sender;
- (IBAction)cacher_aide:(id)sender;

- (void)fond:(double)R:(double)V:(double)B:(UILabel*)endroit;
- (IBAction)showInfo:(id)sender;
- (IBAction)aleatoire:(id)sender;
- (IBAction)actualiser:(id)sender;
- (void)actualiseur;

@end
