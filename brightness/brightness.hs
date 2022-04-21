import System.Environment

-- Please edit system to fit your backlight system
system :: FilePath
system = "/sys/class/backlight/intel_backlight"

brightnessFile :: FilePath
brightnessFile = system ++ "/brightness"

maxBrightnessFile :: FilePath
maxBrightnessFile = system ++ "/max_brightness"

getBrightness :: FilePath -> IO Integer
getBrightness x = (read :: String -> Integer) . init <$> readFile x

setBrightness :: Integer -> IO ()
setBrightness x = writeFile brightnessFile $ show x ++ "\n"

scaleBrightness :: Float -> IO ()
scaleBrightness x = getBrightness maxBrightnessFile >>= \y ->
  setBrightness $ round $ x * (fromInteger y :: Float)

main = getArgs >>= \x ->
  scaleBrightness $ (read :: String -> Float) $ head x
