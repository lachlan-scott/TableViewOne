//
//  ViewController.swift
//  TableView
//
//  Created by Lachlan Scott on 2020/02/19.
//  Copyright © 2020 Fudoshin Design for Code Practiq. All rights reserved.
//

import UIKit

//! Of particular interest is this class declaration
//! We're saying this class is a UIViewController, and conforms to UITableViewDelegate and UITableViewDataSource
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	//! Create an empty array of Strings to use as backing data for our table
	var systemColorNames:[String] = []
	var	tableData:[String] = []
	
	//! Outlets for elements from our Storyboard
	@IBOutlet weak var navBar: UINavigationBar!
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var addButton: UIBarButtonItem!
	@IBOutlet weak var barTitle: UINavigationItem!
	@IBOutlet weak var removeButton: UIBarButtonItem!
	
	//! A method to add another item to our table data array.
	//! If we change the backing data, we need to update the display - so reload the table
	//! And update the table title to the new number
	@IBAction func addData(_ sender: Any) {
		tableData.append(systemColorNames.randomElement()!)
		removeButton.isEnabled = true
		tableView.reloadData()
		setTitleText()
	}
	
	@IBAction func removeData(_ sender: Any) {
		// leave at least one item in the data!
		if(tableData.count > 0) {
			let randomIndex = Int.random(in: 0...tableData.count-1)
			tableData.remove(at: randomIndex)
			tableView.reloadData()
			setTitleText()
		}
		
		//! Exercise: User feedback
		//! 1) if there's no more data to delete disable the removeItemButton
		//! 2) then provide some way of re-enabling it
		//! See Exercises for an answer
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()

		//! Create a list of colours we can use in our tableData
		systemColorNames = [
			"black", "blue", "brown", "cyan", "darkGray", "gray", "green", "lightGray", "magenta", "orange", "purple", "red", "white", "yellow"
		]
		
		//! Populate the tableData array with some elements from the list of colours
		for _ in 1 ... 5 {
			tableData.append(systemColorNames.randomElement()!)
		}
		
		//! Then use our UI function to set the title text
		setTitleText()
	}

	/* 	Lesson Notes:  UITableViewController protocol
		A UITableView must conform to the UITableViewController protocol
		that means it requires at least these three following tableview() methods to be implemented
	
		#1 func tableView numberOfRowsInSection
		#2 func numberOfSections in tableView
		#3 func tableView cellForRowAtIndexPath
	
		Exercise: try commenting out one of the required methods and review XCode's error report
	*/

	//! this MUST return the correct size of the datasource; or Very Bad Things® will happen!
	//! Exercise: try to understand why VBT's happen if this returns the wrong size
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		//! Exercise: try changing this eg. return 5 and see what happens ...
		return tableData.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		//! use the cell identifier we made in our Storyboard
		let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")
		
		/* 	refer to the tabledata array we defined
		extracting the item at the array index that corresponds to the table row number
		eg. row 1 - item 1, row 2 - item 2, etc.
		*/
		let description:String = tableData[indexPath.row]
		
		//! UITableViewCell.s include an imageView, textLabel, and detailTextLabel by default
		cell?.textLabel?.text = description
		cell?.detailTextLabel?.text = "UIColor.\(description)"
		
		return cell!
	}
	
/* Lesson Notes: Table Sections
	// Table Sections provide indexing, for example, a list of animals
	// A
	//	Aardvark
	//	Ant
	// 	Armadillo
	// B
	//	Baboon
	//	Badger
	//	Bullfrog
	// etc.
*/
	//! In this table, we only need a single Section
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	//! A 'convenience function' to set the title text whenever we need to do it
	//! It gets the number of table rows by referring to the tableData array
	func setTitleText(){
		barTitle.title = "\(tableData.count) Rows"
	}
	
}

