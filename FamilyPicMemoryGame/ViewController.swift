//
//  ViewController.swift
//  FamilyPicMemoryGame
//
//  Created by Nimrod Gruber on 12/09/2024.
//

import Cocoa
import UniformTypeIdentifiers // Import this to handle allowedContentTypes

class ViewController: NSViewController {
    
    // Variables to receive data from the pre-screen
    var selectedPlayers: String = "1 Player"
    var selectedDifficulty: String = "Easy"
    var uploadImages: Bool = false
    
    // Array to store the images for each card
    var cardImages: [NSImage] = []
    
    // Variables to track the first and second cards clicked
    var firstCard: NSButton?
    var secondCard: NSButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Print received values for debugging
        print("Players: \(selectedPlayers), Difficulty: \(selectedDifficulty), Upload Images: \(uploadImages)")
        
        // Load the card images when the view loads
        if uploadImages {
            selectCustomImages()
        } else {
            loadCardImages()
        }
    }
    
    // Function to load placeholder images for the cards (you can update this later to use real images)
    func loadCardImages() {
        // For now, we’ll use the same placeholder image for all cards
        if let placeholderImage = NSImage(systemSymbolName: "folder", accessibilityDescription: nil) {
            cardImages = Array(repeating: placeholderImage, count: 16)
        }
    }
    
    // Function to open a file picker and allow the user to select images
    func selectCustomImages() {
        let openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = true
        openPanel.canChooseFiles = true
        openPanel.canChooseDirectories = false
        openPanel.allowedContentTypes = [
            UTType.png,
            UTType.jpeg,
            UTType.image // Allows various image types
        ]
        openPanel.prompt = "Choose Images"
        
        // Present the panel as a modal window on the main thread
        DispatchQueue.main.async {
            openPanel.begin { response in
                if response == .OK {
                    // Load the selected images
                    self.cardImages = openPanel.urls.compactMap { url in
                        return NSImage(contentsOf: url)
                    }

                    // Ensure we have enough images for the game (e.g., 16 images)
                    while self.cardImages.count < 16 {
                        self.cardImages.append(contentsOf: self.cardImages)
                    }

                    // Limit to the number of cards required
                    self.cardImages = Array(self.cardImages.prefix(16))
                }
                // If no images were selected or not enough were selected, fall back to default images
                if self.cardImages.isEmpty {
                    self.loadCardImages()
                }
            }
        }
    }

    
    // Action function that gets triggered when any card (button) is tapped
    @IBAction func cardTapped(_ sender: NSButton) {
        // If two cards are already selected, ignore further clicks
        if firstCard != nil && secondCard != nil {
            return
        }
        
        // Get the index of the button tapped based on its tag
        let cardIndex = sender.tag
        
        // Check if we have a valid card image for the button
        if cardIndex < cardImages.count {
            // Set the button's image to the corresponding card image
            sender.image = cardImages[cardIndex]
        }
        
        // Check if this is the first or second card clicked
        if firstCard == nil {
            firstCard = sender
        } else if secondCard == nil {
            secondCard = sender
            
            // Check if the two cards match after a short delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.checkForMatch()
            }
        }
    }
    
    // Function to check if two cards match
    func checkForMatch() {
        // Check if the first and second cards match by comparing their tags
        if let firstCard = firstCard, let secondCard = secondCard {
            if firstCard.tag == secondCard.tag {
                // Cards match, do nothing
            } else {
                // Cards don't match, flip them back over (remove the images)
                firstCard.image = nil
                secondCard.image = nil
            }
        }
        
        // Reset the first and second card variables
        firstCard = nil
        secondCard = nil
    }
}
