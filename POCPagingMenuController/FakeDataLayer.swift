//
//  FakeDataLayer.swift
//  POCPagingMenuController
//
//  Created by Tatiana Magdalena on 19/04/18.
//  Copyright © 2018 Tatiana Magdalena. All rights reserved.
//

import Foundation

struct FakeDataLayer {
    
    // just to alternate between fake outputs
    static private var control = -1
    
    func getOutputCluster() -> [Output] {
        
        FakeDataLayer.control += 1
        
        if FakeDataLayer.control % 2 == 0 {
            let output1 = Output(id: "wijzommdpowe", title: "Single text input, loop \(FakeDataLayer.control)", type: .singleInput)
            let output2 = Output(id: "jdklajsdmkad", title: "Single selection, loop \(FakeDataLayer.control)", type: .singleSelection(options: ["option #1", "option #2"]))
            return [output1, output2]
        }
        else {
            let output1 = Output(id: "sioawiodea", title: "Single selection, loop \(FakeDataLayer.control)", type: .singleSelection(options: ["option #1", "option #2"]))
            let output2 = Output(id: "jaiosjaiow", title: "Single selection, loop \(FakeDataLayer.control)", type: .singleSelection(options: ["option #101", "option #102"]))
            let output3 = Output(id: "pqowpapods", title: "Single text input, loop \(FakeDataLayer.control)", type: .singleInput)
            let output4 = Output(id: "iwopiapsjd", title: "Single text input, loop \(FakeDataLayer.control)", type: .singleInput)
            return [output1, output2, output3, output4]
        }
    }
    
}
