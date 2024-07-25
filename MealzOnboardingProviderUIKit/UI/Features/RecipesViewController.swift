//
//  RecipesViewController.swift
//  MealzOnboardingProviderUIKit
//
//  Created by Diarmuid McGonagle on 25/07/2024.
//

import UIKit
// 4a. import Nav
import MealzNaviOSSDK

// TODO 4. Add Mealz Recipe Details

class RecipesViewController: UIViewController, RecipeCardViewDelegate {
    
    let scrollView = UIScrollView()
    let firstRecipe = RecipeCardView(frame: .zero)
    let secondRecipe = RecipeCardView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
        setupFirstRecipeView()
        setupSecondRecipeView()
    }

    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupFirstRecipeView() {
        scrollView.addSubview(firstRecipe)
        firstRecipe.delegate = self
        firstRecipe.configure(with: PretendRecipe(externalId: "22509", title: "Chicken Parm", imageUrl: "https://hips.hearstapps.com/hmg-prod/images/delish-202102-airfryerchickenparm-184-ls-1612561654.jpg?crop=1xw:0.84375xh;center,top&resize=1200:*"))
        firstRecipe.translatesAutoresizingMaskIntoConstraints = false
        firstRecipe.contentMode = .scaleAspectFill
        firstRecipe.clipsToBounds = true
        firstRecipe.isUserInteractionEnabled = true
        
        let imageHeight: CGFloat = 150
        NSLayoutConstraint.activate([
            firstRecipe.topAnchor.constraint(equalTo: scrollView.topAnchor), // top of the scrollView
            firstRecipe.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0), // leading of the scrollView
            firstRecipe.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0), // trailing of the scrollView
            firstRecipe.heightAnchor.constraint(equalToConstant: imageHeight), // fixed height for the imageView
            firstRecipe.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    func setupSecondRecipeView() {
        scrollView.addSubview(secondRecipe)
        secondRecipe.delegate = self
        secondRecipe.configure(with: PretendRecipe(externalId: "14472", title: "Croque Monsieur", imageUrl: "https://assets.afcdn.com/recipe/20170112/28965_w1024h768c1cx1500cy1000.webp"))
        secondRecipe.translatesAutoresizingMaskIntoConstraints = false
        secondRecipe.contentMode = .scaleAspectFill
        secondRecipe.clipsToBounds = true
        secondRecipe.isUserInteractionEnabled = true
        
        let imageHeight: CGFloat = 150
        NSLayoutConstraint.activate([
            secondRecipe.topAnchor.constraint(equalTo: firstRecipe.bottomAnchor, constant: 10), // top of the scrollView
            secondRecipe.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0), // leading of the scrollView
            secondRecipe.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0), // trailing of the scrollView
            secondRecipe.heightAnchor.constraint(equalToConstant: imageHeight), // fixed height for the imageView
            secondRecipe.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    func didTapSeeDetailsButton(recipeId: String) {
        // 4b. Add Recipe Details in 2nd page
        let newVC = MealzRecipeDetailsFeatureUIKit(
            recipeId: recipeId,
            recipeDetailsConstructor: MealzViewConfig.recipeDetailsConfig({
                self.tabBarController?.selectedIndex = 1
            })
        )
        present(newVC, animated: true, completion: nil)
    }
}
