

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

adicionaContato:: IO()
adicionaContato = do
	print "precisa fazer"

listaContato:: IO()
listaContato = do
	print "precisa fazer"

buscaContato:: IO()
buscaContato = do
	print "precisa fazer"

listaGrupo:: IO()
listaGrupo = do
	print "precisa fazer"

chamadaEmergencia:: IO()
chamadaEmergencia = do
	print "precisa fazer"

listaContatosOrdenados:: IO()
listaContatosOrdenados = do
	print "precisa fazer"
	
sair:: IO()
sair = do
	print "precisa fazer"

opcaoInvalida:: IO()
opcaoInvalida = do
	print "precisa fazer"	

acoesMenu:: String -> IO()
acoesMenu opcao
	|opcao == "1" = adicionaContato 
	|opcao == "2" = listaContato 
	|opcao == "3" = buscaContato 
	|opcao == "4" = listaGrupo
	|opcao == "5" = listaContatosOrdenados
	|opcao == "6" = chamadaEmergencia
	|opcao == "7" = sair
	|otherwise = opcaoInvalida
main::IO()
main = do
	print "----- Lista Telefonica -----"
	printMenu
	opcao <- getLine
	acoesMenu opcao
	main 
	
