module CascadeRound
    where

cascadeRound :: [Double] -> [Integer]
cascadeRound = extract . foldl run (0.0, [], 0) 
    where
        extract :: (Double, [Integer], Integer) -> [Integer]
        extract (_, ns, _) = reverse ns

        run :: (Double, [Integer], Integer) -> Double -> (Double, [Integer], Integer)
        run (doubleRunningTotal, results, roundedRunningTotal) double = (doubleRunningTotal', int:results, roundedRunningTotal')
            where
            doubleRunningTotal' = doubleRunningTotal + double
            roundedRunningTotal' = round doubleRunningTotal'
            int = roundedRunningTotal' - roundedRunningTotal
