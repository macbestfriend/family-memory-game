//
//  PreScreenViewController.swift
//  FamilyPicMemoryGame
//
//  Created by Nimrod Gruber on 14/09/2024.
//

import Cocoa

class PreScreenViewController: NSViewController {
    
    @IBOutlet weak var playerSelectionPopup: NSPopUpButton!
    @IBOutlet weak var difficultyPopup: NSPopUpButton!
    @IBOutlet weak var uploadImagesCheckbox: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initial setup, if needed
    }

    @IBAction func startGameClicked(_ sender: NSButton) {
        // Trigger the segue to the game screen
        performSegue(withIdentifier: "startGameSegue", sender: self)
    }

    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier == "startGameSegue" {
            if let gameViewController = segue.destinationController as? ViewController {
                // Passing selected options to the game screen
                let selectedPlayers = playerSelectionPopup.titleOfSelectedItem ?? "1 Player"
                let selectedDifficulty = difficultyPopup.titleOfSelectedItem ?? "Easy"
                let uploadImages = (uploadImagesCheckbox.state == .on)

                gameViewController.selectedPlayers = selectedPlayers
                gameViewController.selectedDifficulty = selectedDifficulty
                gameViewController.uploadImages = uploadImages
            }
        }
    }
}
