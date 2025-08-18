//
//  SearchState.swift
//  BestRecipes
//
//  Created by Николай Игнатов on 18.08.2025.
//

enum SearchViewState {
    case initial
    case loading
    case loaded([Recipe])
    case error(String)
}
