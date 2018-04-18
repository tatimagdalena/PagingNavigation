//
//  SecondViewController.swift
//  POCPagingMenuController
//
//  Created by Tatiana Magdalena on 17/04/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import UIKit

//struct <#name#> {
//    <#fields#>
//}


class SingleSelectionViewController: CommonViewController {

    @IBOutlet var label: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var options: [String]
    var screenTitle: String
    
//    private var viewModel: ViewModelProtocol
//    
//    init(viewModel: ViewModelProtocol) {
//        self.viewModel = viewModel
//        super.init(nibName: "SecondViewController", bundle: Bundle.main)
//    }

    init(title: String, options: [String]) {
        self.options = options
        self.screenTitle = title
        super.init(nibName: "SingleSelectionViewController", bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = screenTitle
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
}

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
