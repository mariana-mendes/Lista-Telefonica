salvaContato :: String -> String -> IO ()
salvaContato nome numero = do
			appendFile "lista.txt" (nome++ " " ++ numero ++ " " ++ "0" ++ "n")
		
	
	
	
			

listaContatos = do
	(x:xs) <- readFile "lista.txt"
	putStrLn "Nome  Número chamadas"
	listar (x:xs) ""
	
listar:: String -> String -> IO()
listar [] x = putStrLn x 
listar (x:xs) atual = do
	if([x] /= "n") then do
		listar xs (atual ++ [x])
	else if([x] == "n") then do 
		putStrLn atual
		listar xs ""
	else 
		print atual
promptLine :: String -> IO String
promptLine prompt = do
    putStr prompt
    getLine



printMenu:: IO() 
printMenu = do
	putStrLn "opcoes:"
	putStrLn "1. Adicionar contato."
	putStrLn "2. Listar contatos."
	putStrLn "3. Busca contato."
	putStrLn "4. Listar por Grupo."
	putStrLn "5. Listar contatos ordenados"
	putStrLn "6. Chamada de Emergência"
	putStrLn "7. Sair"
	putStrLn "Digite sua opção: "



main = do
	printMenu
	opcao <-  getLine
	 
	if((read opcao) == 1) then do
		putStrLn "Digite o nome do contato"
 		nome <- getLine
 		putStrLn "Digite o numero do contato"
 		numero <- getLine
		salvaContato nome numero
		
	else if ((read opcao == 2)) then do
		listaContatos
	else
		putStrLn "Opcao inválida, tente novamente."
	main 


