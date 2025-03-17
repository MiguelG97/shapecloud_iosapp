//
//  SProjectsScreen.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 14/02/25.
//

import SwiftUI
import ComposableArchitecture
import SwiftUIIntrospect

struct SProjectsScreen: View {
    @Bindable var store: StoreOf<ProjectsFeature>
    
    @State private var searchText: String = ""
    @State private var lastScrollOffset: CGFloat = 0
    @Binding var isBotTabBarHidden: Bool
//    @State private var contentHeight: CGFloat = 0
    private var contentHeight: Double {
        Double(store.projects.count) * 147.0 + Double(min(store.projects.count - 1, 0))*16.0
    }
    @Environment(\.safeArea) private var safeArea: EdgeInsets
    @Environment(\.screenSize) private var screenSize: CGSize
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack(path:$store.navigationPath.sending(\.setNavigationPath)) {
            ScrollView(.vertical){
                GeometryReader { geo->Color in
                    DispatchQueue.main.async {
                        //1) Top area
                        //The ++ the value, the higher the scrollbar
                        //the -- the value, the lower the scrollbar
                        let topLeftOffset = geo.frame(in: .global).minY
//                        let topOffsetRangeArea = safeArea.top + 100
//                        let isAroundTheTop = topLeftOffset>topOffsetRangeArea
//                        
//                        //2) Bottom area
//                        let fullScreensize = safeArea.top + safeArea.bottom + screenSize.height
//                        let bottomOffsetRangeArea = fullScreensize - contentHeight - safeArea.top
//                        let isAtBottom = topLeftOffset <= bottomOffsetRangeArea
//                        
//                        print("Greater: ",topLeftOffset,topOffsetRangeArea)
//                        print("Lower than: ",topLeftOffset,bottomOffsetRangeArea)
//                        
//                        if isAroundTheTop || isAtBottom || contentHeight < screenSize.height - 100 {
//                            return
//                        }
                        
                        if topLeftOffset < lastScrollOffset && abs(topLeftOffset - lastScrollOffset)>1 {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                    isBotTabBarHidden = true
                                }
                        }
                        else if topLeftOffset > lastScrollOffset && abs(topLeftOffset - lastScrollOffset)>1 {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                isBotTabBarHidden = false
                            }
                        }
                        lastScrollOffset = topLeftOffset
                    }
                    return Color.clear
                }.frame(height: 0)
                
                VStack(spacing:16) {
                    ForEach(store.projects,id:\._id) { projectItem in
                        NavigationLink(value: projectItem) {
                            SProjectItem(project: projectItem)
                                .foregroundStyle(Color.theme.foreground)
                        }
                    }
                }
            }
            .navigationDestination(for: Project.self) { project in
                SFoldersScreen(project:project,isBotTabBarHidden: $isBotTabBarHidden)
                    .toolbar(.hidden)
            }
            .padding(.top,isBotTabBarHidden ? 0 : 130)
            .overlay(alignment: .top) {
                VStack(spacing:16) {
                    HStack {
                        Text("Your")
                        Text("Projects")
                            .fontWeight(.bold)
                        Text("Are Here!")
                            
                    }
                    .font(.title)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.horizontal,12)
                    .padding(.vertical,0)
                    
                    HStack {
                        SSearchField(searchValue: $searchText)

                        Button {
                            
                        } label: {
                            Image(systemName: "slider.horizontal.3")
                                .foregroundStyle(.white)
                                .fontWeight(.medium)
                                .font(.system(size: 24))
                                .frame(width:50.66,height: 50.66)
                                .background {
                                    Circle().fill(Color.theme.primary)
                                }
                        }
                    }
                }
                .offset(y: isBotTabBarHidden ? -130 : 0)
                .padding(.top,8)
            }
            .padding(.horizontal,SScreenSize.hPadding)
            .introspect(.scrollView, on: .iOS(.v14,.v15,.v16,.v17,.v18)) { scrollview in
                scrollview.bounces = true
            }
            .onAppear {
                //not on appear but do it only once or on pull to refresh!
                Task {
                    do {
                        //skeletons!!
                        let projectsData = try await ProjectService.Shared.getProjects()
                        store.send(.setProjects(projectsData))
                    }
                    catch{
                        print("error found: ",error.localizedDescription)
                    }
                }
            }
        }
    }
}

#Preview {
    SProjectsScreen(store:Store(initialState: ProjectsFeature.State(), reducer: {
        ProjectsFeature()
    }),isBotTabBarHidden: .constant(false))
        .environment(\.font, .custom(ThemeFonts.shared.geistRegular, size: 16))
        .environment(\.screenSize, CGSize(width: 402, height: 874))
        .environment(\.safeArea, EdgeInsets(top: 62, leading: 0, bottom: 34, trailing: 0))
}
