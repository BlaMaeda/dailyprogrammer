import Data.List

collideSorted :: (Eq a, Ord a) => [a] -> [a] -> ([a], Int, Int)
collideSorted as [] = (as, length as, 0)
collideSorted [] bs = (bs, 0, length bs)
collideSorted (a:as) (b:bs) = 
    if a == b then
        let (tailCollision, aContrib, bContrib) = collideSorted as bs in 
            (tailCollision, aContrib, bContrib)
    else if a < b then
        let (tailCollision, aContrib, bContrib) = collideSorted as (b:bs) in 
            (a : tailCollision, 1 + aContrib, bContrib)
    else
        let (tailCollision, aContrib, bContrib) = collideSorted (a:as) bs in 
            (b : tailCollision, aContrib, 1 + bContrib)

collide :: (Eq a, Ord a) => [a] -> [a] -> ([a], Int, Int)
collide as bs = collideSorted (sort as) (sort bs)

main :: IO ()
main = do
    line <- getLine
    lineWords <- return $ words line
    (a, b) <- return $ (lineWords !! 0, lineWords !! 1)
    (collision, aContrib, bContrib) <- return $ collide a b
    putStrLn $ "Collision: " ++ collision
    if aContrib > bContrib then
        putStrLn "Left wins"
    else if bContrib > aContrib then
        putStrLn "Right wins"
    else
        putStrLn "Tie"
