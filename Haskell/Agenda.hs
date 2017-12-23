module Agenda(

salvaContato,
ordenaContatos,
printaOrdenado,
ordena,
modelaArquivo,
findContato
)


where

salvaContato :: String -> String -> IO ()
salvaContato nome numero = do
			appendFile "nomes.txt" (nome ++ "|")		
			appendFile "telefones.txt" (numero ++ "|")



---- printa lista ordenada
printaOrdenado ::[String] -> [String] -> [String] -> IO()
printaOrdenado [] x y = putStrLn "fim"
printaOrdenado (x:xs) nomes telefones = do
	if(x /= "") then do
		putStrLn (findContato x  nomes telefones)
		printaOrdenado xs nomes telefones
	else do
		printaOrdenado xs nomes telefones
		
		
----- metodo chamado pelo main para ordenar a lista
ordenaContatos :: String -> String -> IO()
ordenaContatos n t = do
	let nomes = modelaArquivo n "" []
	let telefones = modelaArquivo t "" []
	let nomesOrdenados = ordena nomes
	printaOrdenado nomesOrdenados nomes telefones
	
	
--- quickSort para ordenar nomes
ordena:: [String] -> [String]	
ordena [] = []
ordena (x:xs) = lesserThan ++ [x] ++ greaterThan
    where
    lesserThan =ordena $ filter (< x) xs
    greaterThan = ordena $ filter (>= x) xs


---- metodo que modela o arquivo para virar uma lista
modelaArquivo:: String -> String -> [String] -> [String]
modelaArquivo [] x [] = []
modelaArquivo [] x lista = lista ++ [x] 
modelaArquivo (x:xs) atual lista = do
	if([x] /= "|" && [x] /= "") then do 
		modelaArquivo xs (atual ++ [x]) lista
	else if([x] == "|") then do 
		modelaArquivo xs "" (lista ++ [atual])
	else 
		lista ++ [atual]


----- acha contato especifico Nome + Telefone
findContato :: String -> [String] -> [String] -> String
findContato nome [] [] = ""
findContato nome (x:xs) (y:ys) = do
	if(x == nome) then do
		"Nome :" ++ x ++ " " ++ "Telefone: "++ y
	else 
		findContato nome xs ys
