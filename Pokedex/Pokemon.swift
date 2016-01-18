//
//  Pokemon.swift
//  Pokedex
//
//  Created by Gabriel Benbow on 1/15/16.
//  Copyright © 2016 Gabriel Benbow. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
	private var _name: String!
	private var _pokedexID: Int!
	private var _description: String!
	private var _type: String!
	private var _defense: String!
	private var _height: String!
	private var _weight: String!
	private var _attack: String!
	private var _nextEvolution: String!
	private var _pokemonURL: String!
	private var _nextEvolutionID: String!
	private var _nextEvolutionLvl: String!
	
	
	
	
	var name: String {
		
		
		return _name
		
	}
	
	var pokedexID: Int {
		
		return _pokedexID
	}
	var height: String {
		if _height == nil {
			_height = ""
		}
		return _height
	}
	
	var weight: String {
		if _weight == nil {
			_height = ""
		}
		return _weight
	}
	
	var attack: String {
		if _attack == nil {
			_attack = ""
		}
		return _attack
	}
	
	var nextEvolution: String {
		if _nextEvolution == nil {
			_nextEvolution = ""
		}
		return _nextEvolution
	}
	
	var description: String {
		if _description == nil {
			_description = ""
		}
		return _description
	}
	
	var type: String {
		if _type == nil {
			_type = ""
		}
		return _type
	}
	
	var defense: String {
		if _defense == nil {
			_defense = ""
		}
		return _defense
	}
	
	var nextEvolutionID: String {
		if _nextEvolutionID == nil {
			_nextEvolutionID = ""
		}
		
		return _nextEvolutionID
	}
	
	var nextEvolutionLvl: String {
		get {
			if _nextEvolutionLvl == nil {
				_nextEvolutionLvl = ""
			}
		
		return _nextEvolutionLvl
		}
	}
	
	
	
	init(name: String, pokedexID: Int) {
		_name = name
		_pokedexID = pokedexID
		_pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexID)/"
	}
	
	func downloadPokemonDetails(completed: DownloadComplete) {
		let url = NSURL(string: _pokemonURL)!
		Alamofire.request(.GET, url).responseJSON { response in let result = response.result
			
			if let dict = result.value as? Dictionary<String, AnyObject> {
				
				if let weight = dict["weight"] as? String {
					self._weight = weight
				}
				
				if let height = dict["height"] as? String {
					self._height = height
				}
				
				if let attack = dict["attack"] as? Int {
					self._attack = "\(attack)"
				}
				
				if let defense = dict["defense"] as? Int {
					self._defense = "\(defense)"
				}
				
				if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0 {
					
					if let name = types[0]["name"] {
						self._type = name
					}
					
					if types.count > 1 {
						for var x = 1; x < types.count; x++ {
							if let name = types[x]["name"] {
								self._type! += "/\(name.capitalizedString)"
								completed()
							}
						}
						
					} else {
						self._type = ""
					}
					
					if let descArray = dict["descriptions"] as? [Dictionary<String,String>] where descArray.count > 0 {
						
						if let url = descArray[0]["resource_uri"] {
							let nsurl = NSURL(string: "\(URL_BASE)\(url)")!
							
							Alamofire.request(.GET, nsurl).responseJSON { response in
								let descResult = response.result
								if let descDict = descResult.value as? Dictionary<String, AnyObject> {
									if let description = descDict["description"] as? String {
										self._description = description
										print(self._description)
									}
								}
								completed()
							}
						} else {
							self._description = ""
						}
					}
					
					if let evoArray = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evoArray.count > 0 {
						
						if let to = evoArray[0]["to"] as? String {
							// Parses out Mega Evolution Pokemon, Don't have assets for Megas
							if  to.rangeOfString("mega") == nil {
								if let uri = evoArray[0]["resource_uri"] {
									let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
									
									let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
										self._nextEvolutionID = num
										self._nextEvolution = to
										
										if let lvl = evoArray[0]["level"] as? Int {
											self._nextEvolutionLvl = "\(lvl)"
										}
									print(self._nextEvolution)
									print(self._nextEvolutionID)
									
									
									
								}
							}
						}
						
					}
					
				}
				//print(self._weight)
				//print(self._height)
				//print(self._attack)
				//print(self._defense)
				print(self._type)
			}
		}
	}
	
	
}