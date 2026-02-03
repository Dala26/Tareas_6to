
import Text.Read (readMaybe) -- Nos ayuda convertir cadenas a números de forma segura

readDouble :: String -> IO (Maybe Double) -- Recibe un string y devuelve un IO (entrada/salida) que contiene un Maybe Double
readDouble prompt = putStrLn prompt >> fmap readMaybe getLine -- aplica una función “dentro de un contexto” sin sacar el valor de ese contexto.
-- por ejemplo en este caso, getLine devuelve un IO String, y fmap aplica readMaybe a ese String dentro del contexto IO.

executeOperacion :: Char -> Double -> Double -> Maybe Double -- Recibe un carácter (operación) y dos números, devuelve un Maybe Double
executeOperacion '1' x y = Just (x + y) -- un switch/case simple
executeOperacion '2' x y = Just (x - y)
executeOperacion '3' x y = Just (x * y)
executeOperacion '4' x y = if y == 0 then Nothing else Just (x / y)
executeOperacion _   _ _ = Nothing

main :: IO ()
main = do
    Just x <- readDouble "Ingrese el primer número:" -- Usamos pattern matching para extraer el valor, si ponemos una letra y no un número, el programa fallará aquí (nothing).
    Just y <- readDouble "Ingrese el segundo número:"
    putStrLn "Elija operación: 1) Suma  2) Resta  3) Multiplicación  4) División"
    op <- getLine
    case executeOperacion (head op) x y of
        Just r  -> putStrLn $ "Resultado: " ++ show r
        Nothing -> putStrLn "Operación inválida o división por cero."