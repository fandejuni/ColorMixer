//
//  main.m
//  ColorMixer
//
//  Created by Thibault Dardinier on 16/05/11.
//  Copyright 2011 Aucune. All rights reserved.
//

#import <UIKit/UIKit.h>

int bool_couleurs_primaires;
int bool_unite;
int couleur_1_R;
int couleur_1_V;
int couleur_1_B;
int couleur_2_R;
int couleur_2_V;
int couleur_2_B;

int main(int argc, char *argv[])
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, nil);
    [pool release];
    return retVal;
}
