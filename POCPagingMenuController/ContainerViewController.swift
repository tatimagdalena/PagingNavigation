//
//  ContainerViewController.swift
//  POCPagingMenuController
//
//  Created by Tatiana Magdalena on 17/04/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import PagingMenuController
import UIKit

class ContainerViewController: UIViewController {
    // Outlets
    @IBOutlet var containerView: UIView!
    @IBOutlet var containerTopConstraint: NSLayoutConstraint!
    
    // Properties
    private var pagingMenuController: PagingMenuController!
    private var viewModel = ContainerViewModel()
    
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
        let options = PagingOptions(viewControllers: createChildViewControllers())
        pagingMenuController = PagingMenuController(options: options)
        pagingMenuController.view.frame = containerView.bounds
        
        addChildViewController(pagingMenuController)
        containerView.addSubview(pagingMenuController.view)
        pagingMenuController.didMove(toParentViewController: self)
    }
    
    func createChildViewControllers() -> [CommonViewController] {
        let outputs = viewModel.getNextOutputs()
        var childViewControllers = [CommonViewController]()
        for output in outputs {
            switch output.type {
            case .singleInput:
                childViewControllers.append(OneInputViewController(output: output))
            case .singleSelection:
                childViewControllers.append(SingleSelectionViewController(output: output))
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
            viewModel.sendInputs()
            viewModel.clearCurrentState()
            let options = PagingOptions(viewControllers: createChildViewControllers())
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
            if let input = currentViewController.input {
                viewModel.save(input: input)
            }
        }
    }
}
