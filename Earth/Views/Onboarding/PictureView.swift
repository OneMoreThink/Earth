//
//  PictureView.swift
//  Earth
//
//  Created by 이종선 on 11/15/23.
//

import SwiftUI

struct PictureView: View {
    
    @Binding var onboardingState: Onboarding
    @State var isNext = false
    
    @State var image: UIImage?
    @State var showPhotoPicker: Bool = false
    
    
    
    var body: some View {
        WalkthroughView(onboardingState: $onboardingState, isNext: $isNext){
            VStack(spacing: 20){
                
               QuestionForm(question: "마지막으로 당신의 멋진 모습을 보여주세요😀")
                    .padding(.bottom, 80)
                
                VStack{
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 300, height: 370)
                            .scaledToFill()
                            .clipShape(Circle())
                            .overlay{
                                Circle().stroke(.white.opacity(0.2), lineWidth: 5)
                            }
                            .shadow(radius: 5)
                            .padding(-40)
                            .padding(.horizontal,20)
                           
                   
                            
                           
                        
                    } else {
                        
                        Image(systemName: "camera.fill")
                            .font(.largeTitle)
                            .padding(.horizontal)
                            .frame(width: 320, height: 200)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.white.opacity(0.5))
                                    .shadow(radius: 30, x: 0, y: 20)
                                    .padding(-30)
                                    .padding(.horizontal,20)
                                
                            )
                        
                        
                    }
                }
                .onTapGesture {
                
                    PermissionsManagers.checkPhotoLibraryPermission { status in
                        switch status{
                        case .authorized:
                            showPhotoPicker.toggle()
                        // MARK: Error 처리 -> alert
                        default:
                            print("error")
                        }
                    }
                    
                   
                }
                .sheet(isPresented: $showPhotoPicker, content: {
                    UIImagePickerControllerRepresentable(image: $image, showPhotoPicker: $showPhotoPicker)
                })
                .onChange(of: image) {  _ in
                    showNextButton()
                }
                
                
                // Minimum spacing when phone is reducing
                Spacer(minLength: 30)
                
                
            }
            .padding()
            
        }
        
    }
    
    func showNextButton(){
        if image != nil {
            isNext = true
        }
    }

}

struct UIImagePickerControllerRepresentable: UIViewControllerRepresentable {
    
    @Binding var image: UIImage?
    @Binding var showPhotoPicker: Bool
    
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = context.coordinator
        
        return imagePickerController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(image: $image, showPhotoPicker: $showPhotoPicker)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        @Binding var image: UIImage?
        @Binding var showPhotoPicker: Bool
        
        init(image: Binding<UIImage?>, showPhotoPicker: Binding<Bool>) {
            self._image = image
            self._showPhotoPicker = showPhotoPicker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let newImage = info[.originalImage] as? UIImage else {return}
            image = newImage
            let success =
            UserImageManagers.shared.saveImage(image ?? UIImage(), withName: "userImage")
            if success {
            } else {
                //MARK: when fail make a alert
            }
            showPhotoPicker = false
        }
    }
}






struct PictureView_Previews: PreviewProvider{
    static var previews: some View{
        PictureView(onboardingState: .constant(.picture))
    }
}

