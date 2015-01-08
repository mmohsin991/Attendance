//
//  ContainerVC.swift
//  AttendanceSystem
//
//  Created by Mohsin on 01/01/2015.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

import UIKit

class ContainerVC: UIViewController, UISplitViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
                
        // Do any additional setup after loading the view.
        performTraitCollectionOverrideForSize(view.bounds.size)
        configureSplitVC()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func performTraitCollectionOverrideForSize(size: CGSize) {
        var overrideTraitCollection: UITraitCollection? = nil
     //   if size.width > size.height {
            overrideTraitCollection = UITraitCollection(horizontalSizeClass: .Regular)
            
            for vc in self.childViewControllers as [UIViewController] {
                setOverrideTraitCollection(overrideTraitCollection, forChildViewController: vc)
     //       }
        }
    }
    
    private func configureSplitVC() {
        let splitVC = self.childViewControllers[0] as UISplitViewController
        
        splitVC.delegate = self
        splitVC.preferredDisplayMode = UISplitViewControllerDisplayMode.PrimaryHidden
        splitVC.preferredPrimaryColumnWidthFraction = 0.4
    }
    
    // MARK: - Split View Controller delegate function
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        performTraitCollectionOverrideForSize(size)
    }
    
    func splitViewController(splitViewController: UISplitViewController!, collapseSecondaryViewController secondaryViewController:UIViewController!, ontoPrimaryViewController primaryViewController:UIViewController!) -> Bool {
        // Return true to indicate that we have handled the collapse by doing nothing;
        // the secondary controller will be discarded.
        return true
    }
    


}
