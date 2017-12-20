salvaContato :: String -> String -> IO ()
salvaContato nome numero = do
		
			appendFile "nomes.txt" (nome ++ "|")
			appendFile "telefones.txt" (numero ++ "|")
   
   
	
			

listaContatos = do
	(x:xs) <- readFile "nomes.txt"
	(y:ys) <- readFile "telefones.txt"
	let (nome:restoNomes) = listar (x:xs) "" []
	let (telefone:telefones) = listar(y:ys) "" []
	printar (nome:restoNomes) (telefone:telefones)
	
printar:: [String] -> [String] -> IO()
printar [""] [""] = putStrLn "fim"
printar (nome:restoNomes) (telefone:restoTelefones) = do 
	putStrLn ("nome: " ++ nome)
	putStrLn ("telefone: " ++ telefone)
	printar restoNomes restoTelefones
	 
	
	
	
listar:: String -> String -> [String] -> [String]
listar [] x [] = []
listar [] x lista = lista ++ [x] 
listar (x:xs) atual lista = do
	if([x] /= "|") then do 
		listar xs (atual ++ [x]) lista
	else if([x] == "|") then do 
		listar xs "" (lista ++ [atual])
	else 
		lista ++ [atual]
promptLine :: String -> IO String
promptLine prompt = do
    putStr prompt
    getLine

data Contact = Contact {
  firstName :: String,
  lastName :: String,
  phoneNumber :: String 
 
} deriving Show



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


