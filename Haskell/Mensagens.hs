module Mensagens(
	printOpcoes,
	menuEdicao,
	menuBloqueio,
	menuGrupo
) where


printOpcoes = do
	putStrLn "opcoes:"
	putStrLn "1. Adicionar Contato."
	putStrLn "2. Listar Contatos."
	putStrLn "3. Busca Contato."
	putStrLn "4. Excluir Contato."
	putStrLn "5. Bloquear Contato"
	putStrLn "6. Ordenar Contatos"
	putStrLn "7. Altera Contato"
	putStrLn "8. Chamar Contato"
	putStrLn "9. Adicionar Grupos"
	putStrLn "10. Adicionar Contato aos Favoritos"
	putStrLn "11. Exibe Favoritos"
	putStrLn "Digite sua opção: "

menuEdicao = do 
	putStrLn "Quais atributos deseja alterar?"
	putStrLn "1. Nome"
	putStrLn "2.Telefone"
	putStrLn "3.Nome e telefone"

menuBloqueio = do
	putStrLn "Deseja bloquear ou desbloquear o contato? "
	putStrLn "1.Bloquear"
	putStrLn "2.desbloquear"

menuGrupo = do
	putStrLn "Deseja:"
	putStrLn "1. Criar um novo grupo"
	putStrLn "2. Adicionar um contato a um grupo"
	putStrLn "3. Remover um grupo"
