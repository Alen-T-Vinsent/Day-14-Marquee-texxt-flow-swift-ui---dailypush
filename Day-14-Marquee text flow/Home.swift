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
                .padding(.horizontal)
                
                Marquee(text:"Hello i am Alen T Vinsent , i am trying to learn more in swift ui , can you help me out",font:.systemFont(ofSize: 16, weight: .regular))
            }
            .padding(.vertical)
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
    @State var text:String
    //customization options
    var font:UIFont
    
    //storing text size
    @State var storedSize:CGSize = .zero
    //MARK: Animation offset
    @State var offset:CGFloat = 0
    //MARK: Animation speed
    var animationSpeed:Double = 0.02
    //MARK: delay time
    var delayTime:Double = 0.5
    @Environment(\.colorScheme) var scheme
    
    
    var body: some View{
        //since it scrolls horizontal using scroll view
        ScrollView(.horizontal,showsIndicators: false){
            Text(text)
                .font(Font(font))
                .offset(x:offset)
                .padding(.horizontal,15)
            
            
        }
        //MARK: opacity effect
        .overlay{
            HStack{
                let color:Color = scheme == .dark ? .black : .white
                LinearGradient(colors: [color,color.opacity(0.7),color.opacity(0.5),color.opacity(0.3)], startPoint: .leading, endPoint: .trailing)
                    .frame(width: 20)
                
                Spacer()
                
                LinearGradient(colors: [color,color.opacity(0.7),color.opacity(0.5),color.opacity(0.3)].reversed(), startPoint: .leading, endPoint: .trailing)
                    .frame(width: 20)
                
            }
        }
        //disabling scrolling mannually
        .disabled(true)
        .onAppear {
            //base text
            let baseText = text
            
            //MARK: Continuous text animation
            //add spacing for continuous text
            (1...15).forEach { _ in
                text.append(" ")
            }
            
            //stopping animation exactly before next text
            storedSize = textSize()
            text.append(baseText)
            
            
            storedSize = textSize()
            //calculating total specs based on Text width
            //our animation speed for Each character will be 0.02 secs
            let timing:Double = (animationSpeed * storedSize.width)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05){
                withAnimation(.linear(duration: timing)){
                    offset -= storedSize.width
                }
            }
        }
        //MARK: Repeating marquee effect with help of timer
        //optional: if you want some delay for next animation
        .onReceive(Timer.publish(every: ((animationSpeed * storedSize.width)+delayTime),on: .main,in:.default).autoconnect()){_ in
            //resetting offset to zero
            //thus its looks like its loopeing
            offset = 0
            
            withAnimation(.linear(duration: ((animationSpeed * storedSize.width)))){
                offset -= storedSize.width
            }
            
        }
    }
    //MARK: Fetching font size for offset Animation
    func textSize()->CGSize{
        let attributes = [NSAttributedString.Key.font:font]
        let size = (text as NSString).size(withAttributes: attributes)
        return size
    }
}
