//
//  RealmModel.swift
//  MemoApp
//
//  Created by 백유정 on 2021/11/11.
//

import Foundation
import RealmSwift

// UserMemo : 테이블 이름
// @Persisted : 컬럼
class UserMemo: Object {
    @Persisted var title: String //제목(필수)
    @Persisted var content: String? //내용(옵션)
    @Persisted var writeDate = Date() //작성날짜(필수)
    @Persisted var pinned: Bool //고정 기능(필수)

    
    // PK (필수) : Int, String, UUID, ObjectID -> AutoIncrement
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(title: String, content: String?, writeDate: Date){
        self.init()
        
        self.title = title
        self.content = content
        self.writeDate = writeDate
        self.pinned = false
    }
}

