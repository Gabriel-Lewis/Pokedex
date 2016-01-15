//
//  ViewController.swift
//  Pokedex
//
//  Created by Gabriel Benbow on 1/15/16.
//  Copyright © 2016 Gabriel Benbow. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
//IBActions & IBOutlets
	
	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var collection: UICollectionView!
	
//Variables
	
	var pArray = [Pokemon]()
	var filterPArray = [Pokemon]()
	var inSearchMode = false
	
//ViewDidLoad
	
	override func viewDidLoad() {
		super.viewDidLoad()
		collection.delegate = self
		collection.dataSource = self
		searchBar.delegate = self
		parsePokemonCSV()
		
	}
	
	func parsePokemonCSV() {
		let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
		
		do {
			let csv = try CSV(contentsOfURL: path)
			let rows = csv.rows
			
			for row in rows {
				let pokeID = Int(row["id"]!)!
				let name = row["identifier"]!
				let poke = Pokemon(name: name, pokedexID: pokeID)
				pArray.append(poke)
			}
			
			
		} catch {
			print("Didn't work 😢")
		}
	}
	
//CollectionView Code
	
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		
		if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell {
			
			let poke: Pokemon!
			
			if inSearchMode {
				poke = filterPArray[indexPath.row]
			} else {
				poke = pArray[indexPath.row]
			}
			
			
			
			cell.configureCell(poke)
			
			
			return cell
			
		} else {
			return UICollectionViewCell()
		}
		
	}
	
	func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
		
		let poke: Pokemon!
		
		if inSearchMode {
			poke = filterPArray[indexPath.row]
		} else {
			poke = pArray[indexPath.row]
		}
		
		
		performSegueWithIdentifier("PokemonDetailVC", sender: poke)
		
	}
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		if inSearchMode {
			return filterPArray.count
		} else {
			return pArray.count
		}
		
		
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
		return CGSizeMake(105, 105)
	}
	
	func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		return 1
	}

//SearchBar Code
	func searchBarSearchButtonClicked(searchBar: UISearchBar) {
		view.endEditing(true)
	}
	
	func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
		if searchBar.text == nil || searchBar.text == "" {
		inSearchMode = false
		view.endEditing(true)
		collection.reloadData()
		} else {
			inSearchMode = true
			let lower = searchBar.text!.lowercaseString
			filterPArray = pArray.filter({$0.name.rangeOfString(lower) != nil})
			collection.reloadData()
		}
	}
	
//Segue Functions 
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "PokemonDetailVC" {
			if let detailsVC = segue.destinationViewController as? PokemonDetailVC {
				if let poke = sender as? Pokemon {
					detailsVC.pokemon = poke
				}
			}
		}
	}
	
	
}

