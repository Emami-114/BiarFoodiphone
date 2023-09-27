import SwiftUI
struct SiderbarIpadView: View {
    @EnvironmentObject var viewModel : SiderbarIpadViewModel
    @State var currenItem : EnumSidbarMenuIpad = .home
    @Namespace var nameSpace
    @Binding var showingKontoSidbar: Bool
    var body: some View{
        VStack(alignment: .leading,spacing: 10){
//            Profile
            if showingKontoSidbar{
                SidbarKonto
                    .transition(.slide)
            }else{
                SiderbarIpad
                    .transition(.slide)

            }
                        Spacer()

        }.navigationBarBackButtonHidden(true)
            .padding(.top,30)
        .padding(.vertical,30)
        .background(Color.theme.backgroundColor)
        .animation(.easeInOut(duration: 0.3),value: self.showingKontoSidbar)
    }
    
    private var SidbarKonto: some View{
        LazyVStack(alignment: .leading){
            ForEach(EnumSidbarMenu.allCases,id: \.self) { tab in
                SiderbarItemForIpad(currentItem: $viewModel.currentItemKonto, title: viewModel.switchItemTitle(item: tab),icon: viewModel.switchItemIcon(item: tab), showSidbar: $showingKontoSidbar, nameSpace: nameSpace)
              
                
            }
            Button{
                showingKontoSidbar.toggle()
            }label: {
                Image(systemName: "rectangle.grid.2x2")
                Text("Menu")
            }.buttonStyle(.plain)
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.horizontal,35)
                .padding()
        }
    }
    
    private var SiderbarIpad: some View{
        LazyVStack(alignment: .leading){
            ForEach(EnumSidbarMenuIpad.allCases,id: \.self) { tab in
                SiderbarItemForIpad(currentItem: $viewModel.currentItem, title: tab.title,icon: tab.icon, showSidbar: $showingKontoSidbar, nameSpace: nameSpace)
              
                
            }
            Button{
                showingKontoSidbar.toggle()
            }label: {
                Image(systemName: "person")
                Text("Konto")
            }.buttonStyle(.plain)
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.horizontal,35)
                .padding()
        }
    }
    
    private var Profile: some View {
                    HStack{
                        Image(.iconimage)
                            .resizable()
                            .clipShape(Circle())
                            .padding(5)
                            .overlay(content: {
                                Circle()
                                    .stroke(lineWidth: 8).fill(Color.theme.white)
                                    .clipShape(Circle()).shadow(radius: 4)
                            })
                            .frame(width: 80,height: 80)
                            .clipShape(Circle())

                        Spacer()
                        Button{
                            withAnimation(.spring()){
//                                isShowing = false
                            }
                        }label: {
                            Image(systemName: "xmark")
                                .font(.title.bold())
                                .foregroundColor(Color.theme.white)
                                .frame(width: 32,height: 32)
                                .padding()
                        }.offset(y: -60)
                    }.padding(.horizontal,20)
                        .padding(.trailing,5)
                        .padding(.bottom)
        
    }
}

#Preview {
    SiderbarIpadView(showingKontoSidbar: .constant(false))
        .environmentObject(SiderbarIpadViewModel())
}
