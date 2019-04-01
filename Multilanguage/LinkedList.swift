//
//  LinkedList.swift
//  Multilanguage
//
//  Created by Павел Нехорошкин on 01.04.2019.
//  Copyright © 2019 Павел Нехорошкин. All rights reserved.
//

import Foundation
protocol Container
{
    associatedtype Item
    
    func count()->Int
    func add(_ item: Item)
    func getByIndex(_ index: Int) -> Item!
}

//универсальный связанный список
class LinkedList<T: NSObject>:Container
{
    
    typealias Item = T
    
    var _item : T?
    var _next : LinkedList<T>?
    
    init(_ item: T)
    {
        self._item = item
    }
 
    func count()->Int
    {
        if self._item == nil
        {
            return 0 //первый узел пустой только в пустом списке
        }
        var node = self
        var count = 1
        while node._next != nil
        {
            node = node._next!
            count = count + 1
        }
        return count
    }
    
    func add(_ item: T)
    {
        if self._item == nil
        {
            self._item = item
        }
        var node = self
        while node._next != nil
        {
            node = node._next!
        }
        let new = LinkedList<T>(item)
        node._next = new
    }
    
    func getByIndex(_ index: Int) -> T!
    {
        if index<0 {
            return nil
        }
        var count = 0
        var node = self
        while count < index
        {
            if node._next != nil
            {
                count = count + 1
                node = node._next!
            } else{
                return nil
            }
        }
        return node._item!
    }
    func removeByIndex(_ index: Int)
    {
        var _index = index
        if index<0 {
            return
        }
        
        //если удаляем первый элемент, то первый узел оставляем,
        //его удалять нельзя, потому что он держит связь со всем списком
        //переносим в первый узел значение следующего
        //следующий узел освобождаем и убираем из списка
        var node = self._next
        if _index == 0
        {
            //нет следующего узла
            if node == nil
            {
                self._item = nil
                return //других узлов, исправлять не нужно
            }
            else
            {
                //есть следующий узел, тогда его содержимое переносим в первый узел
                self._item = node!._item
                _index = 1 //теперь задача свелась к удалению второго узла
            }
        }
        
        //штатно удаляем нужный узел, это может быть второй или следующие
        if node == nil
        {
            return//второго и следующих узлов нет, удалять нечего
        }
        //отсчитываем элементы, запоминая предыдущий
        var previous = self
        
        //второй узел есть, начинаем отсчет с него (индекс 1),
        //пока не досчитаем до нужного узла,
        //или список не закончится
        while _index > 1
        {
            //список еще не закончился
            if node!._next != nil
            {
                _index = _index - 1
                previous = node!
                node = node!._next
            }
            else
            {
                //завершить, если список закончился
                return
            }
        }
        
        //нашли нужный элемент
        //удаляем ссылку на содержимое-контейнер
        node!._item = nil
        
        if node!._next == nil
        {
            //если узел последний
            //удаляем ссылку на него с предыдущего значения
            previous._next = nil
            return
        }
        else
        {
            //если узел не последний
            //то ссылаемся с предыдущего узла на следующий за удаляемым
            previous._next = node!._next!
            //на всякий случай в удаляемом узле стираем ссылку на следующий
            node!._next = nil
        }
    }
    
    func print(){
        
        if self._item == nil
        {
            Swift.print("[nil]")
            return
        }
        
        var node = self
        
        Swift.print("[\'", terminator:  "")
        Swift.print(String(describing:node._item!), terminator : "")
        Swift.print("\'", terminator:  "")
        
        while node._next != nil
        {
            node = node._next!
            Swift.print((", \'" + String(describing:node._item!) + "\'"), terminator : "")
            
        }
        Swift.print("]")
    }
    
}

@objc(LinkedList)
public class LinkedListWrapper: NSObject
{
    
    private let linkedList:LinkedList<NSString>
    
    @objc
    init(_ item: NSString)
    {
        
        linkedList = LinkedList<NSString>(item)
    }
    
    
    @objc
    public func count()->Int
    {
       return linkedList.count()
    }
    
    @objc
    public func add(_ item: NSString)
    {
        return linkedList.add(item)

    }
    
    @objc
    public func getByIndex(_ index: Int) -> NSString!
    {
        return linkedList.getByIndex(index)

    }
    
    @objc
    func removeByIndex(_ index: Int)
    {
        linkedList.removeByIndex(index)
    }
        
        
    @objc
    func print()
    {
        linkedList.print()
    }
    
}
