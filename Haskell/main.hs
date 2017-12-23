
import System.IO
import Data.Char
import Data.List
import Data.List.Split
import System.Directory
import Agenda
import Mensagens

------------------------ LISTAR  -----------------------------------------
listaContatos = do
	n <- readFile "nomes.txt"
	t <- readFile "telefones.txt"
	b <- readFile "bloqueados.txt"	
	
	if(length (n) == 0) then do
		putStrLn "Nenhum contato adicionado"
	else do	

		let nomes =  Agenda.modelaArquivo n  "" []
		let telefones =  Agenda.modelaArquivo t "" []
		printar nomes telefones b
	
	
printar:: [String] -> [String] -> String-> IO()
printar [""] [""] x = putStrLn "fim"
printar	lista [""] x = putStrLn "fim"
printar [""] l x = putStrLn "fim"
printar (nome:restoNomes) (telefone:restoTelefones)(bloq:restobloq) = do 
	if([bloq] == "1") then do
		printar restoNomes restoTelefones restobloq
	else do
		putStrLn ("nome: " ++ nome)
		putStrLn ("telefone: " ++ telefone)
		printar restoNomes restoTelefones restobloq
	
------------------------------ BLOCK ---------------------------------------

bloqueaContato:: String -> [String] -> String -> String -> String
bloqueaContato nome [] []  x= ""
bloqueaContato nome [""] "" x= ""
bloqueaContato nome (x:nomes) (w:bloqueados) op
	|nome == x = op ++bloqueaContato nome nomes  bloqueados op
	|x == "" =  bloqueaContato nome nomes  bloqueados op
	|otherwise = [w] ++ bloqueaContato nome nomes  bloqueados op 




----------------------------- DELETE ------------------------------------------

getIndice :: String -> [String] -> Int ->  Int
getIndice n [] num= 0
getIndice n (nome:nomes) num = do
	if(n == nome) then do
		num
	else do
		getIndice n nomes num+1

sobrescreve :: IO()
sobrescreve  = do
	writeFile "nomes.txt" ("")
	writeFile "telefones.txt" ("")
	

atualizaArquivo :: [String] -> [String] -> IO()
atualizaArquivo [] [] = print "agenda atualizada"
atualizaArquivo [""] [""] = print "agenda atualizada"
atualizaArquivo [""] [] = print "agenda atualizada"
atualizaArquivo [] [""] = print "agenda atualizada"
atualizaArquivo (x:xs) (y:ys) = do
	Agenda.salvaContato x y
	atualizaArquivo xs ys
	
	
atualizaBloqueados:: String -> IO()
atualizaBloqueados nova = writeFile "bloqueados.txt" (nova)

---------------------------------GRUPOS------------------------------------------------------

criarGrupo :: String -> IO()
criarGrupo nome = writeFile (nome ++ ".txt")("")

adicionarContatoAGrupo :: String -> String -> IO()
adicionarContatoAGrupo nomeGrupo nomeContato = appendFile (nomeGrupo ++ ".txt") (nomeContato ++ "|")
	
----------------------------- CHAMAR CONTATO -------------------------------------------------
chamar :: String -> [String] -> String -> String
chamar n [""] "" = ""
chamar n lista "" = ""
chamar n [""] chms = ""
chamar n (nome:nomes) (ch:chmds) = do
	if(n /= nome) then do
		 [ch] ++ chamar n nomes chmds
	else do
		let resultado = (read [ch]) +1
		(show resultado) ++ (chamar n nomes chmds)
	

--------------------------- ADICIONA AOS FAVORITOS ----------------------------------------
addFavorito nome nomes telefones = do
	let n = (last(splitOn " " (show (nome `elemIndex` nomes))))
	let i = read n :: Int
	add nome (telefones!!i)
	
	
add::String -> String -> IO()
add nome telefone = do
	appendFile "favoritos.txt" (nome ++ "|" ++ telefone ++ "|")

verificaChamada :: String -> [String] -> [String] -> String -> IO()
verificaChamada  nome [""] [""] "" = putStrLn ""
verificaChamada nome (n:nomes) (t:telefones) "" = putStrLn ""
verificaChamada  nome [""] [""] (ch:chamadas) = putStrLn ""

verificaChamada nome (n:nomes) (t:telefones) (ch:chamadas) = do
	let resultado = (read [ch])
	if(resultado == 3 && nome == n) then do	
		putStrLn "Seu contato se tornou um favorito!"
		add n t	
	else do
		putStrLn ""
		verificaChamada nome nomes telefones chamadas



