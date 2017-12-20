
--- salvaContato um contato faz 'append' num arquivo ja existente, separando o atributo por | 
salvaContato :: String -> String -> IO ()
salvaContato nome numero = do
			appendFile "nomes.txt" (nome ++ "|")
			appendFile "telefones.txt" (numero ++ "|")
   
   
	
--- carrega um arquivo existente relativo aos nome, se ele estiver vazio, ainda nao existem contatos
--- se nao estiver vazio, carregamos os arquivos com os outros atributos			
listaContatos = do
	nomes <- readFile "nomes.txt"
	if(length nomes == 0) then do
		putStrLn "Nenhum contato adicionado"
	else do	
		(x:xs) <- readFile "nomes.txt"
		(y:ys) <- readFile "telefones.txt"
		
		---chamamos o listar para 'guardar' numa lista, os atributos removendo o pipe
		---e fazendo cada atributo pertencer a um indice e assim fazer o mapeamento
		---ex: nomes = [contato1, contato2... contaton], telefones =[numero1, numero2... numeron]
		
		let (nome:restoNomes) = listar (x:xs) "" []
		let (telefone:telefones) = listar(y:ys) "" []
		printar (nome:restoNomes) (telefone:telefones)
		
		
--- listar remove o pipe e retorna apenas a 1 lista especifica de atributos		
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
		


--- printa os resultados do metodo que lista os contatos	
printar:: [String] -> [String] -> IO()
printar [""] [""] = putStrLn "fim"
printar (nome:restoNomes) (telefone:restoTelefones) = do 
	putStrLn ("nome: " ++ nome)
	putStrLn ("telefone: " ++ telefone)
	printar restoNomes restoTelefones
	 
	
	
	



exibeContato :: String -> IO()
exibeContato "" = print "Inexistente"
exibeContato nome = do
	---- carrega contatos
	(x:xs) <- readFile "nomes.txt"
	(y:ys) <- readFile "telefones.txt"
	
	--- chama listar pra remover os pipes
	let nomes = listar (x:xs) "" []
	let telefones = listar (y:ys) "" []
	
	---chamamos o buscaContato para achar o nome que foi solicitado
	let resultado = buscaContato nome nomes telefones
	print resultado
	

--- recebe listas de atributos e nome especifico que esta sendo procurado
buscaContato :: String -> [String] -> [String] -> String
buscaContato nome [] [] = ""

--- como estamos relacionando atributos por indices, precisamos percorerr todas as listas ao mesmo tempo
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


