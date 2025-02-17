//
//  SProjectsScreen.swift
//  shapecloudapp
//
//  Created by Miguel Gutiérrez on 14/02/25.
//

import SwiftUI

struct SProjectsScreen: View {
    
    @State private var searchText: String = ""
    @State private var lastScrollOffset: CGFloat = 0
    @Binding var areBarsHidden: Bool
    @State private var contentHeight: CGFloat = 0
    @Environment(\.safeArea) private var safeArea: EdgeInsets
    @Environment(\.screenSize) private var screenSize: CGSize
    @State private var projectItems: [Project] = [
        Project(name: "Project 1", location: "Description 1",companyId: "1"),
           Project(name: "Project 2", location: "Description 2",companyId: "2"),
           Project(name: "Project 3", location: "Description 3",companyId: "3"),
           Project(name: "Project 4", location: "Description 4",companyId: "4"),
           Project(name: "Project 5", location: "Description 5",companyId: "5"),
        Project(name: "Project 6", location: "Description 6",companyId: "6"),
    ]
    
    @State private var projectPath : [Project] = []
    
    var body: some View {
        
        NavigationStack(path:$projectPath) {
            VStack{
                ScrollView(.vertical){
                    GeometryReader { geo->Color in
                        DispatchQueue.main.async {
                            
                            //top left corner of scroll view offset with respect to top left screen corner
                            let offset = geo.frame(in: .global).minY
                            
                            let topOffsetLimit = safeArea.top + 100
                            let isAtTop = offset>topOffsetLimit
                            
                            let bottomOffsetLimit = safeArea.top + safeArea.bottom + screenSize.height - contentHeight
                            let isAtBottom = offset <= bottomOffsetLimit
                            
                            if isAtTop || isAtBottom {
                                return
                            }
                            print(offset,safeArea.top +
                                  safeArea.bottom + screenSize.height - contentHeight)
                            
                            if offset < lastScrollOffset && abs(offset - lastScrollOffset)>1 {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                        areBarsHidden = true
                                    }
                            }
                            else if offset > lastScrollOffset && abs(offset - lastScrollOffset)>1 {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    areBarsHidden = false
                                }
                            }
                            lastScrollOffset = offset
                        }
                        
                        return Color.clear
                    }.frame(height: 0)
                    
                    VStack(spacing:16) {
                        ForEach(projectItems,id:\.companyId) { projectItem in
                            NavigationLink(value: projectItem) {
                                SProjectItem()
                                    .foregroundStyle(Color.theme.foreground)
                            }
                            
                        }
                    }
                    .background {
                        GeometryReader { geo in
                            Color.clear.onAppear {
    //                            print("contentHeight",geo.size.height)
    //                            print("viewHeight",screenSize.height)
                                contentHeight = geo.size.height
                            }
                        }
                    }
                }
                .padding(.top,areBarsHidden ? 0 : 130)
                .overlay(alignment: .top) {
                    VStack(spacing:24) {
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
                    .offset(y: areBarsHidden ? -130 : 0)
                }
                
            }
            .padding(.vertical,12)
            .padding(.horizontal, 20)
            .navigationDestination(for: Project.self) { project in
                SFoldersScreen()
                    .toolbar(.hidden)
            }
        }
    }
}

#Preview {
    SProjectsScreen(areBarsHidden: .constant(false))
        .environment(\.font, .custom(ThemeFonts.shared.geistRegular, size: 16))
        .environment(\.screenSize, CGSize(width: 402, height: 874))
        .environment(\.safeArea, EdgeInsets(top: 62, leading: 0, bottom: 34, trailing: 0))
}