----------------------------- REMOVE DOS FAVORITOS ----------------------------------------

removeFavorito:: String -> [String] -> [String]
removeFavorito nome [] = []
removeFavorito nome favoritos = do
	let n = (last(splitOn " " (show (nome `elemIndex` favoritos))))
	let i = read n :: Int
	if (i> 0) then do
		take (i-1) favoritos ++ drop (i+1) favoritos
	else do
		drop 2 favoritos
		
reescreveFavoritos::[String] -> String
reescreveFavoritos [] = ""
reescreveFavoritos (f:fs) = do
	f ++ "|" ++ reescreveFavoritos fs
	
---------------------------- EXIBE FAVORITOS ----------------------------------------------
exibeFavoritos::[String] -> String
exibeFavoritos [] = ""
exibeFavoritos [""] = ""
exibeFavoritos (f:favs) = do
	let nome = "Nome: " ++ f ++ "   "
	let tel = "Telefone: " ++ (head favs) ++ "\n"
	nome ++ tel ++ exibeFavoritos (tail favs)
	
	
main = do
	Mensagens.printOpcoes
	opcao <-  getLine
	if(opcao== "1") then do
		putStrLn "Digite o nome do contato"
 		nome <- getLine
 		putStrLn "Digite o numero do contato"
 		numero <- getLine
 		appendFile "bloqueados.txt" ("0")
 		appendFile "chamadas.txt" ("0")
		Agenda.salvaContato nome numero
		
	else if ( opcao == "2") then do
		listaContatos
		
	else if((read opcao == 3)) then do
		putStrLn "Digite o nome do contato "
		nome <- getLine
		(x:xs) <- readFile "nomes.txt"
		(y:ys) <- readFile "telefones.txt"
		let nomes =  Agenda.modelaArquivo (x:xs) "" []
		let telefones =  Agenda.modelaArquivo (y:ys) "" []
		let index = getIndice nome nomes 0
		putStr "Nome: "
		putStrLn (nomes!!index)
		putStr "Telefone: "
		putStrLn (telefones!!index)
	
		
		
----------- DELETE ------------------		
	else if (opcao == "4") then do	
	
		---abrir arquivos para atualizar -----
		(x:xs) <- readFile "nomes.txt"
		(y:ys) <- readFile "telefones.txt"
		block <- readFile "bloqueados.txt"
		call <- readFile "chamadas.txt"
		
		
		putStrLn "Digite o nome do contato "
		nome <- getLine
		let nomes = Agenda.modelaArquivo (x:xs) "" []
		let telefones = Agenda.modelaArquivo (y:ys) "" []
		let index = getIndice nome nomes 0
			
		a <- removeFile "nomes.txt"
		b <- removeFile "telefones.txt"
		c <- removeFile "bloqueados.txt"
		d<- removeFile "chamadas.txt"
		sobrescreve 
		
		let n  = (take index nomes) ++ (drop (index+1) nomes)
		let m =  (take index telefones) ++ (drop (index+1) telefones)
		atualizaArquivo n m
		let b = (take index block) ++ (drop (index+1) block)
		let c = (take index call) ++ (drop (index+1) call)
		writeFile "bloqueados.txt" (b)
		writeFile "chamadas.txt" (c)
	
		print "Contato excluido"
		
		
----------- BLOCK ------------------		
	else if(opcao == "5") then do
		(x:xs) <- readFile "nomes.txt"
		bloq <- readFile "bloqueados.txt"
		let nomes =  Agenda.modelaArquivo (x:xs) "" []
		putStrLn "Digite o nome do contato "
		nome <- getLine
		Mensagens.menuBloqueio
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
		(y:ys) <- readFile "telefones.txt" 
		Agenda.ordenaContatos (x:xs) (y:ys)
		
		
-------------- EDITAR ------------------
	else if(opcao == "7") then do 
		putStrLn "Qual contato deseja alterar?"
		nomeContato <- getLine
	
		(x:xs) <- readFile "nomes.txt"
		let nomes =  Agenda.modelaArquivo (x:xs) "" []
		(y:ys) <- readFile "telefones.txt" 
		let telefones =  Agenda.modelaArquivo (y:ys) "" []
		Mensagens.menuEdicao
		alternativa <- getLine 
		let index = getIndice nomeContato nomes  0
