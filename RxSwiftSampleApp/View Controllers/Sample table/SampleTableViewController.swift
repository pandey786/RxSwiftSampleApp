//
//  SampleTableViewController.swift
//  RxSwiftSampleApp
//
//  Created by Durgesh Pandey on 08/11/17.
//  Copyright © 2017 Durgesh Pandey. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct Employee {
    var employeeName: String?
    var employeeDesignation: String?
    var employeeDetails: EmployeeDetails?
}

struct  EmployeeDetails {
    var empDetails: String?
}

class SampleTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //Create Datasource Array
    var employeesList: Variable<[Employee]> = Variable([])
    
    //Create Dispose Bag
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up Navigation Bar
        setUpNavigationBar(title: "Sample RxSwift")
        
        //Set Up Datasource Array
        setUpDataSourceArray()
        
        //Add DataSource Observers
        addObserverForDataSource()
        
        //Set up table Cell Configuration
        setUpTableCellConfiguration()
        
        //Set table Delegates
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        //Set Estimated height of tableview
        tableView.estimatedRowHeight = 50
       
    }
    
    func addObserverForDataSource() {
        
        employeesList.asObservable().subscribe(onNext: { (employeeListArr) in
            
            //Updated list Of Employees
            print(employeeListArr)
            
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
        }) {
            }.disposed(by: disposeBag)
    }
    
    func setUpDataSourceArray() {
        
        //Set Up Employee List
        for index in 1...20 {
            var employee = Employee()
            employee.employeeName = "Employee \(index)"
            employee.employeeDesignation = "Designation \(index)"
            employeesList.value.append(employee)
        }
    }
    
    @IBAction func didPressAddEmployeeButton(_ sender: Any) {
        
        var employee = Employee()
        employee.employeeName = "Employee \(employeesList.value.count + 1)"
        employee.employeeDesignation = "Designation \(employeesList.value.count + 1)"
        employeesList.value.append(employee)
        
        //Scroll to last inserted item in table view
        tableView.scrollToRow(at: IndexPath.init(row: employeesList.value.count - 1, section: 0), at: .bottom, animated: true)
    }
}

extension SampleTableViewController: UITableViewDelegate {
    
    func setUpTableCellConfiguration() {
        
        employeesList.asObservable().bind(to: tableView.rx.items(cellIdentifier: "SampleTableViewCell")) {(index, employee: Employee, cell: SampleTableViewCell) in
            
            //Set Up Cell
            cell.lblTitle.text = employee.employeeName
            
            }.disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
