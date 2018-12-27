

import Foundation
import UIKit

enum ProfileViewModelItemType {
    case nameAndPicture
    case about
    case ingredient
    case step
}

protocol ProfileViewModelItem {
    var type: ProfileViewModelItemType { get }
    var sectionTitle: String { get }
    var rowCount: Int { get }
}

class ProfileViewModel: NSObject {
    var items = [ProfileViewModelItem]()
    
    override init() {
        super.init()
    }
    init(recipeProfile: RecipeProfile) {
        super.init()
        //        guard let data = dataFromFile("RecipeData"),
        guard let profile = Profile(recipeProfile: recipeProfile) else {
            return
        }
        print("=============")
        print(profile.recipeName ?? "No Name")
        print(profile.about ?? "No About")
        
        if let name = profile.recipeName, let pictureUrl = profile.imageURL {
            print(name)
            print(pictureUrl)
            let nameAndPictureItem = ProfileViewModelNamePictureItem(name: name, pictureUrl: pictureUrl)
            items.append(nameAndPictureItem)
        }
        
        if let about = profile.about {
            let aboutItem = ProfileViewModelAboutItem(about: about)
            items.append(aboutItem)
        }
        
        let ingredients = profile.ingredients
        if !profile.ingredients.isEmpty {
            let ingredientsItem = ProfileViewModeingredientsItem(ingredients: ingredients)
            items.append(ingredientsItem)
        }
        
        let steps = profile.steps
        if !steps.isEmpty {
            let stepsItem = ProfileViewModeStepItem(steps: steps)
            items.append(stepsItem)
        }
    }
}

extension ProfileViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        switch item.type {
        case .nameAndPicture:
            if let cell = tableView.dequeueReusableCell(withIdentifier: NamePictureCell.identifier, for: indexPath) as? NamePictureCell {
                cell.item = item
                return cell
            }
        case .about:
            if let cell = tableView.dequeueReusableCell(withIdentifier: AboutCell.identifier, for: indexPath) as? AboutCell {
                cell.item = item
                return cell
            }
        case .ingredient:
            if let item = item as? ProfileViewModeingredientsItem, let cell = tableView.dequeueReusableCell(withIdentifier: IngredientCell.identifier, for: indexPath) as? IngredientCell {
                let ingredient  = item.ingredients[indexPath.row]
                cell.item = ingredient
                return cell
            }
        case .step:
            if let item = item as? ProfileViewModeStepItem, let cell = tableView.dequeueReusableCell(withIdentifier: StepCell.identifier, for: indexPath) as? StepCell {
                cell.item = item.steps[indexPath.row]
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].sectionTitle
    }
}


class ProfileViewModelNamePictureItem: ProfileViewModelItem {
    var type: ProfileViewModelItemType {
        return .nameAndPicture
    }
    
    var sectionTitle: String {
        return "Main Info"
    }
    
    var rowCount: Int {
        return 1
    }
    
    var name: String
    var pictureUrl: String
    
    init(name: String, pictureUrl: String) {
        self.name = name
        self.pictureUrl = pictureUrl
    }
}

class ProfileViewModelAboutItem: ProfileViewModelItem {
    var type: ProfileViewModelItemType {
        return .about
    }
    
    var sectionTitle: String {
        return "About"
    }
    
    var rowCount: Int {
        return 1
    }
    
    var about: String
    
    init(about: String) {
        self.about = about
    }
}

class ProfileViewModeStepItem: ProfileViewModelItem {
    var type: ProfileViewModelItemType {
        return .step
    }
    
    var sectionTitle: String {
        return "Steps"
    }
    
    var rowCount: Int {
        return steps.count
    }
    
    var steps: [Step]
    
    init(steps: [Step]) {
        self.steps = steps
    }
}

class ProfileViewModeingredientsItem: ProfileViewModelItem {
    var type: ProfileViewModelItemType {
        return .ingredient
    }
    
    var sectionTitle: String {
        return "Ingredients"
    }
    
    var rowCount: Int {
        return ingredients.count
    }
    
    var ingredients: [Ingredient]
    
    init(ingredients: [Ingredient]) {
        self.ingredients = ingredients
    }
}


