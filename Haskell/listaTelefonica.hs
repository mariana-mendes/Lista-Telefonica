
import System.IO
import Data.Char
import System.Directory

------------------------  ADICIONAR --------------------------------------
salvaContato :: String -> String -> IO ()
salvaContato nome numero = do
			appendFile "nomes.txt" (nome ++ "|")
			appendFile "bloqueados.txt" ("0")
			appendFile "telefones.txt" (numero ++ "|")


------------------------ LISTAR  -----------------------------------------
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
	if([x] /= "|" && [x] /= "") then do 
		carregaContatos xs (atual ++ [x]) lista
	else if([x] == "|") then do 
		carregaContatos xs "" (lista ++ [atual])
	else 
		lista ++ [atual]

---------------- EXIBIR CONTATO ESPECIFICO ----------------------------- 

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
	
------------------------------ BLOCK ---------------------------------------

bloqueaContato:: String -> [String] -> String -> String -> String
bloqueaContato nome [] []  x= ""
bloqueaContato nome [""] "" x= ""
bloqueaContato nome (x:nomes) (w:bloqueados) op
	|nome == x = op ++bloqueaContato nome nomes  bloqueados op
	|x == "" =  bloqueaContato nome nomes  bloqueados op
	|otherwise = [w] ++ bloqueaContato nome nomes  bloqueados op 




----------------------------- DELETE ------------------------------------------

------- nomes atualizados
atualizaLista :: String -> [String] -> [String]
atualizaLista n [""] = []
atualizaLista n (nome:nomes) = do
	if(n /= nome) then do
		[nome] ++ atualizaLista n nomes
	else 
		atualizaLista n nomes

------numeros atualizados
atualiza :: String -> [String]-> [String] -> [String] 	
atualiza n [""] [""] = []
atualiza n (nome:nomes) (num:nums) = do
	if(n /= nome) then do
		[num] ++ atualiza n nomes nums
	else 
		atualiza n nomes nums

sobrescreve :: IO()
sobrescreve  = do
	writeFile "nomes.txt" ("")
	writeFile "telefones.txt" ("")
	---writeFile "bloqueados.txt"("")



atualizaArquivo :: [String] -> [String] -> IO()
atualizaArquivo [] [] = print "agenda atualizada"
atualizaArquivo [""] [""] = print "agenda atualizada"
atualizaArquivo [""] [] = print "agenda atualizada"
atualizaArquivo [] [""] = print "agenda atualizada"
atualizaArquivo (x:xs) (y:ys) = do
	salvaContato x y
	atualizaArquivo xs ys
atualizaBloqueados:: String -> IO()
atualizaBloqueados nova = writeFile "bloqueados.txt" (nova)





-----------------------------ORDENACAO-----------------------------------------------

printaOrdenado ::[String] -> [String] -> [String] -> IO()
printaOrdenado [] x y = putStrLn "fim"
printaOrdenado (x:xs) nomes telefones = do
	if(x /= "") then do
		putStrLn (buscaContato x  nomes telefones)
		printaOrdenado xs nomes telefones
	else do
		printaOrdenado xs nomes telefones
		
ordena:: [String] -> [String]	
ordena [] = []
ordena (x:xs) = lesserThan ++ [x] ++ greaterThan
    where
    lesserThan =ordena $ filter (< x) xs
    greaterThan = ordena $ filter (>= x) xs
	
	
----------------------------- EDITA CONTATO ----------------------------------------------------
------- nomes atualizados
editaContato :: String -> String ->  [String] -> [String]
editaContato dadoAntigo dadoNovo [""] = []
editaContato dadoAntigo dadoNovo (dado:dados) = do
	if(dadoAntigo /= dado) then do
		[dado] ++ editaContato dadoAntigo dadoNovo dados
	else 
		[dadoNovo] ++ editaContato dadoAntigo dadoNovo dados

buscaNumero:: String -> [String] -> [String] -> String
buscaNumero x [] [] = "|"
buscaNumero nomeBuscado (nome:nomes) (telefone:telefones) = do
	if(nome == nomeBuscado) then do 
		telefone
	else
		buscaContato nomeBuscado nomes telefones

		
----------------------------- MENU ----------------------------------------------------

printMenu:: IO() 
printMenu = do
	putStrLn "opcoes:"
	putStrLn "1. Adicionar contato."
	putStrLn "2. Listar contatos."
	putStrLn "3. Busca contato."
	putStrLn "4. Excluir Contato."
	putStrLn "5. Bloquear contato"
	putStrLn "6. Ordenar contatos"
	putStrLn "7. altera Contato"
	putStrLn "Digite sua opção: "


	
