//
//  store.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 17/02/25.
//
import ComposableArchitecture


//It is the object that can process actions in order to update state, and it can execute effects and feed data from those effects back into the system
let Sstore : StoreOf<AppFeature> = Store(initialState: AppFeature.State()) {
    AppFeature()
        ._printChanges()
}
