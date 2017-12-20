salvaContato :: String -> String -> IO ()
salvaContato nome numero = do
		
			appendFile "nomes.txt" (nome ++ "|")
			appendFile "telefones.txt" (numero ++ "|")
   
   
	
			
listaContatos = do

	nomes <- readFile "nomes.txt"
	if(length nomes == 0) then do
		putStrLn "Nenhum contato adicionado"
	else do	
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



exibeContato :: String -> IO()
exibeContato "" = print "Inexistente"
exibeContato nome = do
	(x:xs) <- readFile "nomes.txt"
	(y:ys) <- readFile "telefones.txt"
	let nomes = listar (x:xs) "" []
	let telefones = listar (y:ys) "" []
	let resultado = buscaContato nome nomes telefones
	print resultado
	



buscaContato :: String -> [String] -> [String] -> String
buscaContato nome [] [] = ""
buscaContato nome (x:xs) (y:ys) = do
	if(x == nome) then do
		x ++ " " ++ y
	else 
		buscaContato nome xs ys

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
	else if((read opcao == 3)) then do
		putStrLn "Digite o nome do contato "
		nome <- getLine
		exibeContato nome
	else
		print "opcao invalida"
		
	main 


