import UIKit

class SeSAC: UIView {

    @IBOutlet weak var posterImageView: UIImageView!

    
    // 필수적으로 구현해야하는 init
    /* required init을 선언 시
       super.init()을 호출하여 super class의 모든 프로퍼티를 초기화
     */
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        /*
         interface에서 구성한 값들은 모두 .xib파일로 저장
         xib파일은 컴파일러가 이해하지 못하기에
         컴파일러가 이해할 수 있는 nib형식으로 변환
         
         UINib은 nib파일의 내용을 메모리에 보관하고 있다가
         보관 취소 및 인스턴스화 준비
         */
        let view = UINib(nibName: "SeSAC", bundle: nil).instantiate(withOwner: self).first as! UIView
        view.frame = bounds
        view.backgroundColor = .clear
        
        self.addSubview(view)
    }
    
}
