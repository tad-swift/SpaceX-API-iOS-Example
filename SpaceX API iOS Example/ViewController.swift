//
//  ViewController.swift
//  SpaceX API iOS Example
//
//  Created by Tadreik Campbell on 9/28/22.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    var hostingController: UIHostingController<MainView>!

    override func viewDidLoad() {
        super.viewDidLoad()
        var mainView = MainView()
        mainView.vc = self
        hostingController = UIHostingController(rootView: mainView)
        view.addSubview(hostingController.view)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        hostingController.view.frame = view.bounds
    }


}

