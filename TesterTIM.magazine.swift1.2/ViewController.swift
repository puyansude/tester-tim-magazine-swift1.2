//
//  ViewController.swift
//  TesterTIM.magazine.swift1.2
//
//  Created by Alain on 2015-08-30.
//  Copyright (c) 2015 Production sur support. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController {

    var ecranMagazine   = UIView()
    var imageFinale     = UIImage()
    
    @IBAction func actionFacebook(sender: AnyObject) {
        println("actionFacebook")
        sauvegarderEcran()
        posterSurFacebook()
    } // actionFacebook
    
    @IBAction func actionTwitter(sender: AnyObject) {
        println("actionTwitter")
        sauvegarderEcran()
    } // actionTwitter
    
    /// Fonction exécutée suite à une sélection dans le 'UISegmentedControl'.  Note: Doit-être liée au UISC.
    @IBAction func actionTournerPages(sender: AnyObject) {
        let selection = (sender as! UISegmentedControl).selectedSegmentIndex
        println("actionTournerPages: la sélection vaut: \(selection)")
        
        ecranMagazine.removeFromSuperview()
        ecranMagazine = UINib(nibName: "Magazine0\(selection+1)", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
         view.insertSubview(ecranMagazine, atIndex: view.subviews.count - 1 )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Votre code ici:
        // Créer la vue de 'Magazine01' par prog
        ecranMagazine = UINib(nibName: "Magazine01", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
        
        // Ajouter la nouvelle ‘View’ à la scène principale
        // view.addSubview(ecranMagazine);
        
        println("view.subviews.count: \(view.subviews.count)")
        view.insertSubview(ecranMagazine, atIndex: view.subviews.count - 1 )
    }
    
    func sauvegarderEcran(){
        // Description : méthode servant à capturer l’écran et au besoin,
        // en faire une sauvegarde dans l’album photos.
        
        // 1 - Préparer un contexte de dessin à partir de la taille de la scène
        UIGraphicsBeginImageContext(self.view.bounds.size);
        
        // 2 – Dessiner à partir du claque par défaut de la scène
        self.view.layer.renderInContext(UIGraphicsGetCurrentContext());
        
        // 3 – Stocker le résultat dans notre objet local
        imageFinale = UIGraphicsGetImageFromCurrentImageContext();
        
        // 5 – Fermer le contexte de dessin
        UIGraphicsEndImageContext();
        
        // 6 – Facultatif - Stocker une copie de la capture d’écran dans l’album photos
        UIImageWriteToSavedPhotosAlbum(imageFinale, nil, nil, nil );
    } // sauvegarderEcran
 
    func posterSurFacebook() {
        // Les étapes pour utiliser ‘facebook’
        // 1 - Tester si le service et les informations de connexion sont dispo
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook)
        {
            // 2 - Créer un feuille pour le 'post'
            let controleur = SLComposeViewController (forServiceType: SLServiceTypeFacebook)
            
            // 3 - Composer le message
            controleur.setInitialText("Capture de l'écran TIM.Magazine");
            
            // 4 - Ajouter une image - facultatif
            controleur.addImage(imageFinale);
            
            // 5 - Ajouter un lien - facultatif
            controleur.addURL(NSURL(fileURLWithPath:"http://tim.cstj.qc.ca/cours/xcode/"));
            
            // 6 - Présenter la fenêtre de confirmation à l'utilisateur
            self.presentViewController(controleur, animated: true, completion: nil);
            
        } // if Facebook
    } // posterSurFacebook
    
} // ViewController

