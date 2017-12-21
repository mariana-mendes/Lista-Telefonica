
import System.IO
import Data.Char
import System.Directory
salvaContato :: String -> String -> IO ()
salvaContato nome numero = do
		
			appendFile "nomes.txt" (nome ++ "|")
			appendFile "bloqueados.txt" ("0")
			appendFile "telefones.txt" (numero ++ "|")
listaContatos = do

	nomes <- readFile "nomes.txt"
	if(length nomes == 0) then do
		putStrLn "Nenhum contato adicionado"
	else do	
		(x:xs) <- readFile "nomes.txt"
		(y:ys) <- readFile "telefones.txt"
		(w:ws) <- readFile "bloqueados.txt"
		let (nome:restoNomes) = carregaContatos (x:xs) "" []
		let (telefone:telefones) = carregaContatos(y:ys) "" []
		printar (nome:restoNomes) (telefone:telefones) (w:ws)
	
printar:: [String] -> [String] -> String-> IO()
printar [""] [""] x = putStrLn "fim"
printar (nome:restoNomes) (telefone:restoTelefones)(bloq:restobloq) = do 
	if([bloq] == "1") then do
		printar restoNomes restoTelefones restobloq
	else do
		putStrLn ("nome: " ++ nome)
		putStrLn ("telefone: " ++ telefone)
		printar restoNomes restoTelefones restobloq
	 
	
	
	
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
		"Nome :" ++ x ++ " " ++ "Telefone: "++ y
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

bloqueaContato:: String -> [String] -> String -> String
bloqueaContato nome [] []  = ""
bloqueaContato nome [""] "" = ""
bloqueaContato nome (x:nomes) (w:bloqueados) 
	|nome == x = "1" ++bloqueaContato nome nomes  bloqueados
	|x == "" = 	bloqueaContato nome nomes  bloqueados 
	|otherwise = [w] ++ bloqueaContato nome nomes  bloqueados 

printMenu:: IO() 
printMenu = do
	putStrLn "opcoes:"
	putStrLn "1. Adicionar contato."
	putStrLn "2. Listar contatos."
	putStrLn "3. Busca contato."
	putStrLn "4. Excluir Contato."
	putStrLn "5. Bloquear contato"
	putStrLn "6. Ordenar contatos"
	putStrLn "7. Sair"
	putStrLn "Digite sua opção: "

-- nomes atualizados
atualizaLista :: String -> [String] -> [String]
atualizaLista n [""] = []
atualizaLista n (nome:nomes) = do
	if(n /= nome) then do
		[nome] ++ atualizaLista n nomes
	else 
		atualizaLista n nomes


--numeros atualizados
atualiza :: String -> [String]-> [String] -> [String] 	
atualiza n [""] [""] = []
atualiza n (nome:nomes) (num:nums) = do
	if(n /= nome) then do
		[num] ++ atualiza n nomes nums
	else 
		atualiza n nomes nums

sob :: IO()
sob  = do
	writeFile "nomes.txt" ("")
	writeFile "telefones.txt" ("")

atualizaArquivo :: [String] -> [String] -> IO()
atualizaArquivo [] [] = print "agenda atualizada"
atualizaArquivo (x:xs) (y:ys) = do
	salvaContato x y
	atualizaArquivo xs ys
atualizaBloqueados:: String -> IO()
atualizaBloqueados nova = writeFile "bloqueados.txt" (nova)

ordena:: [String] -> [String]	
ordena [] = []
ordena (x:xs) = lesserThan ++ [x] ++ greaterThan
    where
    lesserThan =ordena $ filter (< x) xs
    greaterThan = ordena $ filter (>= x) xs
printaOrdenado ::[String] -> [String] -> [String] -> IO()
printaOrdenado [] x y = putStrLn "fim"
printaOrdenado (x:xs) nomes telefones = do
	if(x /= "") then do
		putStrLn (buscaContato x  nomes telefones)
		printaOrdenado xs nomes telefones
	else do
		printaOrdenado xs nomes telefones
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
		let attNums = atualiza nome  (carregaContatos (x:xs)  "" []) (carregaContatos (y:ys) "" []) 
		let attNomes = atualizaLista nome (carregaContatos (x:xs) "" [])
		a <- removeFile "nomes.txt"
		b <- removeFile "telefones.txt"
		sob 
		atualizaArquivo attNomes attNums
	
		print "Contato excluido"
	else if((read opcao) == 5) then do
		(x:xs) <- readFile "nomes.txt"
		bloq <- readFile "bloqueados.txt"
		let nomes = carregaContatos (x:xs) "" []
		putStrLn "Digite o nome do contato "
		nome <- getLine
		let saida = bloqueaContato nome nomes bloq 
		a <- removeFile "bloqueados.txt"
		atualizaBloqueados saida
		print "pronto"
	else if((read opcao) == 6) then do
		(x:xs) <- readFile "nomes.txt"
		let nomes = carregaContatos (x:xs) "" []
		(y:ys) <- readFile "telefones.txt" 
		let telefones = carregaContatos (y:ys) "" []
		let nomesOrdenado = ordena nomes
		printaOrdenado nomesOrdenado nomes telefones
	else
		print "opcao invalida"
	main 
