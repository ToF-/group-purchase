module CascadeRound
    where

cascadeRound :: [Double] -> [Integer]
cascadeRound = extract . foldl run (0.0, [], 0) 
    where
        extract :: (Double, [Integer], Integer) -> [Integer]
        extract (_, ns, _) = reverse ns

        run :: (Double, [Integer], Integer) -> Double -> (Double, [Integer], Integer)
        run (drt, ns, rrt) d = (drt', n:ns, rrt')
            where
            drt' = drt + d
            rrt' = round drt'
            n = rrt' - rrt
