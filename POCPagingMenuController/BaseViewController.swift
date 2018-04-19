//
//  BaseViewController.swift
//  POCPagingMenuController
//
//  Created by Tatiana Magdalena on 17/04/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import PagingMenuController
import UIKit

class BaseViewController: UIViewController {
    // Outlets
    @IBOutlet var containerView: UIView!
    @IBOutlet var containerTopConstraint: NSLayoutConstraint!
    
    // Properties
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
        
        handlePageChange()
    }
    
    func createChildViewControllers() -> [CommonViewController] {
        let outputs = viewModel.getNextOutputs()
        var childViewControllers = [CommonViewController]()
        for output in outputs {
            switch output.type {
            case .singleInput:
                childViewControllers.append(OneInputViewController(title: output.title))
            case let .singleSelection(selectionOptions):
                childViewControllers.append(SingleSelectionViewController(title: output.title, options: selectionOptions))
            }
        }
        return childViewControllers
    }
    
    func handlePageChange() {
        pagingMenuController.onMove = { state in
            switch state {
            case let .willMoveController(menuController, previousMenuController):
                print("## WILL MOVE CONTROLLER ##")
                print("From: \(previousMenuController)")
                print("To: \(menuController)")
                
                let commonViewController = previousMenuController as! CommonViewController
                switch commonViewController.layoutType {
                case .singleInput:
                    print("Saindo de uma tela de Single Input")
                case .singleSelection:
                    print("Saindo de uma tela de Single Selection")
                }
                
            case let .didMoveController(menuController, previousMenuController):
                print("## DID MOVE CONTROLLER ##")
                print("From: \(previousMenuController)")
                print("To: \(menuController)")
            default:
                break
            }
        }
    }
    
    @IBAction func goToNextPage(_ sender: UIButton) {
        
        // gather current page information
        
        
        
        // change page
        
        switch viewModel.nextPageIndex() {
        case let .canMoveToNext(newIndex):
            pagingMenuController.move(toPage: newIndex, animated: true)
            viewModel.updateCurrentPage(index: newIndex)
        case .reachedEnd:
            let options = PagingOptions(viewControllers: createChildViewControllers())
            pagingMenuController.setup(options)
        default:
            break
        }
    }
    
    @IBAction func backToPreviousPage(_ sender: UIButton) {
        
        // gather current page information
        
        
        
        // change page
        
        switch viewModel.previousPageIndex() {
        case let .canMoveToPrevious(newIndex):
            pagingMenuController.move(toPage: newIndex, animated: true)
            viewModel.updateCurrentPage(index: newIndex)
        default:
            break
        }
    }
}
