//
//  ViewController.swift
//  InteractiveDismissModal
//
//  Created by 池田 優真 on 2019/03/18.
//  Copyright © 2019 UMA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func tapOpenModal(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Modal") as! ModalViewController
        vc.transitioningDelegate = self
        vc.interactor = interactor
        present(vc, animated: true, completion: nil)
    }
    
    let interactor = Interactor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimator()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
    
}
