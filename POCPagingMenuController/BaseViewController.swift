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
    
    var lazyLoadingPage: LazyLoadingPage {
        return .one
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
        let options = QuestionPagingOptions(viewControllers: createChildViewControllers())
        pagingMenuController = PagingMenuController(options: options)
        pagingMenuController.view.frame = containerView.bounds
        
        addChildViewController(pagingMenuController)
        containerView.addSubview(pagingMenuController.view)
        pagingMenuController.didMove(toParentViewController: self)
        
        pagingMenuController.onMove = { state in
            switch state {
            case let .willMoveController(menuController, previousMenuController):
                print("## WILL MOVE CONTROLLER ##")
                print("From: \(previousMenuController)")
                print("To: \(menuController)")
            case let .didMoveController(menuController, previousMenuController):
                print("## DID MOVE CONTROLLER ##")
                print("From: \(previousMenuController)")
                print("To: \(menuController)")
            case let .willMoveItem(menuItemView, previousMenuItemView):
                print(previousMenuItemView)
                print(menuItemView)
            case let .didMoveItem(menuItemView, previousMenuItemView):
                print(previousMenuItemView)
                print(menuItemView)
            case .didScrollStart:
                print("Scroll start")
            case .didScrollEnd:
                print("Scroll end")
            }
        }
    }
    
    @IBAction func goToNextPage(_ sender: UIButton) {
        switch viewModel.nextPageIndex() {
        case let .canMoveToNext(newIndex):
            pagingMenuController.move(toPage: newIndex, animated: true)
            viewModel.updateCurrentPage(index: newIndex)
        case .reachedEnd:
            let options = QuestionPagingOptions(viewControllers: createChildViewControllers())
            pagingMenuController.setup(options)
        default:
            break
        }
    }
    
    @IBAction func backToPreviousPage(_ sender: UIButton) {
        switch viewModel.previousPageIndex() {
        case let .canMoveToPrevious(newIndex):
            pagingMenuController.move(toPage: newIndex, animated: true)
            viewModel.updateCurrentPage(index: newIndex)
        default:
            break
        }
    }
    
    func createChildViewControllers() -> [CommonViewController] {
        let outputs = viewModel.getNextOutputs()
        var childViewControllers = [CommonViewController]()
        for output in outputs {
            switch output.type {
            case .singleInput: childViewControllers.append(OneInputViewController(title: output.title))
            case let .singleSelection(selectionOptions): childViewControllers.append(SingleSelectionViewController(title: output.title, options: selectionOptions))
            }
        }
        return childViewControllers
    }
}
