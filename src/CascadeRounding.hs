module CascadeRounding
    where

cascadeRounding :: [Double] -> [Integer]
cascadeRounding = extract . foldl cascadeRound (0.0, [], 0) 
    where
        extract :: (Double, [Integer], Integer) -> [Integer]
        extract (_, ns, _) = reverse ns

        cascadeRound :: (Double, [Integer], Integer) -> Double -> (Double, [Integer], Integer)
        cascadeRound (drt, ns, rrt) d = (drt', n:ns, rrt')
            where
            drt' = drt + d
            rrt' = round drt'
            n = rrt' - rrt
