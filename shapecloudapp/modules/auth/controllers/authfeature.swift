//
//  auth_feature.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 5/03/25.
//
import ComposableArchitecture

@Reducer
struct AuthFeature{
    
    @ObservableState
    struct State: Equatable {
        var user: User?
        var token : String?
    }
    enum Action{
        case setUser(User)
        case setToken(String)
    }
    var body: some ReducerOf<Self>{
        Reduce { state, action in
            switch action {
                case .setUser(let user):
                state.user = user
                return .none
            case .setToken(let token):
                state.token = token
                return .none
            }
        }
    }
}
