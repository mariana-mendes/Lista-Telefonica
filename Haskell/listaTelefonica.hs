

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


main::IO()
main = do
	print "----- Lista Telefonica -----"
	printMenu
	opcao <- getLine
