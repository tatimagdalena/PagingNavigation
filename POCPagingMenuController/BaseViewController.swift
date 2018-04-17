//
//  BaseViewController.swift
//  POCPagingMenuController
//
//  Created by Tatiana Magdalena on 17/04/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import UIKit
import PagingMenuController

class QuestionViewController: UIViewController {
    
}

struct MenuItem: MenuItemViewCustomizable {}

struct QuestionPagingOptions: PagingMenuControllerCustomizable {
    
    var componentType: ComponentType {
        return ComponentType.pagingController(pagingControllers: questionViewControllers)
    }
    
    var isScrollEnabled: Bool {
        return false
    }
    
    var questionViewControllers: [QuestionViewController]
    
    init(viewControllers: [QuestionViewController]) {
        self.questionViewControllers = viewControllers
    }
    
}

class BaseViewController: UIViewController {

    @IBOutlet var containerView: UIView!
    
    @IBOutlet var containerTopConstraint: NSLayoutConstraint!
    
    private let viewModel = BaseViewModel()
    
    private var pagingMenuController: PagingMenuController!
    private var currentPage = 0
    private var totalPages = 2
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if #available(iOS 11.0, *) {
            
        } else {
            containerTopConstraint.constant = self.topLayoutGuide.length
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureQuestionsPagingMenu()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureQuestionsPagingMenu() {
        
        let options = QuestionPagingOptions(viewControllers: [FirstViewController(viewModel: viewModel), SecondViewController(viewModel: viewModel)])
        pagingMenuController = PagingMenuController(options: options)
        pagingMenuController.view.frame = containerView.bounds
        
        addChildViewController(pagingMenuController)
        containerView.addSubview(pagingMenuController.view)
        pagingMenuController.didMove(toParentViewController: self)
        
    }
    
    @IBAction func goToNextPage(_ sender: UIButton) {
        if currentPage < (totalPages - 1) {
            pagingMenuController.move(toPage: currentPage + 1)
            currentPage += 1
        }
    }
    
    @IBAction func backToPreviousPage(_ sender: UIButton) {
        if currentPage > 0 {
            pagingMenuController.move(toPage: currentPage - 1)
            currentPage -= 1
        }
    }
    
    

}
