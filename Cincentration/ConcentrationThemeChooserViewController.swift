//
//  ConcentrationThemeChooserViewController.swift
//  Cincentration
//
//  Created by Admin on 28/06/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController,UISplitViewControllerDelegate {

    let themes = [
        "Sports":"🚴🏻🏊🏻🏏🏇🏻🏌🏻⛹🏻🏋🏻🚣🏻‍♀️🎾🥊🏄🏻‍♀️",
        "Animals":"🦈🐫🐈🐎🐅🐊🦏🦌🕷🦋🐿",
        "Vehicals":"✈️🚔🚤🚂⛵️🚲🚁🏍🚇🚃🚠"
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        splitViewController?.delegate = self
    }
    
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? ConcentrastionViewController{
            if cvc.theme == nil{
                return true
            }
        }
        return false
    }
    
    @IBAction func chooseTheme(_ sender: Any) {
        if let cvc = spliteViewConcentrationViewController{
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName]{
                cvc.theme = theme
            }
        }else if let cvc = lastSegueToConcentrationViewController{
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName]{
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        }else{
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    
    private var spliteViewConcentrationViewController: ConcentrastionViewController? {
        return splitViewController?.viewControllers.last as? ConcentrastionViewController
    }
    
    private var lastSegueToConcentrationViewController: ConcentrastionViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme"{
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName]{
                if let cvc = segue.destination as? ConcentrastionViewController{
                    cvc.theme = theme
                    lastSegueToConcentrationViewController = cvc
                }
            }
        }
    }
}

