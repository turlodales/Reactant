//
//  SequenceType+FirstWhere.swift
//
//  Created by Tadeáš Kříž on 15/06/16.
//

public extension SequenceType {

    public func first(@noescape where condition: Generator.Element -> Bool) -> Generator.Element? {
        for item in self where condition(item) {
            return item
        }
        return nil
    }

}