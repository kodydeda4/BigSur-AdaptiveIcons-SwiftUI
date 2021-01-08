//
//  ThemeDetailView.swift
//  AdaptiveIcons
//
//  Created by Kody Deda on 12/24/20.
//

import SwiftUI
import ComposableArchitecture
import Grid
import Combine

struct ThemeDetailView: View {
    let store: Store<SelectedIconState, SelectedIconAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack(alignment: .center) {
                if viewStore.icons.isEmpty {
                    Text("No Selection")
                        .font(.title)
                        .foregroundColor(Color(NSColor.placeholderTextColor))
                } else {
                    IconDetailView(
                        store: store,
                        iconFrameWidth: 100,
                        iconFrameHeight: 100,
                        iconImage: viewStore.iconDetailViewImage,
                        iconText: viewStore.iconDetailViewText)
                    Divider()
                    VStack {
                        HStack {
                            ForEach(IconShape.allCases, id: \.self) { iconShape in
                                IconShapeButton(
                                    store: store,
                                    iconShape: iconShape,
                                    action: { viewStore.send(.setSelectedIconShape(iconShape)) })
                            }
                        }
                        
                        Divider()
                        HStack {
                            ForEach(viewStore.iconBackgroundColors, id: \.self) { color in
                                RoundButton(
                                    store: store,
                                    color: color,
                                    action: { viewStore.send(.setSelectedBackgroundColor(color)) }
                                )
                            }
                        }
                        Divider()
                        VStack(alignment: .leading) {
                            Toggle(isOn: viewStore.binding(
                                    get: \.iconShadow,
                                    send: SelectedIconAction.toggleIconShadow)) {
                                Text("Icon Shadow")
                            }
                            Toggle(isOn: viewStore.binding(
                                    get: \.shapeShadow,
                                    send: SelectedIconAction.toggleShapeShadow)) {
                                Text("Background Shadow")
                            }
                        }
                        Spacer()
//                        HStack {
//                            Button("Reset", action: { viewStore.send(.removeChanges) })
//                                .buttonStyle(RoundedRectangleButtonStyle())
//                            
//                            Button("Apply Changes", action: { viewStore.send(.applyChanges) })
//                                .buttonStyle(RoundedRectangleButtonStyle())
//                        }
                    }
                    Spacer()
                    Divider()
                    Text("Selected Icons:")
                    List(viewStore.icons) { icon in
                        Text(icon.name)
                    }
                }
            }
            .padding()
        }
    }
}





struct ThemeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeDetailView(store: SelectedIconState.defaultStore)
    }
}
