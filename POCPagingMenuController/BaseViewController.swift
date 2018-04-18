//
//  BaseViewController.swift
//  POCPagingMenuController
//
//  Created by Tatiana Magdalena on 17/04/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import PagingMenuController
import UIKit

/// The definition of the paging options is needed for the PagingMenuController framework.
struct QuestionPagingOptions: PagingMenuControllerCustomizable {
    var componentType: ComponentType {
        return ComponentType.pagingController(pagingControllers: questionViewControllers)
    }
    
    var isScrollEnabled: Bool {
        return false
    }
    
    var questionViewControllers: [CommonViewController]
    
    init(viewControllers: [CommonViewController]) {
        self.questionViewControllers = viewControllers
    }
}

class BaseViewController: UIViewController {
    @IBOutlet var containerView: UIView!
    @IBOutlet var containerTopConstraint: NSLayoutConstraint!
    
    private var pagingMenuController: PagingMenuController!
    private var viewModel = BaseViewModel()
    
    // MARK: - Lifecycle -
    
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
    
    // MARK: - Paging -
    
    func configureQuestionsPagingMenu() {
        
        // TODO: Get view controllers dynamically
        
        let outputs = viewModel.getNextOutputs()
        var childViewControllers = [CommonViewController]()
        for output in outputs {
            switch output.type {
            case .singleInput: childViewControllers.append(OneInputViewController(title: output.title))
            case .singleSelection(let selectionOptions): childViewControllers.append(SingleSelectionViewController(title: output.title, options: selectionOptions))
            }
        }
        
        let options = QuestionPagingOptions(viewControllers: childViewControllers)
        pagingMenuController = PagingMenuController(options: options)
        pagingMenuController.view.frame = containerView.bounds
        
        addChildViewController(pagingMenuController)
        containerView.addSubview(pagingMenuController.view)
        pagingMenuController.didMove(toParentViewController: self)
    }
    
    @IBAction func goToNextPage(_ sender: UIButton) {
        if viewModel.hasNextPage() {
            let nextPageIndex = viewModel.currentPage + 1
            pagingMenuController.move(toPage: nextPageIndex)
            viewModel.updateCurrentPage(index: nextPageIndex)
        }
    }
    
    @IBAction func backToPreviousPage(_ sender: UIButton) {
        if viewModel.hasPreviousPage() {
            let previousPageIndex = viewModel.currentPage - 1
            pagingMenuController.move(toPage: previousPageIndex)
            viewModel.updateCurrentPage(index: previousPageIndex)
        }
    }
}
