//
//  ContainerViewController.swift
//  POCPagingMenuController
//
//  Created by Tatiana Magdalena on 17/04/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import UIKit
import PagingMenuController

class ContainerViewController: UIViewController {
    // Outlets
    @IBOutlet var containerView: UIView!
    @IBOutlet var containerTopConstraint: NSLayoutConstraint!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var previousButton: UIButton!
    
    // Properties
    private var pagingMenuController: PagingMenuController!
    private var viewModel: ContainerViewModelProtocol
    
    init(viewModel: ContainerViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: "ContainerViewController", bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        configurePagingMenu()
    }
    
    // MARK: - Paging -
    
    func configurePagingMenu() {
        let options = Paging.Options(viewControllers: createChildViewControllers())
        pagingMenuController = PagingMenuController(options: options)
        pagingMenuController.view.frame = containerView.bounds
        
        addChildViewController(pagingMenuController)
        containerView.addSubview(pagingMenuController.view)
        pagingMenuController.didMove(toParentViewController: self)
    }
    
    func createChildViewControllers() -> [CommonViewController] {
        let questions = viewModel.getNextQuestions()
        var childViewControllers = [CommonViewController]()
        for question in questions {
            switch question.type {
            case .singleInput:
                childViewControllers.append(OneInputViewController(question: question, viewModel: viewModel, nextButton: nextButton))
            case .singleSelection:
                childViewControllers.append(SingleSelectionViewController(question: question, viewModel: viewModel, nextButton: nextButton))
            }
        }
        return childViewControllers
    }
    
    @IBAction func goToNextPage(_ sender: UIButton) {
        // gather current page information
        
        gatherPageInput()
        
        // change page
        
        switch viewModel.nextPageIndex() {
        case let .canMoveToNext(newIndex):
            pagingMenuController.move(toPage: newIndex, animated: true)
            viewModel.updateCurrentPage(index: newIndex)
        case .reachedEnd:
            viewModel.sendCompilation()
            viewModel.clearCurrentState()
            let options = Paging.Options(viewControllers: createChildViewControllers())
            pagingMenuController.setup(options)
        default:
            break
        }
    }
    
    @IBAction func backToPreviousPage(_ sender: UIButton) {
        // gather current page information
        
        gatherPageInput()
        
        // change page
        
        switch viewModel.previousPageIndex() {
        case let .canMoveToPrevious(newIndex):
            pagingMenuController.move(toPage: newIndex, animated: true)
            viewModel.updateCurrentPage(index: newIndex)
        default:
            break
        }
    }
    
    func gatherPageInput() {
        if let currentViewController = pagingMenuController.pagingViewController?.currentViewController as? CommonViewController {
            if let compilation = currentViewController.compilation {
                viewModel.save(compilation: compilation)
            }
        }
    }
}
