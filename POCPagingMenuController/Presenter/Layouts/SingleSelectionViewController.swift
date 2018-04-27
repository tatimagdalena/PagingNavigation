//
//  SecondViewController.swift
//  POCPagingMenuController
//
//  Created by Tatiana Magdalena on 17/04/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import UIKit

class SingleSelectionViewController: CommonViewController {

    // MARK: Outlets
    
    @IBOutlet var label: UILabel!
    @IBOutlet var tableView: UITableView!
    
    // MARK: Properties
    
    var options = [String]()
    
    // MARK: - Initializers -
    
    init(output: QuestionOutput, viewModel: ContainerViewModelProtocol, nextButton: UIButton, previousButton: UIButton) {
        super.init(output: output, nibName: "SingleSelectionViewController", viewModel: viewModel, nextButton: nextButton, previousButton: previousButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = output.title
        
        if case let Layout.singleSelection(options) = output.inputLayout {
            self.options = options
        }
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
}

// MARK: - Table view -

extension SingleSelectionViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = options[indexPath.row]
        
        return cell
    }
}

extension SingleSelectionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedValue = options[indexPath.row]
        let input = Input(id: selectedValue, data: selectedValue)
        compilation = AnswerCompilation(relatedQuestionId: output.id, inputs: [input])
        
        handleNewSelection()
    }
    
    func handleNewSelection() {
        let status = viewModel.inputChanged(newInput: tableView.indexPathsForSelectedRows?.count ?? 0)
        updateNextButtonUI(status: status)
    }
}
