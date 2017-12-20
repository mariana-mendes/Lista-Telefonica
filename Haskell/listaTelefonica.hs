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
		let (nome:restoNomes) = carregaContatos (x:xs) "" []
		let (telefone:telefones) = carregaContatos(y:ys) "" []
		printar (nome:restoNomes) (telefone:telefones)
	
printar:: [String] -> [String] -> IO()
printar [""] [""] = putStrLn "fim"
printar (nome:restoNomes) (telefone:restoTelefones) = do 
	putStrLn ("nome: " ++ nome)
	putStrLn ("telefone: " ++ telefone)
	printar restoNomes restoTelefones
	 
	
	
	
carregaContatos:: String -> String -> [String] -> [String]
carregaContatos [] x [] = []
carregaContatos [] x lista = lista ++ [x] 
carregaContatos (x:xs) atual lista = do
	if([x] /= "|") then do 
		carregaContatos xs (atual ++ [x]) lista
	else if([x] == "|") then do 
		carregaContatos xs "" (lista ++ [atual])
	else 
		lista ++ [atual]

exibeContato :: String -> IO()
exibeContato "" = print "Inexistente"
exibeContato nome = do
	(x:xs) <- readFile "nomes.txt"
	(y:ys) <- readFile "telefones.txt"
	let nomes = carregaContatos (x:xs) "" []
	let telefones = carregaContatos (y:ys) "" []
	let resultado = buscaContato nome nomes telefones
	print resultado
	



buscaContato :: String -> [String] -> [String] -> String
buscaContato nome [] [] = ""
buscaContato nome (x:xs) (y:ys) = do
	if(x == nome) then do
		x ++ " " ++ y
	else 
		buscaContato nome xs ys
		
deletaContato :: String -> String -> String -> [String]
deletaContato nome n t = do

	let nomes = carregaContatos n "" []
	let telefones = carregaContatos t "" []
	let resultado = apagaContato nome nomes telefones
	resultado
	
apagaContato :: String -> [String] -> [String] -> [String]
apagaContato nome [] []  = []
apagaContato nome (x:xs) (y:ys) = do
	if (x == nome) then do
		apagaContato nome xs ys
	else 
		 [x] ++ [y] ++ apagaContato nome xs ys 
		 
reescreveArquivo :: [String] -> IO()
reescreveArquivo [] = print "cabou porca"
reescreveArquivo (x:xs) = do
	salvaContato x (head xs)
	reescreveArquivo (tail xs)

printMenu:: IO() 
printMenu = do
	putStrLn "opcoes:"
	putStrLn "1. Adicionar contato."
	putStrLn "2. Listar contatos."
	putStrLn "3. Busca contato."
	putStrLn "4. Excluir Contato."
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
	else if ((read opcao == 4)) then do
		(x:xs) <- readFile "nomes.txt"
		(y:ys) <- readFile "telefones.txt"
		putStrLn "Digite o nome do contato "
		nome <- getLine
		reescreveArquivo (deletaContato (x:xs) (y:ys) nome)
		
	else
		print "opcao invalida"
		
	main 


