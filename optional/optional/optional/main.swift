import Foundation

//var optionalMyName:String? = "eunduk"
//optionalMyName = nil
//
//var myName:String = ""
//myName = optionalMyName!
//
//print(myName)
//var myName:String! = "eunduk"
//var eunduk:String
//
//eunduk = myName
//print(eunduk)

//// 일반 문자열 변수
//var name:String
////print(name) // 오류
//name = "eunduk" // 값을 줘야 사용할 수 있다.
//print(name) // eunduk 출력
//
//// 옵셔널 문자열 변수
//var optionalName:String?
//print(optionalName) // nil 출력
//optionalName = "eunduk"
//print(optionalName) // Optional("eunduk") 출력


//var optionalName:String? = "eunduk"
//
//var name:String
//name = optionalName // 일반 변수에 옵셔널 변수를 저장하면 에러 발생. 옵셔널 추출 필요
//name = optionalName! // 강제 추출. optionalName이 nil이라면 런타임 오류 발생
//
//print(name) // eunduk출력


//var optionalName:String? = "eunduk"
//var name:String
//
//// 옵셔널 바인딩
//// optionalName변수가 nil인지 체크하고 아니라면 bindingName변수에 할당하여 사용 (일반 변수 처럼 사용 가능)
//if var bindingName = optionalName {
//    name = bindingName
//    print(name) // eunduk출력
//} else { // optionalName변수가 nil일때 예외처리
//    print("optionalName변수가 nil입니다.")
//}

class Room { // 호실
    var number: Int // 호실 번호
    
    init(number:Int) {
        self.number = number
    }
}

class Building {
    var name: String // 건물
    var room: Room? // 건물 이름
    
    init(name:String) {
        self.name = name
    }
}

struct Address { // 주소
    var province: String // 광역시/도
    var city: String // 시/군/구
    var street: String // 도로명
    var building: Building? // 건물
    var detailAddress: String? // 건물 외 상세 주소
}

class Person { //사람
    var name: String // 이름
    var address: Address? // 주소
    
    init(name:String) {
        self.name = name
    }
}

// eunduk이라는 사람 생성
let eunduk: Person = Person(name: "eunduk")

// eunduk의 호실 번호에 접근
let optionalEundukRoom: Int? = eunduk.address?.building?.room?.number

if let roomNumber: Int = eunduk.address?.building?.room?.number {
    print(roomNumber)
} else {
    print("nil")
}

// 옵셔널 바인딩을 통해 호실 번호에 접근
if let eundukAddress = eunduk.address {
    if let eundukBuilding = eundukAddress.building {
        if let eundukRoom = eundukBuilding.room {
            //optionalEundukRoom = eundukRoom.number
        }
    }
}



eunduk.address = Address(province: "충청북도", city: "청주시 청원구", street: "충청대로")
eunduk.address?.building = Building(name: "곰굴")
//eunduk.address?.building?.room = Room(number: 0)
eunduk.address?.building?.room?.number = 505

//let optionalEundukRoom: Int = eunduk.address?.building?.room?.number
