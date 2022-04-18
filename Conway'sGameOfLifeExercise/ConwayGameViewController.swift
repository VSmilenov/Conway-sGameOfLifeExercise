//
//  ViewController.swift
//  Conway'sGameOfLifeExercise
//
//  Created by Vasil Smilenov on 4/13/22.
//

import UIKit

class ConwayGameViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout  {
    
   
    
    let rowCount = 32

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rowCount * rowCount
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell  {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "conwayCell", for: indexPath)
        cell.backgroundColor = UIColor.gray
        return cell
    }
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let size = Int(collectionView.bounds.size.width)/rowCount - 3
         return CGSize(width: size, height: size)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ConwayGameCellCollectionViewCell
        if cell.backgroundColor == UIColor.red {
            cell.backgroundColor = UIColor.gray
        } else {
            cell.backgroundColor = UIColor.red
        }
    }
        
    @IBAction func clearCells(_ sender: Any) {
        for i in 0...rowCount * rowCount - 1 {
            let indexPath = IndexPath(row: i, section: 0)
            if let cell = collectionView.cellForItem(at: indexPath) {
                cell.backgroundColor = UIColor.gray
            }
        }
    }
    
    func aliveNeighboursCount(cell: UICollectionViewCell ) -> Int {
        var count = 0
        if let indexPath = collectionView.indexPath(for: cell) {
           
            let isLeftCell = indexPath.row % rowCount == 0
            let isRightCell = indexPath.row % rowCount == rowCount - 1
            if !isRightCell{
                let rightIndexPath = IndexPath(row: indexPath.row + 1, section: 0)
                let rightCell = collectionView.cellForItem(at: rightIndexPath)
                if rightCell?.backgroundColor == UIColor.red {
                    count += 1
                }
                let topRightIndexPath = IndexPath(row: indexPath.row - rowCount + 1, section: 0)
                let topRightCell = collectionView.cellForItem(at: topRightIndexPath)
                if topRightCell?.backgroundColor == UIColor.red {
                    count += 1
                }
                let bottomRightIndexPath = IndexPath(row: indexPath.row + rowCount + 1, section: 0)
                let bottomRightCell = collectionView.cellForItem(at: bottomRightIndexPath)
                if bottomRightCell?.backgroundColor == UIColor.red {
                    count += 1
                }
                
            }
            if !isLeftCell {
                let leftIndexPath = IndexPath(row: indexPath.row - 1, section: 0)
                let leftCell = collectionView.cellForItem(at: leftIndexPath)
                if leftCell?.backgroundColor == UIColor.red {
                    count += 1
                }
                let topLeftIndexPath = IndexPath(row: indexPath.row - rowCount - 1, section: 0)
                let topLeftCell = collectionView.cellForItem(at: topLeftIndexPath)
                if topLeftCell?.backgroundColor == UIColor.red {
                    count += 1
                }
                let bottomLeftIndexPath = IndexPath(row: indexPath.row + rowCount - 1, section: 0)
                let bottomLeftCell = collectionView.cellForItem(at: bottomLeftIndexPath)
                if bottomLeftCell?.backgroundColor == UIColor.red {
                    count += 1
                }
            }
            let topIndexPath = IndexPath(row: indexPath.row - rowCount, section: 0)
            let topCell = collectionView.cellForItem(at: topIndexPath)
            if topCell?.backgroundColor == UIColor.red {
                count += 1
            }
           
            let bottomIndexPath = IndexPath(row: indexPath.row + rowCount, section: 0)
            let bottomCell = collectionView.cellForItem(at: bottomIndexPath)
            if bottomCell?.backgroundColor == UIColor.red {
                count += 1
            }
            print("\(indexPath) -> \(count)")
        }
        return count
    }
    
    @IBAction func nextItteration(_ sender: Any) {
        var cellColors = [Int:UIColor]()
        for cellIndex in 0..<rowCount * rowCount {
            let indexPath = IndexPath(row: cellIndex, section: 0)
            if let cell = collectionView.cellForItem(at: indexPath) {
                let result = aliveNeighboursCount(cell: cell)
//                print("\(indexPath) --- \(result)")
                if result <= 2 {
                    cellColors[indexPath.row] = UIColor.gray
                }
                if result > 3 {
                    cellColors[indexPath.row] = UIColor.gray
                }
                if  cell.backgroundColor == UIColor.red && (result == 2 || result == 3) {
                    cellColors[indexPath.row] = UIColor.red
                }
                if cell.backgroundColor == UIColor.gray && result == 3 {
                    cellColors[indexPath.row] = UIColor.red
                }
            }
        }
        for (key,value) in cellColors {
            let indexPath = IndexPath(row: key, section: 0)
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.backgroundColor = value
        }
    }
    
}

