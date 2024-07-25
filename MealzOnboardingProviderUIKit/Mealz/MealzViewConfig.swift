//
//  MealzViewConfig.swift
//  MealzOnboardingProviderUIKit
//
//  Created by Diarmuid McGonagle on 25/07/2024.
//

import MarmitonUIMealzIOS
import MealzUIiOSSDK
import MealziOSSDK
import MealzNaviOSSDK

// TODO: 10. Change Colors, icons, and Localization
// TODO 10a. Add Mealz Primary Color
// TODO 10b. Add Mealz Icon
// TODO 10c. Create Localization File and add text
// TODO 10d: Register App Bundle

// 9a. Create Mealz Config File & Struct
struct MealzViewConfig {
    // 9b. Copy & paste boilerplate for View Options
    // ----------------------------- RECIPE DETAILS ------------------------------
    
    static let recipeDetailsBaseViews = BasePageViewParameters(
        //        loading: TypeSafeLoading(MarmitonLoadingView())
    )
    static let recipeDetailsViews = { (openMyBasket: @escaping () -> Void) -> RecipeDetailsViewOptions in
        return RecipeDetailsViewOptions(
            header: TypeSafeRecipeDetailsHeader(MarmitonRecipeDetailsHeaderView(changeStore: changeStore)),
            selectedControl: TypeSafeRecipeDetailsSelectedControl(MarmitonRecipeDetailsSelectedControlView()),
            //        numberOfIngredientsTitle: TypeSafeBaseTitle(EmptyTitleView())
            //        steps: TypeSafeRecipeDetailsSteps(MarmitonRecipeDetailsStepsView()),
            footer: TypeSafeRecipeDetailsFooter(MarmitonRecipeDetailsFooterView(openMyBasket: openMyBasket)),
            ingredientsAtHome: TypeSafeNotInBasketProduct(MarmitonNotInBasketProductView()),
            unavailableIngredients: TypeSafeNotInBasketProduct(MarmitonNotInBasketProductView())
        )
    }
    static let recipeDetailsProductsViews = RecipeDetailsProductViewOptions(
        ignoredProduct: TypeSafeRecipeDetailsIgnoredProduct(MarmitonRecipeDetailsIgnoredProductView()),
        addedProduct: TypeSafeRecipeDetailsAddedProduct(MarmitonRecipeDetailsAddedProductView())
    )
    
    static let itemSelectorView = ItemSelectorViewOptions(
        searchBar: TypeSafeSearch(MarmitonGeneralSearch()),
        noResults: TypeSafeItemSelectorNoResults(MarmitonItemSelectorNoResultsView())
    )
    
    static let recipeDetailsConfig = { (openMyBasket: @escaping () -> Void) -> RecipeDetailsFeatureConstructor in
        return RecipeDetailsFeatureConstructor(
            baseViews: recipeDetailsBaseViews,
            recipeDetailsViewOptions: recipeDetailsViews(openMyBasket),
            recipeDetailsProductViewOptions: recipeDetailsProductsViews,
            itemSelectorViewOptions: itemSelectorView
        )
    }
    
    // ---------------------------------- MY MEALS ----------------------------------
    
    static let myMealsView = NestedMyMealsViewOptions(
        title: TypeSafeBaseTitle(EmptyTitleView())
        //        recipeCard: TypeSafeMyMealRecipeCard(MarmitonMyMealRecipeCard())
    )
    
    static let myMealsBaseView = BasePageViewParameters(
        empty: TypeSafeEmpty(MarmitonMyMealsEmpty())
    )
    
    // -------------------------------- MY PRODUCTS ----------------------------------
    
    static let myProductsBaseView = BasePageViewParameters(
        empty: TypeSafeEmpty(MarmitonMyMealsEmpty())
    )
    
    static let myProductsView = MyProductsViewOptions(
        productCard: TypeSafeMyProductsProductCard(MarmitonMyProductsProductCard())
    )
    
    // ---------------------------------- MY BASKET ----------------------------------
    
    static let myBasketView = MyBasketViewOptions(
        title: TypeSafeBaseTitle(MarmitonMyBasketTitle(changeStore: changeStore)),
        swapper: TypeSafeMyBasketSwapper(MarmitonMyBasketSwapper(onAddAnotherProduct: {}))
    )
    
    static let myBasketConfig = MyBasketFeatureConstructor(
        myBasketViewOptions: myBasketView,
        myMealsViewOptions: MyMealsViewOptions(nestedOptions: myMealsView),
        myMealsBaseViews: myMealsBaseView,
        myProductsViewOptions: myProductsView,
        myProductsBaseViews: myProductsBaseView,
//        catalogRecipesListGridConfig: myMealsGridConfig,
        navigateToCatalog: {},
        navigateToCheckout: showCheckout
    )
}
