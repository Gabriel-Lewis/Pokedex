//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Gabriel Benbow on 1/15/16.
//  Copyright © 2016 Gabriel Benbow. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

	@IBOutlet weak var nameLbl: UILabel!
	@IBOutlet weak var mainIMG: UIImageView!
	@IBOutlet weak var descriptionLbl: UILabel!
	@IBOutlet weak var typeLbl: UILabel!
	@IBOutlet weak var defenseLbl: UILabel!
	@IBOutlet weak var attackLbl: UILabel!
	@IBOutlet weak var weightLbl: UILabel!
	@IBOutlet weak var heightLbl: UILabel!
	@IBOutlet weak var currentEvoImage: UIImageView!
	@IBOutlet weak var nextEvoImage: UIImageView!
	@IBOutlet weak var pokedexIDLbl: UILabel!
	@IBOutlet weak var evoLabel: UILabel!
	@IBOutlet weak var evoView: UIView!
	
	
	var pokemon: Pokemon!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		nameLbl.text = pokemon.name.capitalizedString
		mainIMG.image = UIImage(named: "\(pokemon.pokedexID)")
		
		
		pokemon.downloadPokemonDetails { () -> () in
			self.updateUI()
		}
	
	}
	
	func updateUI() {
		descriptionLbl.text = pokemon.description
		typeLbl.text = pokemon.type
		defenseLbl.text = pokemon.defense
		weightLbl.text = pokemon.weight
		heightLbl.text = pokemon.height
		attackLbl.text = pokemon.attack
		pokedexIDLbl.text = "\(pokemon.pokedexID)"
		evoLabel.text = pokemon.nextEvolution
		if pokemon.nextEvolutionID == "" {
			evoLabel.hidden = true
			nextEvoImage.hidden = true
			evoView.hidden = true
			
		} else {
			evoLabel.hidden = false
			evoView.hidden = false
			
			nextEvoImage.hidden = false
			nextEvoImage.image = UIImage(named: pokemon.nextEvolutionID)
			var str = "Next Evolution: \(pokemon.nextEvolution)"
			
			if pokemon.nextEvolutionLvl == "" {
				str += "- Lvl \(pokemon.nextEvolutionLvl)"
			}
			
			evoLabel.text = str
		}
		
	
		
	}
	
	@IBAction func backBtnPressed(sender: AnyObject) {
		dismissViewControllerAnimated(true, completion: nil)
	}
}
