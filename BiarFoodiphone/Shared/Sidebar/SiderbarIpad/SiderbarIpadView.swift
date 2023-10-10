import SwiftUI
struct SiderbarIpadView: View {
    @EnvironmentObject var viewModel : SiderbarIpadViewModel
    @State var currenItem : EnumSidbarMenuIpad = .home
    @Namespace var nameSpace
    @Binding var showingKontoSidbar: Bool
    @State private var siderbarOpen = false
    var body: some View{
        VStack(alignment: .leading,spacing: 10){
            CustomNavBarView(showBackButton: false, title: "",trillingButtonAction: {}, backButtonAction: {})
            HStack{
                Spacer()
                Button{
                    withAnimation(.easeInOut(duration: 0.4)){
                        siderbarOpen.toggle()
                    }
                }label: {
                    Image(systemName: siderbarOpen ? "chevron.backward.2" : "chevron.forward.2")
                        .foregroundColor(Color.theme.iconColor)
                        .font(.title3.bold())
                }
            }.padding()
//            Profile
            if showingKontoSidbar{
                SidbarKonto
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            }else{
                SiderbarIpad
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))

            }
                        Spacer()

        }.navigationBarBackButtonHidden(true)
//            .padding(.top,30)
//        .padding(.vertical,30)
            .frame(width: siderbarOpen ? 250 : 100)
        .background(Color.theme.backgroundColor)
        .animation(.easeInOut(duration: 0.4),value: self.showingKontoSidbar)
    }
    
    private var SidbarKonto: some View{
        LazyVStack(alignment: .center){
            ForEach(EnumSidbarMenu.allCases,id: \.self) { tab in
                SiderbarItemForIpad(currentItem: $viewModel.currentItemKonto, title: viewModel.switchItemTitle(item: tab),icon: viewModel.switchItemIcon(item: tab), showSidbar: $showingKontoSidbar, siderbarOpen: $siderbarOpen, nameSpace: nameSpace)
              
                
            }
            Button{
                withAnimation(.easeInOut(duration: 0.4)) {
                    showingKontoSidbar.toggle()
                }
            }label: {
                
                HStack{
                    Image(systemName: "rectangle.grid.2x2")
                    if siderbarOpen{
                        Text("Menu")
                        Image(systemName: "chevron.forward.2")
                    }
                    Spacer()

                }
            }.buttonStyle(.plain)
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.horizontal,25)
                .padding()
        }
    }
    
    private var SiderbarIpad: some View{
        LazyVStack(alignment: .center){
            ForEach(EnumSidbarMenuIpad.allCases,id: \.self) { tab in
                SiderbarItemForIpad(currentItem: $viewModel.currentItem, title: tab.title,icon: tab.icon, showSidbar: $showingKontoSidbar, siderbarOpen: $siderbarOpen, nameSpace: nameSpace)
              
                
            }
            Button{
                withAnimation(.easeInOut(duration: 0.4)) {
                    showingKontoSidbar.toggle()
                }
            }label: {
                HStack{
                    Image(systemName: "person")
                    if siderbarOpen{
                        Text("Konto")
                        Image(systemName: "chevron.forward.2")

                    }
                    Spacer()
                }
            }.buttonStyle(.plain)
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.horizontal,25)
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