---------------------- NOME -----------------
		
		if(alternativa == "1")then do 
			putStrLn "Digite o novo nome:"
			novoNome <- getLine 
			
			let novosContatos = (take index nomes) ++ [novoNome] ++(drop (index+1) nomes)
			a <- removeFile "nomes.txt"
		
			sobrescreve 
			atualizaArquivo novosContatos telefones
			putStrLn "Nome alterado com sucesso"
			
-------------- TELEFONE -----------------
			
		else if(alternativa == "2") then do 
			putStrLn "Digite o novo Telefone:"
			novoNumero <- getLine 
			let novosNumeros =  (take index telefones) ++ [novoNumero] ++(drop (index+1) telefones)

			b <- removeFile "telefones.txt"
			sobrescreve 
			atualizaArquivo nomes novosNumeros
			putStrLn "Telefone alterado com sucesso"
			
		---------- NOME E TELEFONE --------------	
		
		else if(alternativa == "3") then do 
			putStrLn "Digite o novo nome:"
			novoNome <- getLine 
			putStrLn "Digite o novo Telefone:"
			novoNumero <- getLine
			
			let novosNumeros =  (take index telefones) ++ [novoNumero] ++(drop (index+1) telefones)
			let novosContatos = (take index nomes) ++ [novoNome] ++(drop (index+1) nomes)
		 
			a <- removeFile "nomes.txt"
			b <- removeFile "telefones.txt"
		
			sobrescreve 
			atualizaArquivo novosContatos novosNumeros
			putStrLn "Nome e telefone alterados com sucesso"
		else do 
			putStrLn "Alternativa inválida"
			
	------------CHAMAR---------------------		
	else if(opcao == "8") then do
		contatos <- readFile "nomes.txt"
		chamadas <- readFile "chamadas.txt"
		t <- readFile "telefones.txt"
		let telefones = Agenda.modelaArquivo t "" []
		let loadNomes =  Agenda.modelaArquivo contatos  "" []
		
		putStrLn "Digite o nome do contato"
		nome <- getLine
		let novasChamadas = chamar nome loadNomes chamadas
		
		
		a <- removeFile "chamadas.txt"
		writeFile "chamadas.txt" (novasChamadas)
		
		n<-readFile "chamadas.txt"
		verificaChamada nome loadNomes telefones n
		print "Chamada Realizada"
		
	
	else if(opcao == "9") then do
		Mensagens.menuGrupo
			
		opcao <- getLine
		if (opcao == "1") then do
			putStrLn "Digite o nome do grupo:"
			nomeGrupo <- getLine
			criarGrupo nomeGrupo
		else if (opcao == "2") then do
			putStrLn "Digite o nome do contato:"
			nomeContato <- getLine
			putStrLn "Digite o nome do grupo:"
			nomeGrupo <- getLine
			(x:xs) <- readFile "nomes.txt"
			let nomes =  Agenda.modelaArquivo (x:xs) "" []
			if (nomeContato `elem` nomes) then do
				adicionarContatoAGrupo nomeGrupo nomeContato
			else
				print "Esse contato não existe"
	
		else
				print "not implemented"
	
	else if(opcao == "10") then do
		putStrLn "Digite o nome do contato"
		nome <- getLine
		n <- readFile "nomes.txt"
		let nomes =  Agenda.modelaArquivo n "" []
		f <- readFile "favoritos.txt"
		let favoritos =  Agenda.modelaArquivo f "" []
		t <- readFile "telefones.txt"
		let telefones =  Agenda.modelaArquivo t "" []
		if (nome `elem` favoritos) then do
			print "Esse contato ja esta nos seus favoritos"
		else if (nome `elem` nomes) then do
			addFavorito nome nomes telefones
			putStrLn "Contato adicionado com sucesso"
		else
			print "Esse contato nao existe"
	else if (opcao == "11") then do
		f <- readFile "favoritos.txt"
		let favoritos =  Agenda.modelaArquivo f "" []
		putStrLn "Favoritos"
		putStrLn (exibeFavoritos favoritos)
		
		else if (opcao == "12") then do
		putStrLn "Digite o nome do contato"
		nome <- getLine
		favs <- readFile "favoritos.txt"
		let favoritos = Agenda.modelaArquivo favs "" []
		if (nome `elem` favoritos) then do
			let novos = removeFavorito nome favoritos
			let t = length (reescreveFavoritos novos)
			writeFile "favoritos.txt" (take (t-1) (reescreveFavoritos novos))
			putStrLn "Favorito removido com sucesso"
		else 
			print "Esse contato nao esta em seus favoritos"
			
	else
		print "Invalida"
	main 
