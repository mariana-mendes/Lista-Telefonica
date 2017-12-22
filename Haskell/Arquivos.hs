module Arquivos(
	getLista,
	carregaArquivo



)where


carregaArquivo [] x [] = []
carregaArquivo [] x lista = lista ++ [x] 
carregaArquivo (x:xs) atual lista = do
	if([x] /= "|" && [x] /= "") then do 
		carregaArquivo xs (atual ++ [x]) lista
	else if([x] == "|") then do 
		carregaArquivo xs "" (lista ++ [atual])
	else 
		lista ++ [atual]
		
		
getLista = do
	(w:ws) <- readFile "bloqueados.txt"
	return (w:ws)
