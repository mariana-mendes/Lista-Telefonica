

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

adicionaContato:: [Int]
adicionaContato = do
	[]

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

opcaoInvalida:: [Int]
opcaoInvalida = do
	[]	

acoesMenu:: String -> [Int]
acoesMenu opcao
	|opcao == "1" = adicionaContato 
	|opcao == "2" = listaContato 
	|opcao == "3" = buscaContato 
	|opcao == "4" = listaGrupo
	|opcao == "5" = listaContatosOrdenados
	|opcao == "6" = chamadaEmergencia
	|opcao == "7" = sair
	|otherwise = opcaoInvalida
	
escolheAcoes::[Int] -> IO()	
escolheAcoes array = do
	printMenu
	opcao <- getLine
	let resposta = acoesMenu opcao
	escolheAcoes resposta
main::IO()
main = do
	print "----- Lista Telefonica -----"
	escolheAcoes [] 
	