main = do
	printMenu
	opcao <-  getLine
	if(opcao== "1") then do
		putStrLn "Digite o nome do contato"
 		nome <- getLine
 		putStrLn "Digite o numero do contato"
 		numero <- getLine
		salvaContato nome numero
		
	else if ( opcao == "2") then do
		listaContatos
		
		
	else if((read opcao == 3)) then do
		putStrLn "Digite o nome do contato "
		nome <- getLine
		exibeContato nome
		
		
----------- DELETE ------------------		
	else if (opcao == "4") then do	
		(x:xs) <- readFile "nomes.txt"
		(y:ys) <- readFile "telefones.txt"
		putStrLn "Digite o nome do contato "
		nome <- getLine
		let attNums = atualiza nome  (carregaContatos (x:xs)  "" []) (carregaContatos (y:ys) "" []) 
		let attNomes = atualizaLista nome (carregaContatos (x:xs) "" [])
		a <- removeFile "nomes.txt"
		b <- removeFile "telefones.txt"
		sobrescreve 
		atualizaArquivo attNomes attNums
	
		print "Contato excluido"
		
		
----------- BLOCK ------------------		
	else if(opcao == "5") then do
		(x:xs) <- readFile "nomes.txt"
		bloq <- readFile "bloqueados.txt"
		let nomes = carregaContatos (x:xs) "" []
		putStrLn "Digite o nome do contato "
		nome <- getLine
		putStrLn "Deseja bloquear ou desbloquear o contato "
		putStrLn "1.Bloquear"
		putStrLn "2.desbloquear"
		op <- getLine
		if(op == "1") then do 
			let saida = bloqueaContato nome nomes bloq "1"
			a <- removeFile "bloqueados.txt"
			atualizaBloqueados saida
		else do
			let saida = bloqueaContato nome nomes bloq "0"
			a <- removeFile "bloqueados.txt"
			atualizaBloqueados saida
		 
		
		print "pronto"
		
----------- ORDENAR -----------------		
	else if(opcao == "6") then do
		(x:xs) <- readFile "nomes.txt"
		let nomes = carregaContatos (x:xs) "" []
		(y:ys) <- readFile "telefones.txt" 
		let telefones = carregaContatos (y:ys) "" []
		let nomesOrdenado = ordena nomes
		printaOrdenado nomesOrdenado nomes telefones
		
		
-------------- EDITAR ------------------		
	else if(opcao == "7") then do 
		
		putStrLn "qual contato deseja alterar?"
		
		nomeContato <- getLine
		
		(x:xs) <- readFile "nomes.txt"
		let nomes = carregaContatos (x:xs) "" []
		(y:ys) <- readFile "telefones.txt" 
		let telefones = carregaContatos (y:ys) "" []
		putStrLn "quais atributos deseja alterar?"
		putStrLn "1. Nome"
		putStrLn "2.Telefone"
		putStrLn "3.Nome e telefone"
		alternativa <- getLine 
		
		------------ NOME -----------------
		
		if(alternativa == "1")then do 
			putStrLn "Digite o novo nome:"
			novoNome <- getLine 
			let nomesEditados = editaContato nomeContato novoNome nomes
			print nomesEditados
			print telefones
			a <- removeFile "nomes.txt"
			b <- removeFile "telefones.txt"
			c <- removeFile "bloqueados.txt"
			sobrescreve 
			atualizaArquivo nomesEditados telefones
			putStrLn "Nome alterado com sucesso"
			
		---------- TELEFONE -----------------
			
		else if(alternativa == "2") then do 
			putStrLn "Digite o novo Telefone:"
			novoNumero <- getLine 
			let numeroContato = buscaNumero nomeContato nomes telefones
			let telefonesEditados = editaContato numeroContato novoNumero telefones
	
			print telefones
			a <- removeFile "nomes.txt"
			b <- removeFile "telefones.txt"
			c <- removeFile "bloqueados.txt"
			sobrescreve 
			atualizaArquivo nomes telefonesEditados
			putStrLn "Telefone alterado com sucesso"
			
		---------- NOME E TELEFONE --------------	
		
		else if(alternativa == "3") then do 
			putStrLn "Digite o novo nome:"
			novoNome <- getLine 
			putStrLn "Digite o novo Telefone:"
			novoNumero <- getLine
			
			let numeroContato = buscaNumero nomeContato nomes telefones
			let telefonesEditados = editaContato numeroContato novoNumero telefones
			let nomesEditados = editaContato nomeContato novoNome nomes
			a <- removeFile "nomes.txt"
			b <- removeFile "telefones.txt"
			c <- removeFile "bloqueados.txt"
			sobrescreve 
			atualizaArquivo nomesEditados telefonesEditados
			putStrLn "Nome e telefone alterados com sucesso"
		else do 
			putStrLn "Alternativa inválida"
	else
		print "opcao invalida"
	main 
