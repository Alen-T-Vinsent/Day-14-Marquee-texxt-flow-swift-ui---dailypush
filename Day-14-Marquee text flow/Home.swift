//
//  Home.swift
//  Day-14-Marquee text flow
//
//  Created by Apple  on 29/12/22.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading,spacing: 22) {
                GeometryReader{proxy in
                    let size = proxy.size
                    //MARK: sample image
                    Image("postMarquee")
                        .resizable()
                        .aspectRatio(contentMode:.fill)
                        .frame(width: size.width,height: size.height)
                        .cornerRadius(15)
                }
                .frame(height: 220)
                Marquee(text:"Hello i am Alen T Vinsent , i am trying to learn more in swift ui , can you help me out",font:.systemFont(ofSize: 16, weight: <#T##UIFont.Weight#>, width: <#T##UIFont.Width#>))
            }
            .padding()
            .navigationTitle("Marquee Text")
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


//MARK: Marquee text view
struct Marquee:View{
    var text:String
    //customization options
    var font:UIFont
    
    var body: some View{
        //since it scrolls horizontal using scroll view
        ScrollView(.horizontal,showsIndicators: false){
            Text(text)
                .font(UIFont(font))
        }
        //disabling scrolling mannually
        .disabled(true)
    }
    //MARK: Fetching font size for offset Animation
    func textSize()->CGFloat{
        
    }
}
