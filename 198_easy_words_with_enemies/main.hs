import qualified Data.Sequence as Seq

collideSorted :: Ord a => Seq a -> Seq a -> (Seq a, Integer, Integer)
collideSorted as0 bs0 = case (Seq.viewL as0, Seq.viewL bs0) of
    (_, Seq.EmptyL) -> (as0, 0, Seq.size as0)
    (Seq.EmptyL, _) -> (bs0, 0, Seq.size bs0)
    (a Seq.:< as, b Seq.:< bs) -> case compare a b of
       EQ -> collideSorted as bs
       LT -> let (tailCol, aContrib, bContrib) = collideSorted as bs0
             in  (a Seq.<| tailCol, 1 + aContrib, bContrib)
       GT -> let (tailCol, aContrib, bContrib) = collideSorted as0 bs
             in  (b Seq.<| tailCol, aContrib, 1 + bContrib)
    
collide :: Ord a => [a] -> [a] -> (Seq a, Int, Int)
collide as bs = collideSorted (Sec.fromList $ sort as) (Seq.fromList $ sort bs) 
-- I think this can be written as: collide = collideSorted `on` (Seq.fromList . sort) -- `on` from Data.Function.on

main :: IO ()
main = do
    (a:b:_) <- fmap words getLine
    let (collision, aContrib, bContrib) = collide a b
    putStrLn $ "Collision: " ++ show collision
    putstrLn $ case compare aContrib bContrib of
       EQ -> "Tie"
       LT -> "Right wins"
       GT -> "Left wins"
