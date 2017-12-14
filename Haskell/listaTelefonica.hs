salvaContato :: String -> String -> IO ()
salvaContato nome numero = do
			appendFile "lista.txt" (nome++ "," ++ numero ++ "," ++ "0" ++ "\n")
		
			
listaContatos :: IO()
listaContatos = do
	x <- readFile "lista.txt"
	print x

promptLine :: String -> IO String
promptLine prompt = do
    putStr prompt
    getLine



printMenu:: IO() 
printMenu = do
	print "opcoes:"
	print "1. Adicionar contato."
	print "2. Listar contatos."
	print "3. Busca contato."
	print "4. Listar por Grupo."
	print "5. Listar contatos ordenados"
	print "6. Chamada de Emergência"
	print "7. Sair"
	print "Digite sua opção: "



main = do
	printMenu
	opcao <-  getLine
	 
	if((read opcao) == 1) then do
		print "Digite o nome do contato"
 		nome <- getLine
 		print "Digite o numero do contato"
 		numero <- getLine
		salvaContato nome numero
		
	else if ((read opcao == 2)) then do
		listaContatos
		else
			print "a"
	


