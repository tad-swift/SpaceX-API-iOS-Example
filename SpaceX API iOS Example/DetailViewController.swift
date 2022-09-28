//
//  DetailViewController.swift
//  SpaceX API iOS Example
//
//  Created by Tadreik Campbell on 9/28/22.
//

import UIKit
import SwiftUI

class DetailViewController: UIViewController {
    
    var hostingController: UIHostingController<DetailView>
    
    init(object: DataObject) {
        self.hostingController = UIHostingController(rootView: DetailView(obj: object))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(hostingController.view)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        hostingController.view.frame = view.bounds
    }
    
    
}
