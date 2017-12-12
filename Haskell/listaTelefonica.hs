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

adicionaContato:: [Int] -> [Int]
adicionaContato array = array ++ [1]
	

listaContato::[Int]
listaContato = do
	[]

buscaContato:: [Int]
buscaContato = do
	[]

listaGrupo:: [Int]
listaGrupo = do
	[]

chamadaEmergencia:: [Int]
chamadaEmergencia = do
	[]

listaContatosOrdenados::[Int]
listaContatosOrdenados = do
	[]
	
sair:: [Int]
sair = do
	[]

opcaoInvalida:: [Int] -> [Int]
opcaoInvalida array= do
	[]	

acoesMenu:: String -> [Int] -> [Int]
acoesMenu opcao array
	|opcao == "1" = adicionaContato array
	|otherwise = opcaoInvalida array
	
escolheAcoes::[Int] -> IO()	
escolheAcoes array = do
	printMenu
	opcao <- getLine
	let resposta = acoesMenu opcao array
	print array
	escolheAcoes resposta
main::IO()
main = do
	print "----- Lista Telefonica -----"
	escolheAcoes [] 
