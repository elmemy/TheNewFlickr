//
//  AuthenticationRouter.swift
//  TheNewFlickr
//
//  Created by Ahmed Elmemy on 19/07/2021.
//


import UIKit

class AuthenticationRouter {
    
    static func BackAction(viewController:UIViewController){
        
        viewController.navigationController?.popViewController(animated: true)
    }
    
    
    static func Login(viewController:UIViewController){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let nav = UINavigationController(rootViewController: newViewController)
        nav.navigationBar.isHidden = true
        viewController.view.window?.rootViewController = nav
    }
    
    
    
    
    static func PhotoDetails(viewController:UIViewController,url:String){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "PhotoDetailViewController") as! PhotoDetailViewController
        newViewController.imageUrl = url
        viewController.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    

}
